using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.DataAccess.Interface;
using Titan.Common.DataAccess.Entities;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.Business.Implement
{
    /// <summary>
    /// 预约事件的业务逻辑层实现
    /// </summary>
    public class EventsLogic : BookSystemBaseEntityLogic<IEventsRepository, Events>, IEventsLogic
    {
        #region 构造函数
        /// <summary>
        /// 用于工厂实例化数据层实现类的构造函数
        /// </summary>
        /// <param name="repository">实现数据层接口的对象</param>
        public EventsLogic(IEventsRepository repository)
            : base(repository)
        {
        }
        #endregion

        #region 重写父类方法
        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="entity">欲添加的实体</param>
        /// <param name="status">操作状态</param>
        public override void Create(Events entity, out OperateStatus status)
        {
            base.Create(entity, out status);

            //将添加的数据放至相应位置，移动相应数据
            int sortIndex;
            EventsMoveParam param = new EventsMoveParam
            {
                EventId = entity.Id,
                PersonsId = entity.PersonsId,
                TargetStatus = (int)EventStatus.Interrupt,
                Modifier = entity.Creator,
                DateModified = entity.DateCreated
            };
            GetMaxSortIndex(param, out sortIndex);

            param.TargetStatus = (int)EventStatus.Wait;
            param.TargetSortIndex = sortIndex + 1;
            MoveEvent(param, out status);
        }

        /// <summary>
        /// 更新方法
        /// </summary>
        /// <param name="entity">欲更新的实体</param>
        /// <param name="status">操作状态</param>
        public override void Update(Events entity, out OperateStatus status)
        {
            var oldEvent = GetById(entity.Id);

            oldEvent.PlanWorkTime = entity.PlanWorkTime;
            oldEvent.Describe = entity.Describe;
            oldEvent.Modifier = entity.Modifier;
            oldEvent.DateModified = entity.DateModified;

            if (entity.Status == (int)EventStatus.Finished)
            {
                oldEvent.Status = entity.Status;
                MoveOutEvent(oldEvent, out status);
            }
            else
            {
                base.Update(oldEvent, out status);
                //判断状态是否发生改变
                if (oldEvent.Status != entity.Status)
                {
                    int sortIndex;
                    EventsMoveParam param = new EventsMoveParam
                    {
                        EventId = entity.Id,
                        PersonsId = entity.PersonsId,
                        TargetStatus = entity.Status,
                        Modifier = entity.Modifier,
                        DateModified = entity.DateModified
                    };
                    GetMaxSortIndex(param, out sortIndex);

                    int currentSortIndex = oldEvent.SortIndex.HasValue ? oldEvent.SortIndex.Value : int.MaxValue;
                    param.TargetSortIndex = currentSortIndex > sortIndex ? sortIndex + 1 : sortIndex;

                    MoveEvent(param, out status);

                }
            }
        }
        #endregion

        #region 实现接口
        /// <summary>
        /// 删除方法
        /// </summary>
        /// <param name="entity">欲删除的数据实体，包括Id和修改时间和修改人</param>
        /// <param name="status">操作状态</param>
        public void Delete(Events entity, out OperateStatus status)
        {
            var events = GetById(entity.Id);

            events.Modifier = entity.Modifier;
            events.DateModified = entity.DateModified;
            events.State = (int)StateSign.Deleted;

            if (events.SortIndex.HasValue)
            {
                MoveOutEvent(events, out status);
            }
            else
            {
                base.Update(events, out status);
            }
        }

        /// <summary>
        /// 返回所有高级查询的结果
        /// </summary>
        /// <typeparam name="TQueryParam">AdvQueryParam类型查询参数</typeparam>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>满足条件的所有结果集</returns>
        public IList<Events> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam
        {
            return Repository.GetAdvQueryAll(queryParam);
        }

        /// <summary>
        /// 移动预约事件
        /// </summary>
        /// <param name="param">当前事件信息，需要Id、当前SortIndex，如果需要改变状态，可以传入Status</param>
        /// <param name="status">操作状态</param>
        public void MoveEvent(EventsMoveParam param, out OperateStatus status)
        {
            var oldEvent = GetById(param.EventId);
            if (param.TargetSortIndex.HasValue)
            {
                try
                {
                    bool IsMoveUp = true;
                    int largerIndex = int.MaxValue;
                    int smallerIndex = int.MinValue;

                    //确认是将事件提前还是延后
                    if (oldEvent.SortIndex.HasValue)
                    {
                        IsMoveUp = param.TargetSortIndex.Value < oldEvent.SortIndex.Value ? true : false;
                        largerIndex = IsMoveUp ? oldEvent.SortIndex.Value : param.TargetSortIndex.Value;
                        smallerIndex = IsMoveUp ? param.TargetSortIndex.Value : oldEvent.SortIndex.Value;
                    }
                    else
                    {
                        smallerIndex = param.TargetSortIndex.Value;
                    }

                    int movestep = IsMoveUp ? 1 : -1;

                    //查找受影响的数据
                    var lists = Repository.GetAdvQueryAll(new EventsQueryParam()
                    {
                        PersonsId = oldEvent.PersonsId,
                        HasFinished = false
                    }).Where(p => (p.SortIndex >= smallerIndex
                        && p.SortIndex <= largerIndex
                        && p.SortIndex != oldEvent.SortIndex) || p.SortIndex == param.TargetSortIndex - movestep)
                        .ToList();

                    //判断移动时是否需要更新数据状态
                    if (param.TargetStatus.HasValue)
                    {
                        //状态更新时数据移动，调用该移动方法时会进入此条件
                        oldEvent.Status = param.TargetStatus.Value;
                        oldEvent.Modifier = param.Modifier;
                        oldEvent.DateModified = param.DateModified;
                    }
                    else
                    {
                        //根据移动位置判断是否需要改变状态
                        var targetStatus = lists.Where(p => p.SortIndex == param.TargetSortIndex - movestep
                            || p.SortIndex == param.TargetSortIndex).Select(p => p.Status).ToList();
                        if (targetStatus.Count() < 2
                            || (targetStatus.Count() == 2
                            && (targetStatus[0] == targetStatus[1]) || oldEvent.Status == (int)EventStatus.Finished))
                        {
                            oldEvent.Status = targetStatus.FirstOrDefault();
                            oldEvent.Modifier = param.Modifier;
                            oldEvent.DateModified = param.DateModified;
                        }
                    }

                    //移除判断状态项
                    lists = lists.Where(p => p.SortIndex != param.TargetSortIndex - movestep).ToList();

                    MoveEvents(lists, oldEvent, movestep, param.TargetSortIndex, out status);
                }
                catch (Exception ex)
                {
                    status = new OperateStatus() { ResultSign = ResultSign.Failed, Message = ex.Message };
                }
            }
            else //拖动任务至完成列表，任务完成
            {
                oldEvent.Status = (int)EventStatus.Finished;
                oldEvent.Modifier = param.Modifier;
                oldEvent.DateModified = param.DateModified;

                MoveOutEvent(oldEvent, out status);
            }
        }
        #endregion

        /// <summary>
        /// 获取所需的最大索引
        /// </summary>
        /// <param name="param">当前事件信息，需要PersonsId，如果需要改变状态，可以传入Status</param>
        /// <param name="sortIndex">排序索引</param>
        protected void GetMaxSortIndex(EventsMoveParam param, out int sortIndex)
        {
            if (param.TargetStatus == (int)EventStatus.Processing)
            {
                sortIndex = 0;
                return;
            }

            var events = Repository.GetAdvQueryAll(new EventsQueryParam()
            {
                PersonsId = param.PersonsId,
                HasFinished = false,
                Status = param.TargetStatus + 1
            }
                ).Where(p => p.SortIndex.HasValue).ToList();
            if (events != null && events.Count != 0)
            {
                //查找当队列中索引的最大值
                int maxIndex = events.Max(p => p.SortIndex.Value);

                sortIndex = maxIndex;
            }
            //查找下一状态值是否有的有效索引
            else
            {
                param.TargetStatus++;
                GetMaxSortIndex(param, out sortIndex);
            }
        }

        /// <summary>
        /// 将事件移除任务列表
        /// </summary>
        /// <param name="entity">欲移出的事件，需要PersonsId和SortIndex</param>
        /// <param name="status">操作状态</param>
        protected void MoveOutEvent(Events entity, out OperateStatus status)
        {
            //获取受影响的数据
            var lists = Repository.GetAdvQueryAll(new EventsQueryParam()
            {
                PersonsId = entity.PersonsId,
                HasFinished = false
            }).Where(p => p.SortIndex > entity.SortIndex);

            MoveEvents(lists, entity, -1, null, out status);
        }

        /// <summary>
        /// 预约事件移动方法
        /// </summary>
        /// <param name="lists">欲移动的数据集合，不包含当前数据</param>
        /// <param name="entity">当前数据</param>
        /// <param name="moveStep">移动步长</param>
        /// <param name="sortIndex">当前数据移动到的索引（可空）</param>
        /// <param name="status">操作状态</param>
        protected void MoveEvents(IEnumerable<Events> lists, Events entity, int moveStep, int? sortIndex, out OperateStatus status)
        {
            try
            {
                using (System.Transactions.TransactionScope trans = new System.Transactions.TransactionScope())
                {
                    //将后续数据前移
                    foreach (var item in lists)
                    {
                        item.SortIndex += moveStep;
                        base.Update(item, out status);
                        if (status.ResultSign != ResultSign.Success)
                        {
                            throw new Exception("移动当前项相关项目时出错，错误信息：" + status.Message);
                        }
                    }

                    entity.SortIndex = sortIndex;
                    base.Update(entity, out status);
                    if (status.ResultSign != ResultSign.Success)
                    {
                        throw new Exception(status.Message);
                    }
                    trans.Complete();
                }
            }
            catch (Exception ex)
            {
                status = new OperateStatus() { ResultSign = ResultSign.Failed, Message = ex.Message };
            }
        }
    }
}

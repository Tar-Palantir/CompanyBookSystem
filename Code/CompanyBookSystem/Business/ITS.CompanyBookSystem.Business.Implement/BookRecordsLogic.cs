using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.DataAccess.Interface;
using ITS.CompanyBookSystem.Business.Interface;
using Titan.Common.DataStatus;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.Business.Implement
{
    /// <summary>
    /// 预订记录业务逻辑层实现
    /// </summary>
    public class BookRecordsLogic : BookSystemBaseEntityLogic<IBookRecordsRepository, BookRecords>, IBookRecordsLogic
    {
        #region 构造函数
        /// <summary>
        /// 用于工厂实例化数据层实现类的构造函数
        /// </summary>
        /// <param name="repository">实现数据层接口的对象</param>
        public BookRecordsLogic(IBookRecordsRepository repository)
            : base(repository)
        {
        }
        #endregion

        #region 重写父方法
        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="entity">欲添加的实体</param>
        /// <param name="status">操作状态</param>
        public override void Create(BookRecords entity, out OperateStatus status)
        {
            if (IsTimeOverlapping(entity))
            {
                status = new OperateStatus() { ResultSign = ResultSign.Failed, Message = "对不起，该时间段内已有其他预订。" };
                return;
            }
            base.Create(entity, out status);
        }

        /// <summary>
        /// 更新方法
        /// </summary>
        /// <param name="entity">欲更新的数据</param>
        /// <param name="status">操作状态</param>
        public override void Update(BookRecords entity, out OperateStatus status)
        {
            if (IsTimeOverlapping(entity))
            {
                status = new OperateStatus() { ResultSign = ResultSign.Failed, Message = "对不起，该时间段内已有其他预订。" };
                return;
            }
            base.Update(entity, out status);
        }
        #endregion

        #region 实现接口
        /// <summary>
        /// 返回所有高级查询的结果
        /// </summary>
        /// <typeparam name="TQueryParam">AdvQueryParam类型查询参数</typeparam>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>满足条件的所有结果集</returns>
        public IList<BookRecords> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam
        {
            return Repository.GetAdvQueryAll(queryParam);
        }
        #endregion

        #region 扩展方法

        /// <summary>
        /// 是否时间重叠
        /// </summary>
        /// <param name="entity">判断的对象</param>
        /// <returns>重叠返回true，否则返回false</returns>
        public virtual bool IsTimeOverlapping(BookRecords entity)
        {
            BookRecordQueryParam param = new BookRecordQueryParam()
            {
                BookObjectId = entity.BookObjectId,
                StartDate = entity.StartDate,
                EndDate = entity.EndDate
            };
            IList<BookRecords> records = GetAdvQueryAll(param);

            if (records == null)
            {
                return false;
            }
            else
            {
                if (entity.Id != Guid.Empty)
                {
                    records.Remove(records.FirstOrDefault(p => p.Id == entity.Id));
                }
                if (records.Count == 0)
                {
                    return false;
                }
                else
                {
                    if (entity.StartTime.ToString("HH:mm") == "00:00" && entity.EndTime.ToString("HH:mm") == "00:00")
                    {
                        return true;
                    }
                    DateTime start = entity.StartDate.Date + entity.StartTime.TimeOfDay;
                    DateTime end = entity.EndDate.Date + entity.EndTime.TimeOfDay;
                    foreach (var record in records)
                    {
                        DateTime recordStart = record.StartDate.Date + record.StartTime.TimeOfDay;
                        DateTime recordEnd = record.EndDate.Date + record.EndTime.TimeOfDay;
                        if ((recordStart < end && recordStart >= start)
                                || (recordEnd > start && recordStart <= start))
                        {
                            return true;
                        }
                    }

                    return false;
                }
            }
        }

        #endregion
    }
}

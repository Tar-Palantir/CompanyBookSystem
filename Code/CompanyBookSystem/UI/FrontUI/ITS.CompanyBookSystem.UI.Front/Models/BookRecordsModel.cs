using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.Business.Interface;
using Titan.Common.DataAccess.Entities;
using System.Transactions;
using Titan.Common.DataStatus;
using System.Text;

namespace ITS.CompanyBookSystem.UI.Front.Models
{
    /// <summary>
    /// 预订记录模型
    /// </summary>
    public class BookRecordsModel : BookSystemBaseModel<IBookRecordsLogic, BookRecords>
    {
        #region 重写父方法
        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="entity">预订记录实体</param>
        /// <param name="status">操作状态</param>
        public override void Create(BookRecords entity, out OperateStatus status)
        {
            status = new OperateStatus();
            if (entity.CircleMode != (int)EnumCircleMode.None)
            {
                try
                {
                    Guid relevanceId = Guid.NewGuid();
                    BookRecords record = new BookRecords();
                    using (TransactionScope tran = new TransactionScope())
                    {
                        if (entity.CircleMode != (int)EnumCircleMode.Month)
                        {
                            int i = 0;
                            int step = 1;
                            if (entity.CircleMode == (int)EnumCircleMode.Week)
                            {
                                int lag = entity.CircleDayOrWeek - (int)entity.StartDate.DayOfWeek;
                                i = lag >= 0 ? lag : 7 + lag;
                                step = 7;
                            }
                            do
                            {
                                record = new BookRecords()
                                {
                                    RelevanceId = relevanceId,
                                    BookObjectId = entity.BookObjectId,
                                    Creator = entity.Creator,
                                    OperateComputerIP = entity.OperateComputerIP,
                                    DepartmentId = entity.DepartmentId,
                                    Describe = entity.Describe,
                                    Tel = entity.Tel,
                                    DateCreated = entity.DateCreated,
                                    StartDate = entity.StartDate.AddDays(i),
                                    EndDate = entity.StartDate.AddDays(i),
                                    StartTime = entity.StartTime,
                                    EndTime = entity.EndTime
                                };
                                if (record.StartDate.Date > entity.EndDate.Date)
                                {
                                    throw new Exception("日期范围内无可用预订");
                                }
                                base.Create(record, out status);
                                i += step;

                                if (status.ResultSign != ResultSign.Success) throw new Exception(status.Message);
                            } while (record.StartDate.AddDays(step).Date <= entity.EndDate.Date);
                        }
                        else
                        {
                            int i = entity.StartDate.Day < entity.CircleDayOrWeek ? 1 : 0;
                            DateTime newDate = new DateTime(entity.StartDate.Year, entity.StartDate.Month, entity.CircleDayOrWeek);
                            do
                            {
                                record = new BookRecords()
                                {
                                    RelevanceId = relevanceId,
                                    BookObjectId = entity.BookObjectId,
                                    Creator = entity.Creator,
                                    OperateComputerIP = entity.OperateComputerIP,
                                    DepartmentId = entity.DepartmentId,
                                    Describe = entity.Describe,
                                    Tel = entity.Tel,
                                    DateCreated = entity.DateCreated,
                                    StartDate = newDate.AddMonths(i),
                                    EndDate = newDate.AddMonths(i),
                                    StartTime = entity.StartTime,
                                    EndTime = entity.EndTime
                                };
                                if (record.StartDate.Date > entity.EndDate.Date)
                                {
                                    throw new Exception("日期范围内无可用预订");
                                }
                                base.Create(record, out status);
                                i++;

                                if (status.ResultSign != ResultSign.Success) throw new Exception(status.Message);
                            } while (record.StartDate.AddMonths(1).Date <= entity.EndDate.Date);
                        }

                        tran.Complete();
                    }
                }
                catch (Exception ex)
                {
                    status = new OperateStatus() { ResultSign = ResultSign.Failed, Message = ex.Message };
                }
            }
            else
            {
                base.Create(entity, out status);
            }
        }

        /// <summary>
        /// 更新方法
        /// </summary>
        /// <param name="entity">欲更新的预订记录实体</param>
        /// <param name="status">操作状态</param>
        public override void Update(BookRecords entity, out OperateStatus status)
        {
            status = new OperateStatus();
            if (entity.RelevanceId.HasValue && entity.RelevanceId.Value != Guid.Empty)
            {
                try
                {
                    var records = BusinessLogic.GetAdvQueryAll(new BookRecordQueryParam() { RelevanceId = entity.RelevanceId.Value });

                    using (TransactionScope tran = new TransactionScope())
                    {
                        foreach (var record in records)
                        {
                            record.StartTime = entity.StartTime;
                            record.EndTime = entity.EndTime;
                            record.Tel = entity.Tel;
                            record.Describe = entity.Describe;
                            record.DateModified = entity.DateModified;
                            record.Modifier = entity.OperateComputerIP;

                            base.Update(record, out status);

                            if (status.ResultSign != ResultSign.Success) throw new Exception(status.Message);
                        }
                        tran.Complete();
                    }
                }
                catch (Exception ex)
                {
                    status = new OperateStatus() { ResultSign = ResultSign.Failed, Message = ex.Message };
                }
            }
            else
            {
                var record = BusinessLogic.GetById(entity.Id);

                record.StartTime = entity.StartTime;
                record.EndTime = entity.EndTime;
                record.Tel = entity.Tel;
                record.Describe = entity.Describe;
                record.DateModified = entity.DateModified;
                record.Modifier = entity.OperateComputerIP;

                base.Update(record, out status);
            }
        }
        #endregion

        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <param name="currentIP">当前用户的IP地址</param>
        /// <returns>分页后的查询结果</returns>
        public IList<Event> GetAdvQueryAll(BookRecordQueryParam param, string currentIP)
        {
            var records = BusinessLogic.GetAdvQueryAll(param);
            IList<Event> results = new List<Event>();
            Event currentEvent;
            foreach (var record in records)
            {
                currentEvent = new Event()
                {
                    id = record.Id,
                    recordObjectId = record.BookObjectId.ToString(),
                    relevanceId = record.RelevanceId,
                    isEditable = currentIP == record.OperateComputerIP,
                    title = string.Format("创建人：{0} 描述：{1}", record.Creator, record.Describe),
                    className = "wordbreak"
                };
                //判断样式，无样式的显示默认
                if (record.BookObject.ObjectStyle != null)
                {
                    currentEvent.backgroundColor = record.BookObject.ObjectStyle.BackgroundColor;
                    currentEvent.borderColor = record.BookObject.ObjectStyle.BorderColor;
                    currentEvent.textColor = record.BookObject.ObjectStyle.TextColor;
                }

                //全天的
                if (record.StartTime.ToString("HH:mm") == "00:00"
                    && record.EndTime.ToString("HH:mm") == "00:00")
                {
                    currentEvent.start = record.StartDate.ToString("yyyy-MM-ddTHH:mm:ssZ");
                    currentEvent.end = record.EndDate.ToString("yyyy-MM-ddTHH:mm:ssZ");
                    currentEvent.allDay = true;
                }
                else//其余的
                {
                    currentEvent.start = (record.StartDate.Date + record.StartTime.TimeOfDay).ToString("yyyy-MM-ddTHH:mm:ssZ");
                    currentEvent.end = (record.EndDate.Date + record.EndTime.TimeOfDay).ToString("yyyy-MM-ddTHH:mm:ssZ");
                    currentEvent.allDay = false;
                }
                results.Add(currentEvent);
            }
            return results;
        }

        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public PagedResults<BookRecords> AdvQuery(BookRecordQueryParam param)
        {
            return BusinessLogic.AdvQuery(param);
        }

        /// <summary>
        /// 根据Id获取详细信息
        /// </summary>
        /// <param name="id">记录Id</param>
        /// <returns>信息</returns>
        public BookRecordResult GetDetailById(Guid id)
        {
            BookRecords record = BusinessLogic.GetById(id);
            BookRecordResult result = new BookRecordResult()
            {
                Id = record.Id,
                RelevanceId = record.RelevanceId,
                BookObjectName = record.BookObject.Name,
                StartDate = record.StartDate,
                StartTime = record.StartTime,
                EndDate = record.EndDate,
                EndTime = record.EndTime,
                Describe = record.Describe,
                DepartmentId = record.DepartmentId,
                DepartmentName = record.Departments.Name,
                Tel = record.Tel,
                Creator = record.Creator,
                DateCreated = record.DateCreated,
                Modifier = record.Modifier,
                DateModified = record.DateModified
            };
            if (record.RelevanceId.HasValue && record.RelevanceId.Value != Guid.Empty)
            {
                IList<BookRecords> relevanceRecords = BusinessLogic
                    .GetAdvQueryAll(new BookRecordQueryParam() { RelevanceId = record.RelevanceId })
                    .OrderBy(p => p.StartDate).ThenBy(p => p.StartTime).ToList();
                StringBuilder relevanceRecordsStr = new StringBuilder();
                foreach (var relevanceRecord in relevanceRecords)
                {
                    relevanceRecordsStr.AppendLine(string.Format("{0} {1} 到 {2}",
                        relevanceRecord.StartDate.ToString("yyyy年MM月dd日 dddd", new System.Globalization.CultureInfo("zh-cn")),
                        relevanceRecord.StartTime.ToString("HH:mm"),
                        relevanceRecord.EndTime.ToString("HH:mm")));
                }
                result.RelevanceRecords = relevanceRecordsStr.ToString();
            }
            return result;
        }
    }
}
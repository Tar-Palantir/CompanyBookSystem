using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.Business.Interface;
using Titan.Common.DataAccess.Entities;
using System.Text;
using System.Transactions;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.UI.BehindUI.Models
{
    /// <summary>
    /// 预订记录模型
    /// </summary>
    public class BookRecordsModel : BookSystemBaseModel<IBookRecordsLogic, BookRecords>
    {
        #region 重写父类方法
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
        /// <returns>分页后的查询结果</returns>
        public PagedResults<BookRecordResult> AdvQuery(BookRecordQueryParam param)
        {
            PagedResults<BookRecordResult> results = new PagedResults<BookRecordResult>();
            var records = BusinessLogic.AdvQuery(param);
            results.Data = records.Data.Select(p => new BookRecordResult()
            {
                Id = p.Id,
                RelevanceId = p.RelevanceId,
                BookObjectName = p.BookObject.Name,
                StartDate = p.StartDate,
                StartTime = p.StartTime,
                EndDate = p.EndDate,
                EndTime = p.EndTime,
                Describe = p.Describe,
                DepartmentName = p.Departments.Name,
                Tel = p.Tel,
                Creator = p.Creator,
                DateCreated = p.DateCreated,
                Modifier = p.Modifier,
                DateModified = p.DateModified
            }).ToList();
            results.PagerInfo = records.PagerInfo;
            return results;
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
                relevanceRecordsStr.AppendLine("相关使用时间：");
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataStatus;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Implement
{
    /// <summary>
    /// 预订记录数据访问层实现
    /// </summary>
    public class BookRecordsRepository : BookSystemBaseRepository<BookRecords>, IBookRecordsRepository
    {
        #region 重写父类方法
        /// <summary>
        /// 实体对象集合（查询）
        /// </summary>
        protected override System.Data.Entity.Infrastructure.DbQuery<BookRecords> ObjectQuery
        {
            get
            {
                return base.ObjectQuery.Include("BookObject").Include("BookObject.ObjectStyle").Include("Departments");
            }
        }

        /// <summary>
        /// 获取高级查询集
        /// </summary>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>高级查询集</returns>
        protected override IQueryable<BookRecords> GetAdvQuery<TQueryParam>(TQueryParam queryParam)
        {
            BookRecordQueryParam bookRecordQueryParam = queryParam as BookRecordQueryParam;
            var query = base.GetAdvQuery<TQueryParam>(queryParam).Where(p => p.State == (int)StateSign.Normal)
                .Where(p => p.BookObject.State == (int)StateSign.Normal)
                .Where(p => p.Departments.State == (int)StateSign.Normal);

            if (bookRecordQueryParam == null)
            {
                return query;
            }
            else
            {
                //相关联Id
                if (bookRecordQueryParam.RelevanceId.HasValue && bookRecordQueryParam.RelevanceId.Value != Guid.Empty)
                {
                    query = query.Where(p => p.RelevanceId == bookRecordQueryParam.RelevanceId.Value);
                }
                //预订对象Id
                if (bookRecordQueryParam.BookObjectId.HasValue && bookRecordQueryParam.BookObjectId.Value != Guid.Empty)
                {
                    query = query.Where(p => p.BookObjectId == bookRecordQueryParam.BookObjectId.Value);
                }
                //预订对象类型Id
                if (bookRecordQueryParam.TypeId.HasValue && bookRecordQueryParam.TypeId.Value != Guid.Empty)
                {
                    query = query.Where(p => p.BookObject.BookObjectTypeId == bookRecordQueryParam.TypeId.Value);
                }
                //部门Id
                if (bookRecordQueryParam.DepartmentId.HasValue && bookRecordQueryParam.DepartmentId.Value != Guid.Empty)
                {
                    query = query.Where(p => p.DepartmentId == bookRecordQueryParam.DepartmentId.Value);
                }
                //开始日期
                if (bookRecordQueryParam.StartDate.HasValue)
                {
                    query = query.Where(p => p.EndDate >= bookRecordQueryParam.StartDate.Value);
                }
                //结束日期
                if (bookRecordQueryParam.EndDate.HasValue)
                {
                    query = query.Where(p => p.StartDate <= bookRecordQueryParam.EndDate.Value);
                }
                //描述
                if (!string.IsNullOrEmpty(bookRecordQueryParam.Value))
                {
                    query = query.Where(p => p.Describe.Contains(bookRecordQueryParam.Value));
                }

                return query;
            }
        }

        #endregion

        #region 扩展方法
        /// <summary>
        /// 返回所有高级查询的结果
        /// </summary>
        /// <typeparam name="TQueryParam">AdvQueryParam类型查询参数</typeparam>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>满足条件的所有结果集</returns>
        public virtual IList<BookRecords> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam
        {
            return GetAdvQuery(queryParam as AdvQueryParam).ToList();
        }
        #endregion
    }
}

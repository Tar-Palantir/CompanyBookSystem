using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Implement;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.DataAccess.Interface;
using Titan.Common.DataAccess.Entities;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.DataAccess.Implement
{
    /// <summary>
    /// 预订对象数据访问层实现
    /// </summary>
    public class BookObjectRepository : BookSystemBaseRepository<BookObject>, IBookObjectRepository
    {
        #region 重写父类方法
        /// <summary>
        /// 实体对象集合（查询）
        /// </summary>
        protected override System.Data.Entity.Infrastructure.DbQuery<BookObject> ObjectQuery
        {
            get
            {
                return base.ObjectQuery.Include("BookObjectType").Include("ObjectStyle");
            }
        }

        /// <summary>
        /// 获取高级查询集
        /// </summary>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>高级查询集</returns>
        protected override IQueryable<BookObject> GetAdvQuery<TQueryParam>(TQueryParam queryParam)
        {
            BookObjectQueryParam bookObjectQueryParam = queryParam as BookObjectQueryParam;
            var query = base.GetAdvQuery<TQueryParam>(queryParam).Where(p => p.State == (int)StateSign.Normal)
                .Where(p => p.BookObjectType.State == (int)StateSign.Normal);

            if (bookObjectQueryParam == null)
            {
                return query;
            }
            else
            {
                if (!string.IsNullOrEmpty(bookObjectQueryParam.Name))
                {
                    query = query.Where(p => p.Name.Contains(bookObjectQueryParam.Name));
                }
                if (bookObjectQueryParam.TypeId.HasValue && bookObjectQueryParam.TypeId.Value != Guid.Empty)
                {
                    query = query.Where(p => p.BookObjectTypeId == bookObjectQueryParam.TypeId.Value);
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
        public virtual IList<BookObject> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam
        {
            return GetAdvQuery(queryParam as AdvQueryParam).ToList();
        }
        #endregion
    }
}

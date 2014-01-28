using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.DataAccess.Interface;
using Titan.Common.DataStatus;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Implement
{
    /// <summary>
    /// 预约事件的数据访问层实现
    /// </summary>
    public class EventsRepository : BookSystemBaseRepository<Events>, IEventsRepository
    {
        #region 重写父类方法
        /// <summary>
        /// 实体对象集合（查询）
        /// </summary>
        protected override System.Data.Entity.Infrastructure.DbQuery<Events> ObjectQuery
        {
            get
            {
                return base.ObjectQuery.Include("Persons").Include("Departments");
            }
        }

        /// <summary>
        /// 获取高级查询集
        /// </summary>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>高级查询集</returns>
        protected override IQueryable<Events> GetAdvQuery<TQueryParam>(TQueryParam queryParam)
        {
            EventsQueryParam eventsQueryParam = queryParam as EventsQueryParam;
            var query = base.GetAdvQuery<TQueryParam>(queryParam).Where(p => p.State == (int)StateSign.Normal)
                .Where(p => p.Persons.State == (int)StateSign.Normal)
                .Where(p => p.Departments.State == (int)StateSign.Normal);

            if (eventsQueryParam == null)
            {
                return query;
            }
            else
            {
                if (eventsQueryParam.PersonsId.HasValue && eventsQueryParam.PersonsId.Value != Guid.Empty)
                {
                    query = query.Where(p => p.PersonsId == eventsQueryParam.PersonsId);
                }
                if (!string.IsNullOrEmpty(eventsQueryParam.Title))
                {
                    query = query.Where(p => p.Title.Contains(eventsQueryParam.Title));
                }
                if (eventsQueryParam.HasFinished.HasValue)
                {
                    if (eventsQueryParam.HasFinished.Value)
                    {
                        query = query.Where(p => p.Status == (int)EventStatus.Finished);
                    }
                    else
                    {
                        query = query.Where(p => p.Status != (int)EventStatus.Finished);
                    }
                }
                if (eventsQueryParam.Status.HasValue)
                {
                    query = query.Where(p => p.Status == (int)eventsQueryParam.Status.Value);
                }
                return query;
            }
        }

        public override PagedResults<Events> AdvQuery<TQueryParam>(TQueryParam queryParam)
        {
            var results = GetAdvQuery<TQueryParam>(queryParam).ToPagedResults(queryParam);
            return results;
        }

        #endregion

        #region 扩展方法
        /// <summary>
        /// 返回所有高级查询的结果
        /// </summary>
        /// <typeparam name="TQueryParam">AdvQueryParam类型查询参数</typeparam>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>满足条件的所有结果集</returns>
        public virtual IList<Events> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam
        {
            return GetAdvQuery(queryParam as AdvQueryParam).OrderBy(p => p.SortIndex).ToList();
        }
        #endregion
    }
}

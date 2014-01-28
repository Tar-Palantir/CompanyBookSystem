using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Entities;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.DataAccess.Implement
{
    /// <summary>
    /// 预约人员数据访问层实现
    /// </summary>
    public class PersonsRepository : BookSystemBaseRepository<Persons>, IPersonsRepository
    {
        #region 重写父类方法
        /// <summary>
        /// 实体对象集合（查询）
        /// </summary>
        protected override System.Data.Entity.Infrastructure.DbQuery<Persons> ObjectQuery
        {
            get
            {
                return base.ObjectQuery.Include("Departments");
            }
        }

        /// <summary>
        /// 获取高级查询集
        /// </summary>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>高级查询集</returns>
        protected override IQueryable<Persons> GetAdvQuery<TQueryParam>(TQueryParam queryParam)
        {
            PersonsQueryParam personsQueryParam = queryParam as PersonsQueryParam;
            var query = base.GetAdvQuery<TQueryParam>(queryParam).Where(p => p.State == (int)StateSign.Normal)
                .Where(p => p.Departments.State == (int)StateSign.Normal);

            if (personsQueryParam == null)
            {
                return query;
            }
            else
            {
                if (!string.IsNullOrEmpty(personsQueryParam.Name))
                {
                    query = query.Where(p => p.Name.Contains(personsQueryParam.Name));
                }
                if (personsQueryParam.DepartmentId.HasValue && personsQueryParam.DepartmentId.Value != Guid.Empty)
                {
                    query = query.Where(p => p.DepartmentId == personsQueryParam.DepartmentId.Value);
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
        public virtual IList<Persons> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam
        {
            return GetAdvQuery(queryParam as AdvQueryParam).ToList();
        }
        #endregion
    }
}

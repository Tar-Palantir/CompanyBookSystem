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
    /// 部门数据访问层实现
    /// </summary>
    public class DepartmentsRepository : BookSystemBaseRepository<Departments>, IDepartmentsRepository
    {
        #region 重写父类方法
        /// <summary>
        /// 获取快速查询集
        /// </summary>
        /// <param name="queryParam">快速查询参数</param>
        /// <returns>快速查询集</returns>
        protected override IQueryable<Departments> GetQuickQuery(QuickQueryParam queryParam)
        {
            var query = base.GetQuickQuery(queryParam).Where(p => p.State == (int)StateSign.Normal);

            if (queryParam == null)
            {
                return query;
            }
            else
            {
                if (!string.IsNullOrEmpty(queryParam.Value))
                {
                    query = query.Where(p => p.Name.Contains(queryParam.Value));
                }
                return query;
            }
        }

        #endregion
    }
}

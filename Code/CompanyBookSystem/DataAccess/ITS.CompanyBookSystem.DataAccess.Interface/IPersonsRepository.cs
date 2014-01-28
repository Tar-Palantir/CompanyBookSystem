using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Interface
{
    /// <summary>
    /// 预约人员数据访问接口层
    /// </summary>
    public interface IPersonsRepository : IRepository<Persons>
    {
        /// <summary>
        /// 返回所有高级查询的结果
        /// </summary>
        /// <typeparam name="TQueryParam">AdvQueryParam类型查询参数</typeparam>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>满足条件的所有结果集</returns>
        IList<Persons> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam;
    }
}

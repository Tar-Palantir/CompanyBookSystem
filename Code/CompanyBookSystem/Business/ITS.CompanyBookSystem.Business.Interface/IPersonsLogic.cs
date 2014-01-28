using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.Business.Interface
{
    /// <summary>
    /// 预约人员业务逻辑层接口
    /// </summary>
    public interface IPersonsLogic : IEntityBaseLogic<Persons>
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

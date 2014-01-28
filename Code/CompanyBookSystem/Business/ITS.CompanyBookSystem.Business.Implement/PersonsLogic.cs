using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.DataAccess.Interface;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.Business.Implement
{
    /// <summary>
    /// 预约人员业务逻辑层实现
    /// </summary>
    public class PersonsLogic : BookSystemBaseEntityLogic<IPersonsRepository, Persons>, IPersonsLogic
    {
        #region 构造函数
        /// <summary>
        /// 用于工厂实例化数据层实现类的构造函数
        /// </summary>
        /// <param name="repository">实现数据层接口的对象</param>
        public PersonsLogic(IPersonsRepository repository)
            : base(repository)
        {
        }
        #endregion

        /// <summary>
        /// 返回所有高级查询的结果
        /// </summary>
        /// <typeparam name="TQueryParam">AdvQueryParam类型查询参数</typeparam>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>满足条件的所有结果集</returns>
        public IList<Persons> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam
        {
            return Repository.GetAdvQueryAll(queryParam);
        }
    }
}

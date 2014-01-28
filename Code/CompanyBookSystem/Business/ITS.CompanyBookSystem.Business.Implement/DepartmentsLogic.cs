using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.DataAccess.Interface;
using ITS.CompanyBookSystem.Business.Interface;

namespace ITS.CompanyBookSystem.Business.Implement
{
    /// <summary>
    /// 部门业务逻辑层实现
    /// </summary>
    public class DepartmentsLogic : BookSystemBaseEntityLogic<IDepartmentsRepository, Departments>, IDepartmentsLogic
    {
        #region 构造函数
        /// <summary>
        /// 用于工厂实例化数据层实现类的构造函数
        /// </summary>
        /// <param name="repository">实现数据层接口的对象</param>
        public DepartmentsLogic(IDepartmentsRepository repository)
            : base(repository)
        {
        }
        #endregion
    }
}

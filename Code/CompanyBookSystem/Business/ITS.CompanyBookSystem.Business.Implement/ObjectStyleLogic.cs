using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.Business.Interface;

namespace ITS.CompanyBookSystem.Business.Implement
{
    /// <summary>
    /// 预订对象样式业务逻辑层实现
    /// </summary>
    public class ObjectStyleLogic : BookSystemBaseEntityLogic<IObjectStyleRepository, ObjectStyle>, IObjectStyleLogic
    {
        #region 构造函数
        /// <summary>
        /// 用于工厂实例化数据层实现类的构造函数
        /// </summary>
        /// <param name="repository">实现数据层接口的对象</param>
        public ObjectStyleLogic(IObjectStyleRepository repository)
            : base(repository)
        {
        }
        #endregion
    }
}

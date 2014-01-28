using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.Business.Interface;

namespace ITS.CompanyBookSystem.Business.Interface
{
    /// <summary>
    /// 后台用户业务逻辑层接口
    /// </summary>
    public interface IUsersLogic : IEntityBaseLogic<Users>
    {
        /// <summary>
        /// 用户登录检验
        /// </summary>
        /// <param name="user">欲登录的用户</param>
        /// <returns>返回是否允许登录</returns>
        bool UserLoginCheck(Users user);
    }
}

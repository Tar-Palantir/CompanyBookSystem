using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Titan.Common.UI;
using ITS.CompanyBookSystem.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataStatus;
using ITS.CompanyBookSystem.UI.BehindUI.Helper;

namespace ITS.CompanyBookSystem.UI.BehindUI.Models
{
    /// <summary>
    /// 后台用户模型
    /// </summary>
    public class UsersModel : BookSystemBaseModel<IUsersLogic, Users>
    {
        public void InsertUser()
        {
            Users user = new Users()
            {
                Id=Guid.NewGuid(),
                LoginName = "admin",
                Password = "123456",
                RealName = "陈明",
                Tel = "62751111",
                Email = "chenming@tianfusoftwarepark.com"
            };
            OperateStatus status;
            BusinessLogic.Create(user, out status);
        }

        /// <summary>
        /// 用户登录检验
        /// </summary>
        /// <param name="user">欲登录的用户</param>
        /// <returns>返回是否允许登录</returns>
        public bool UserLoginCheck(LoginModel loginModel)
        {
            Users user = new Users()
            {
                LoginName = loginModel.LoginName,
                Password = loginModel.Password
            };

            if (BusinessLogic.UserLoginCheck(user))
            {
                UserIdentityHelper.WriteUserTokenCookie(user);
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
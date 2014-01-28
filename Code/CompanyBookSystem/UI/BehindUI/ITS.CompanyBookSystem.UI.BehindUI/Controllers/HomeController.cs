using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ITS.CompanyBookSystem.UI.BehindUI.Models;
using Titan.Common.UI.MVC;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataStatus;
using Titan.Common.Business.Implement;
using ITS.CompanyBookSystem.Business.Interface;
using System.Web.Security;

namespace ITS.CompanyBookSystem.UI.BehindUI.Controllers
{
    /// <summary>
    /// 主页控制器
    /// </summary>
    public class HomeController : BaseController
    {
    
        /// <summary>
        /// 后台用户模型
        /// </summary>
        private readonly UsersModel usersModel;

        #region 构造函数
        public HomeController()
        {
            usersModel = new UsersModel();
        }
        #endregion

        #region 视图
        /// <summary>
        /// 主页视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 返回登录视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Logon()
        {
            return View();
        }
        #endregion


        #region 系统认证

        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="model">登录模型</param>
        /// <returns>返回登录视图</returns>
        [HttpPost]
        public ActionResult Logon(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                if (usersModel.UserLoginCheck(model))
                {
                    return RedirectToAction("Index/", "Home");
                }
                //ModelState.AddModelError("", status.Message);
            }
            return View(model);
        }

        /// <summary>
        /// 退出系统
        /// </summary>
        /// <returns>转到登录页</returns>
        public ActionResult LogOut()
        {
            Session.Abandon();//取消当前会话
            FormsAuthentication.SignOut();//删除forms身份认证的票据
            return RedirectToAction("Logon/", "Home");
        }
        #endregion

    }
}

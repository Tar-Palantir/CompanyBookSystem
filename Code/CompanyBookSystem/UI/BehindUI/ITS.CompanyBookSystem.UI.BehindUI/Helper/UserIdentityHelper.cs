using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.Script.Serialization;
using ITS.CompanyBookSystem.DataAccess.Entity;

namespace ITS.CompanyBookSystem.UI.BehindUI.Helper
{
    public class UserIdentityHelper
    {
        /// <summary>
        /// 获取用户认证信息
        /// </summary>
        /// <returns>返回认证信息</returns>
        public static Users GetUserIdentity()
        {
            HttpContext context = HttpContext.Current;
            try
            {
                string strUser = ((FormsIdentity)context.User.Identity).Ticket.UserData;
                JavaScriptSerializer jss = new JavaScriptSerializer();
                return jss.Deserialize<Users>(strUser);
            }
            catch (Exception)
            {
                return null;
            }
        }

        public static void WriteUserTokenCookie(Users currentUser)
        {
            string strUser = new JavaScriptSerializer().Serialize(currentUser);
            HttpRequest request = HttpContext.Current.Request;
            HttpResponse response = HttpContext.Current.Response;

            //设置Ticket信息
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, currentUser.LoginName, request.ClientCertificate.ValidFrom, request.ClientCertificate.ValidFrom.AddHours(2), false, strUser);
            
            //加密ticket
            string strTicket = System.Web.Security.FormsAuthentication.Encrypt(ticket);

            HttpCookie cookies = FormsAuthentication.GetAuthCookie(currentUser.LoginName, false);
            cookies.Value = strTicket;
            response.Cookies.Add(cookies);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ITS.CompanyBookSystem.UI.BehindUI
{
    // 注意: 有关启用 IIS6 或 IIS7 经典模式的说明，
    // 请访问 http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // 路由名称
                "{controller}/{action}/{id}", // 带有参数的 URL
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // 参数默认值
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }

        /// <summary>
        /// 全局错误记录日志
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Application_Error(object sender, EventArgs e)
        {
            //Exception objError = Server.GetLastError().GetBaseException();
            //string error = string.Empty;

            //if (Request.Url.ToString().Contains(".jpg") || Request.Url.ToString().Contains(".gif"))
            //{
            //    return;
            //}


            //error += "发生时间:" + System.DateTime.Now.ToString() + "<br>";

            //error += "发生异常页: " + Request.Url.ToString() + "";


            //error += "异常信息: " + objError.Message + "";

            //error += "错误源:" + objError.Source;
            //error += "--------------------------------------";
            //Server.ClearError();
            //Application["error"] = error;

            //string dir = "/ErrorLogs/";


            //WriteTxt(error, dir);

        }

        /// <summary>
        /// 写入文件
        /// </summary>
        /// <param name="dataStr">写入内容</param>
        /// <param name="dir">目录</param>
        private static void WriteTxt(string dataStr, string dir)
        {
            object obj = new object();
            System.IO.StreamWriter writer = null;
            try
            {
                lock (obj)
                {
                    // 写入文件
                    string year = DateTime.Now.Year.ToString();
                    string month = DateTime.Now.Month.ToString();
                    string path = string.Empty;
                    string filename = DateTime.Now.Day.ToString() + ".txt";

                    //path = Directory.GetCurrentDirectory() + "/Logs/" + year + "/" + month;
                    path = AppDomain.CurrentDomain.BaseDirectory;
                    path = path + dir + year + "/" + month;
                    //如果目录不存在则创建
                    if (!System.IO.Directory.Exists(path))
                    {
                        System.IO.Directory.CreateDirectory(path);
                    }
                    System.IO.FileInfo file = new System.IO.FileInfo(path + "/" + filename);

                    writer = new System.IO.StreamWriter(file.FullName, true);//文件不存在就创建,true表示追

                    writer.WriteLine(dataStr);
                    //writer.WriteLine("--------------------------------------------------------" + DateTime.Now.ToString() + "    第" + signNum.ToString() + "条数据");
                    writer.WriteLine();
                }
            }
            finally
            {
                if (writer != null)
                    writer.Close();
            }
        }
    }
}
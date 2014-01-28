using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Titan.Common.UI.MVC;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.Business.Interface;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.UI.BehindUI.Models
{
    /// <summary>
    /// 部门模型
    /// </summary>
    public class DepartmentsModel : BookSystemBaseModel<IDepartmentsLogic, Departments>
    {
        /// <summary>
        /// 获取全部
        /// </summary>
        /// <returns>结果集</returns>
        public IList<Departments> GetAll()
        {
            return BusinessLogic.GetAll();
        }

        /// <summary>
        /// 快速查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public PagedResults<Departments> QuickQuery(QuickQueryParam param)
        {
            return BusinessLogic.QuickQuery(param);
        }
    }
}
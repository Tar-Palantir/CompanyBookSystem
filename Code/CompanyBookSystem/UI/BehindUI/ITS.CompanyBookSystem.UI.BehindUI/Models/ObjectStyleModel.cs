using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.Business.Interface;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.UI.BehindUI.Models
{
    /// <summary>
    /// 预订对象样式模型
    /// </summary>
    public class ObjectStyleModel : BookSystemBaseModel<IObjectStyleLogic, ObjectStyle>
    {
        /// <summary>
        /// 获取全部
        /// </summary>
        /// <returns>结果集</returns>
        public IList<ObjectStyle> GetAll()
        {
            return BusinessLogic.GetAll();
        }

        /// <summary>
        /// 快速查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public PagedResults<ObjectStyle> QuickQuery(QuickQueryParam param)
        {
            return BusinessLogic.QuickQuery(param);
        }
    }
}
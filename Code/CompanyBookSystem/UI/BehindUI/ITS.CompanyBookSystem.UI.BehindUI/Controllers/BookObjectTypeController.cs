using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ITS.CompanyBookSystem.UI.BehindUI.Models;
using Titan.Common.UI.MVC;
using Titan.Common.DataAccess.Entities;
using Titan.Common.DataStatus;
using ITS.CompanyBookSystem.DataAccess.Entity;

namespace ITS.CompanyBookSystem.UI.BehindUI.Controllers
{
    /// <summary>
    /// 预订对象类型控制器
    /// </summary>
    public class BookObjectTypeController : BaseController
    {
        /// <summary>
        /// 预订对象类型模型
        /// </summary>
        private readonly BookObjectTypeModel bookObjectTypeModel;

        #region 构造函数
        public BookObjectTypeController()
        {
            bookObjectTypeModel = new BookObjectTypeModel();
        }
        #endregion

        #region 视图
        public ActionResult Index()
        {
            return View();
        }
        #endregion

        /// <summary>
        /// 获取全部
        /// </summary>
        /// <returns>结果集Json</returns>
        public JsonResult GetAll(bool isSearch)
        {
            var results = bookObjectTypeModel.GetAll();
            if (isSearch)
            {
                results.Insert(0, new BookObjectType() { Id = Guid.Empty, Name = "全部" });
            }
            return Json(results);
        }

        /// <summary>
        /// 快速查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果Json</returns>
        public JsonResult QuickQuery(QuickQueryParam param)
        {
            var results = bookObjectTypeModel.QuickQuery(param);
            return JsonForGrid<BookObjectType>(results);
        }


        /// <summary>
        /// 添加数据
        /// </summary>
        /// <param name="entity">欲添加的实体数据</param>
        /// <returns>添加结果</returns>
        public JsonResult Create(BookObjectType entity)
        {
            OperateStatus status;
            bookObjectTypeModel.Create(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="entity">欲更新的实体数据</param>
        /// <returns>更新结果</returns>
        public JsonResult Update(BookObjectType entity)
        {
            OperateStatus status;
            bookObjectTypeModel.Update(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="entity">欲删除的实体数据</param>
        /// <returns>删除结果</returns>
        public JsonResult Delete(BookObjectType entity)
        {
            OperateStatus status;
            bookObjectTypeModel.Delete(entity.Id, out status);
            return JsonForStatus(status);
        }

    }
}

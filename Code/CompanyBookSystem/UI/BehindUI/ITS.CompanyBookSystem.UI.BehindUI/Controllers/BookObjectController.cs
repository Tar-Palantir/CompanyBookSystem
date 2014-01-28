using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataStatus;
using Titan.Common.DataAccess.Entities;
using ITS.CompanyBookSystem.UI.BehindUI.Models;
using Titan.Common.UI.MVC;

namespace ITS.CompanyBookSystem.UI.BehindUI.Controllers
{
    /// <summary>
    /// 预订对象控制器
    /// </summary>
    public class BookObjectController : BaseController
    {
        /// <summary>
        /// 预订对象模型
        /// </summary>
        private readonly BookObjectModel bookObjectModel;

        #region 构造函数
        public BookObjectController()
        {
            bookObjectModel = new BookObjectModel();
        }
        #endregion

        #region 视图
        public ActionResult Index()
        {
            return View();
        }
        #endregion

        /// <summary>
        /// 条件查询预订对象
        /// </summary>
        /// <param name="typeId">类型Id</param>
        /// <returns>查询结果Json</returns>
        public JsonResult GetAllByType(Guid? typeId)
        {
            IList<BookObject> results = new List<BookObject>();
            if (typeId.HasValue)
            {
                results = bookObjectModel.GetAdvQueryAll(new BookObjectQueryParam() { TypeId = typeId });
            }
            results.Insert(0, new BookObject() { Id = Guid.Empty, Name = "全部" });
            return Json(results);
        }
        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果Json</returns>
        public JsonResult AdvQuery(BookObjectQueryParam param)
        {
            var results = bookObjectModel.AdvQuery(param);
            return JsonForGrid<BookObjectResult>(results);
        }

        /// <summary>
        /// 添加数据
        /// </summary>
        /// <param name="entity">欲添加的实体数据</param>
        /// <returns>添加结果</returns>
        public JsonResult Create(BookObject entity)
        {
            OperateStatus status;
            if (entity.ObjectStyleId.HasValue && entity.ObjectStyleId == Guid.Empty)
            {
                entity.ObjectStyleId = null;
            }
            bookObjectModel.Create(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="entity">欲更新的实体数据</param>
        /// <returns>更新结果</returns>
        public JsonResult Update(BookObject entity)
        {
            OperateStatus status;
            bookObjectModel.Update(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="entity">欲删除的实体数据</param>
        /// <returns>删除结果</returns>
        public JsonResult Delete(BookObject entity)
        {
            OperateStatus status;
            bookObjectModel.Delete(entity.Id, out status);
            return JsonForStatus(status);
        }

    }
}

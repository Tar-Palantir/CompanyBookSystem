using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Titan.Common.UI.MVC;
using Titan.Common.DataStatus;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.UI.BehindUI.Models;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.UI.BehindUI.Controllers
{
    /// <summary>
    /// 预订对象样式控制器
    /// </summary>
    public class ObjectStyleController : BaseController
    {
        /// <summary>
        /// 预订对象样式模型
        /// </summary>
        private readonly ObjectStyleModel objectStyleModel;

        #region 构造函数
        public ObjectStyleController()
        {
            objectStyleModel = new ObjectStyleModel();
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
        public JsonResult GetAll()
        {
            var results = objectStyleModel.GetAll();
            results.Add(new ObjectStyle() { Id = Guid.Empty, Name = "默认" });
            return Json(results);
        }

        /// <summary>
        /// 快速查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果Json</returns>
        public JsonResult QuickQuery(QuickQueryParam param)
        {
            var results = objectStyleModel.QuickQuery(param);
            return JsonForGrid<ObjectStyle>(results);
        }

        /// <summary>
        /// 添加数据
        /// </summary>
        /// <param name="entity">欲添加的实体数据</param>
        /// <returns>添加结果</returns>
        public JsonResult Create(ObjectStyle entity)
        {
            OperateStatus status;
            objectStyleModel.Create(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="entity">欲更新的实体数据</param>
        /// <returns>更新结果</returns>
        public JsonResult Update(ObjectStyle entity)
        {
            OperateStatus status;
            objectStyleModel.Update(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="entity">欲删除的实体数据</param>
        /// <returns>删除结果</returns>
        public JsonResult Delete(ObjectStyle entity)
        {
            OperateStatus status;
            objectStyleModel.Delete(entity.Id, out status);
            return JsonForStatus(status);
        }

    }
}

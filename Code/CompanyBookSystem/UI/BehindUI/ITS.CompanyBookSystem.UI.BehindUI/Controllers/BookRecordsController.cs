using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Titan.Common.UI.MVC;
using Titan.Common.DataAccess.Entities;
using Titan.Common.DataStatus;
using ITS.CompanyBookSystem.UI.BehindUI.Models;
using ITS.CompanyBookSystem.DataAccess.Entity;

namespace ITS.CompanyBookSystem.UI.BehindUI.Controllers
{
    /// <summary>
    /// 预订记录控制器
    /// </summary>
    public class BookRecordsController : BaseController
    {
        /// <summary>
        /// 定义预订记录模型
        /// </summary>
        private readonly BookRecordsModel bookRecordsModel;

        #region 构造函数
        /// <summary>
        /// 构造函数
        /// </summary>
        public BookRecordsController()
        {
            bookRecordsModel = new BookRecordsModel();
        }
        #endregion

        #region 视图
        /// <summary>
        /// 返回页面视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }
        #endregion

        #region 返回编辑页面视图
        /// <summary>
        /// 返回编辑页面视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Update(string id)
        {
            BookRecordResult updateData = null;
            Guid guid;
            if (Guid.TryParse(id, out guid))
            {
                updateData = bookRecordsModel.GetDetailById(guid);
            }
            return View(updateData);
        }
        #endregion

        #region 返回详细页面视图
        /// <summary>
        /// 返回详细页面视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Detail(string id)
        {
            BookRecordResult detailData = null;
            Guid guid;
            if (Guid.TryParse(id, out guid))
            {
                detailData = bookRecordsModel.GetDetailById(guid);
            }
            return View(detailData);
        }
        #endregion

        /// <summary>
        /// 条件查询数据
        /// </summary>
        /// <param name="queryParam">查询参数</param>
        /// <returns>查询结果</returns>
        public JsonResult AdvQuery(BookRecordQueryParam queryParam)
        {
            PagedResults<BookRecordResult> results = bookRecordsModel.AdvQuery(queryParam);
            JsonResult result = JsonForGrid<BookRecordResult>(results);
            return result;
        }
        
        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="entity">欲更新的实体数据</param>
        /// <returns>更新结果</returns>
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult Update(BookRecords entity)
        {
            OperateStatus status;
            entity.DateModified = DateTime.Now;
            entity.Modifier = "管理员";
            bookRecordsModel.Update(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="entity">欲删除的实体数据</param>
        /// <returns>删除结果</returns>
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult Delete(BookRecords entity)
        {
            OperateStatus status;
            bookRecordsModel.Delete(entity.Id, out status);
            return JsonForStatus(status);
        }

    }
}

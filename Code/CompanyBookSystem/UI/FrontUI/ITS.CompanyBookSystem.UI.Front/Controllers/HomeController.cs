using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ITS.CompanyBookSystem.UI.Front.Models;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.UI.MVC;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.UI.Front.Controllers
{
    /// <summary>
    /// 主页控制器
    /// </summary>
    public class HomeController : BaseController
    {
        /// <summary>
        /// 预订对象模型
        /// </summary>
        private readonly BookObjectModel bookObjectModel;
        /// <summary>
        /// 预订对象类型模型
        /// </summary>
        private readonly BookObjectTypeModel bookObjectTypeModel;
        /// <summary>
        /// 预订记录模型
        /// </summary>
        private readonly BookRecordsModel bookRecordsModel;
        /// <summary>
        /// 部门模型
        /// </summary>
        private readonly DepartmentsModel departmentsModel;


        #region 构造函数
        public HomeController()
        {
            bookObjectModel = new BookObjectModel();
            bookObjectTypeModel = new BookObjectTypeModel();
            bookRecordsModel = new BookRecordsModel();
            departmentsModel = new DepartmentsModel();
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
        #endregion

        /// <summary>
        /// 获取全部预订类型
        /// </summary>
        /// <returns>结果集Json</returns>
        public JsonResult GetAllObjectType()
        {
            var results = bookObjectTypeModel.GetAll();
            results.Insert(0, new BookObjectType() { Id = Guid.Empty, Name = "全部" });
            return Json(results);
        }

        /// <summary>
        /// 获取全部部门
        /// </summary>
        /// <returns>结果集Json</returns>
        public JsonResult GetAllDepartments()
        {
            var results = departmentsModel.GetAll();
            return Json(results);
        }

        /// <summary>
        /// 条件查询预订对象
        /// </summary>
        /// <param name="typeId">类型Id</param>
        /// <returns>查询结果Json</returns>
        public JsonResult GetBookObjects(Guid? typeId)
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
        /// 条件查询预订对象
        /// </summary>
        /// <param name="typeId">类型Id</param>
        /// <returns>查询结果Json</returns>
        public JsonResult GetBookObjectById(Guid? id)
        {
            BookObject bookObject;
            if (id.HasValue && id.Value != Guid.Empty)
            {
                var result = bookObjectModel.GetById(id.Value);
                bookObject = new BookObject() { Describe = result.Describe, Location = result.Location };
            }
            else
            {
                bookObject = new BookObject() { Describe = "当前显示所有该类别的预订信息。", Location = "当前为查看页面。" };
            }
            return Json(bookObject);
        }

        /// <summary>
        /// 条件查询记录数据
        /// </summary>
        /// <param name="queryParam">查询参数</param>
        /// <returns>查询结果</returns>
        [HttpGet]
        public JsonResult RecordsAdvQuery(BookRecordQueryParam queryParam)
        {
            IList<Event> results = bookRecordsModel.GetAdvQueryAll(queryParam, this.Request.UserHostAddress);

            JsonResult result = Json(results, JsonRequestBehavior.AllowGet);
            return result;
        }

        /// <summary>
        /// 根据Id获取详细信息
        /// </summary>
        /// <param name="id">记录Id</param>
        /// <returns>信息</returns>
        public JsonResult GetDetailById(Guid? id)
        {
            if (id.HasValue && id.Value != Guid.Empty)
            {
                BookRecordResult detail = bookRecordsModel.GetDetailById(id.Value);
                return Json(detail);
            }
            else
            {
                return null;
            }
        }
        
        /// <summary>
        /// 添加记录数据
        /// </summary>
        /// <param name="entity">欲添加的实体数据</param>
        /// <returns>添加结果</returns>
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult RecordsCreateOrUpdate(BookRecords entity)
        {
            OperateStatus status;
            if (entity.Id != null && entity.Id != Guid.Empty)
            {
                entity.OperateComputerIP = this.Request.UserHostAddress;
                entity.DateModified = DateTime.Now;

                bookRecordsModel.Update(entity, out status);
            }
            else
            {
                entity.OperateComputerIP = this.Request.UserHostAddress;
                entity.DateCreated = DateTime.Now;

                bookRecordsModel.Create(entity, out status);
            }
            return JsonForStatus(status);
        }

        /// <summary>
        /// 更新记录数据
        /// </summary>
        /// <param name="entity">欲更新的实体数据</param>
        /// <returns>更新结果</returns>
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult RecordsUpdate(BookRecords entity)
        {
            OperateStatus status;
            bookRecordsModel.Update(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 删除记录数据
        /// </summary>
        /// <param name="entity">欲删除的实体数据</param>
        /// <returns>删除结果</returns>
        [HttpPost]
        public JsonResult RecordsDelete(Guid? id)
        {
            OperateStatus status;
            if (id.HasValue && id.Value != Guid.Empty)
            {
                bookRecordsModel.Delete(id.Value, out status);
            }
            else
            {
                status = new OperateStatus() { ResultSign = ResultSign.Failed, Message = "预订信息获取错误" };
            }
            return JsonForStatus(status);
        }
    }
}

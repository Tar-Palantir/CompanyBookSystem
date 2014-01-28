using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Titan.Common.UI.MVC;
using ITS.CompanyBookSystem.UI.Front.Models;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataStatus;
using Titan.Common.Helper;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.UI.Front.Controllers
{
    /// <summary>
    /// 任务列表控制器
    /// </summary>
    public class JobListsController : BaseController
    {
        /// <summary>
        /// 预约事件模型
        /// </summary>
        private readonly EventsModel eventsModel;

        /// <summary>
        /// 预约人员模型
        /// </summary>
        private readonly PersonsModel personsModel;

        /// <summary>
        /// 部门模型
        /// </summary>
        private readonly DepartmentsModel departmentsModel;

        #region 构造函数
        public JobListsController()
        {
            eventsModel = new EventsModel();
            personsModel = new PersonsModel();
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
        /// 获取全部部门
        /// </summary>
        /// <returns>结果集Json</returns>
        public JsonResult GetAllDepartments()
        {
            var results = departmentsModel.GetAll();
            results.Insert(0, new Departments() { Id = Guid.Empty, Name = "全部" });
            return Json(results);
        }

        /// <summary>
        /// 条件查询预订对象
        /// </summary>
        /// <param name="typeId">类型Id</param>
        /// <returns>查询结果Json</returns>
        public JsonResult GetPersons(Guid? departmentId)
        {
            IList<Persons> results = new List<Persons>();
            results = personsModel.GetAdvQueryAll(new PersonsQueryParam() { DepartmentId = departmentId });

            return Json(results);
        }

        /// <summary>
        /// 获取状态列表
        /// </summary>
        /// <returns>结果集Json</returns>
        public JsonResult GetStatusList()
        {
            var results = new List<KeyValuePair<string, int>>();
            Type eType = typeof(EventStatus);
            var values = Enum.GetValues(eType);

            foreach (var value in values)
            {
                results.Add(new KeyValuePair<string, int>(EnumHelper.Description((EventStatus)value), (int)value));
            }
            return Json(results);
        }

        /// <summary>
        /// 添加预约事件数据
        /// </summary>
        /// <param name="entity">欲添加的实体数据</param>
        /// <returns>添加结果</returns>
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult Create(Events entity)
        {
            OperateStatus status;
            entity.OperateComputerIP = Request.UserHostAddress;
            entity.DateCreated = DateTime.Now;
            eventsModel.Create(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 修改预约事件数据
        /// </summary>
        /// <param name="entity">欲修改的实体数据</param>
        /// <returns>修改结果</returns>
        [HttpPost]
        [ValidateInput(false)]
        public JsonResult Update(Events entity)
        {
            OperateStatus status;
            
            if (entity.HasMoved)
            {
                eventsModel.MoveEvent(new EventsMoveParam
                {
                    EventId = entity.Id,
                    TargetSortIndex = entity.SortIndex,
                    Modifier = Request.UserHostAddress,
                    DateModified = DateTime.Now
                }, out status);
            }
            else
            {
                entity.Modifier = Request.UserHostAddress;
                entity.DateModified = DateTime.Now;
                eventsModel.Update(entity, out status);
            }
            return JsonForStatus(status);
        }

        /// <summary>
        /// 删除预约事件数据
        /// </summary>
        /// <param name="entity">欲删除的实体数据</param>
        /// <returns>删除结果</returns>
        [HttpPost]
        public JsonResult Delete(Events entity)
        {
            OperateStatus status;
            entity.Modifier = Request.UserHostAddress;
            entity.DateModified = DateTime.Now;

            eventsModel.Delete(entity, out status);

            return JsonForStatus(status);
        }

        public JsonResult GetProcessingEvents(Guid? personsId)
        {
            IList<Events> results = new List<Events>();
            if (personsId.HasValue)
            {
                results = eventsModel.GetAdvQueryAll(new EventsQueryParam() { PersonsId = personsId, HasFinished = false });
            }
            return Json(results);
        }

        public JsonResult GetFinishedEvents(EventsQueryParam param)
        {
            PagedResults<Events> results = new PagedResults<Events>();
            results.Data = new List<Events>();
            results.PagerInfo = new PagerInfo(new PageParam() { });

            if (param.PersonsId.HasValue)
            {
                param.SortName = "DateModified";
                param.SortOrder = "desc";
                param.HasFinished = true;
                results = eventsModel.AdvQuery(param);
            }
            return JsonForGrid(results);
        }

    }
}

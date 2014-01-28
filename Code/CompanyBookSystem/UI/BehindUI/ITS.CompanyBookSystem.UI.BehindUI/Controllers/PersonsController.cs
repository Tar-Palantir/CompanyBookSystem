using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Titan.Common.DataStatus;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.UI.MVC;
using ITS.CompanyBookSystem.UI.BehindUI.Models;

namespace ITS.CompanyBookSystem.UI.BehindUI.Controllers
{
    /// <summary>
    /// 预约人员控制器
    /// </summary>
    public class PersonsController : BaseController
    {
        /// <summary>
        /// 预约人员模型
        /// </summary>
        private readonly PersonsModel personsModel;

        #region 构造函数
        public PersonsController()
        {
            personsModel = new PersonsModel();
        }
        #endregion

        #region 视图
        public ActionResult Index()
        {
            return View();
        }
        #endregion
        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果Json</returns>
        public JsonResult AdvQuery(PersonsQueryParam param)
        {
            var results = personsModel.AdvQuery(param);
            return JsonForGrid<PersonsResult>(results);
        }

        /// <summary>
        /// 添加数据
        /// </summary>
        /// <param name="entity">欲添加的实体数据</param>
        /// <returns>添加结果</returns>
        public JsonResult Create(Persons entity)
        {
            OperateStatus status;
            personsModel.Create(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="entity">欲更新的实体数据</param>
        /// <returns>更新结果</returns>
        public JsonResult Update(Persons entity)
        {
            OperateStatus status;
            personsModel.Update(entity, out status);
            return JsonForStatus(status);
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="entity">欲删除的实体数据</param>
        /// <returns>删除结果</returns>
        public JsonResult Delete(Persons entity)
        {
            OperateStatus status;
            personsModel.Delete(entity.Id, out status);
            return JsonForStatus(status);
        }

    }
}

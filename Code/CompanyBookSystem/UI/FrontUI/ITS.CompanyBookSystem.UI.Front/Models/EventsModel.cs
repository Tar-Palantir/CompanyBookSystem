using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ITS.CompanyBookSystem.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataStatus;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.UI.Front.Models
{
    /// <summary>
    /// 预约事件模型
    /// </summary>
    public class EventsModel : BookSystemBaseModel<IEventsLogic, Events>
    {
        /// <summary>
        /// 删除方法
        /// </summary>
        /// <param name="entity">欲删除的数据实体，包括Id和修改时间和修改人</param>
        /// <param name="status">操作状态</param>
        public void Delete(Events entity, out OperateStatus status)
        {
            BusinessLogic.Delete(entity, out status);
        }

        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <param name="currentIP">当前用户的IP地址</param>
        /// <returns>分页后的查询结果</returns>
        public IList<Events> GetAdvQueryAll(EventsQueryParam param)
        {
            var results = BusinessLogic.GetAdvQueryAll(param);
            foreach (var result in results)
            {
                result.DepartmentName = result.Departments.Name.ToString();
                result.Departments = null;
                result.Persons = null;
            }
            return results;
        }

        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <param name="currentIP">当前用户的IP地址</param>
        /// <returns>分页后的查询结果</returns>
        public PagedResults<Events> AdvQuery(EventsQueryParam param)
        {
            var results = BusinessLogic.AdvQuery(param);
            foreach (var result in results.Data)
            {
                result.DepartmentName = result.Departments.Name.ToString();
                result.Departments = null;
                result.Persons = null;
            }
            return results;
        }

        /// <summary>
        /// 移动预约事件
        /// </summary>
        /// <param name="param">当前事件信息，需要Id、当前SortIndex</param>
        /// <param name="status">操作状态</param>
        public void MoveEvent(EventsMoveParam param, out OperateStatus status)
        {
            BusinessLogic.MoveEvent(param, out status);
        }
    }
}
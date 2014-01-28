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
    /// 预约人员模型
    /// </summary>
    public class PersonsModel : BookSystemBaseModel<IPersonsLogic, Persons>
    {
        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public PagedResults<PersonsResult> AdvQuery(PersonsQueryParam param)
        {
            var sourceResults = BusinessLogic.AdvQuery(param);

            PagedResults<PersonsResult> results = new PagedResults<PersonsResult>();
            results.Data = new List<PersonsResult>(sourceResults.Data.Count);
            results.PagerInfo = sourceResults.PagerInfo;

            foreach (var item in sourceResults.Data)
            {
                results.Data.Add(new PersonsResult()
                {
                    Id = item.Id,
                    DepartmentId = item.DepartmentId,
                    DepartmentName = item.Departments.Name,
                    Describe = item.Describe,
                    Location = item.Location,
                    Name = item.Name,
                    State = item.State
                });
            }

            return results;
        }
    }
}
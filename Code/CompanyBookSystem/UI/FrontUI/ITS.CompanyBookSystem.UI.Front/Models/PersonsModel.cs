using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.Business.Interface;

namespace ITS.CompanyBookSystem.UI.Front.Models
{
    /// <summary>
    /// 预约人员模型
    /// </summary>
    public class PersonsModel : BookSystemBaseModel<IPersonsLogic, Persons>
    {
        /// <summary>
        /// 高级查询获取全部
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public IList<Persons> GetAdvQueryAll(PersonsQueryParam param)
        {
            var results = BusinessLogic.GetAdvQueryAll(param);
            foreach (var person in results)
            {
                person.Departments = null;
            }
            return results;
        }
    }
}
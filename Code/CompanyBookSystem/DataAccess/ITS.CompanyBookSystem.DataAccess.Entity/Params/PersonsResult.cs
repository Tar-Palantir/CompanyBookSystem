using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预约人员查询结果
    /// </summary>
    public class PersonsResult:Persons
    {
        /// <summary>
        /// 部门名称
        /// </summary>
        public string DepartmentName { set; get; }
    }
}

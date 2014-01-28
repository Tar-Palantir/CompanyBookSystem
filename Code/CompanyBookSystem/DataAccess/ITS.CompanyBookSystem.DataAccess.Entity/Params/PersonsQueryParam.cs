using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 人员高级查询参数
    /// </summary>
    public class PersonsQueryParam : AdvQueryParam
    {
        /// <summary>
        /// 部门Id
        /// </summary>
        public Guid? DepartmentId { set; get; }

        /// <summary>
        /// 人员名称
        /// </summary>
        public string Name { set; get; }
    }
}

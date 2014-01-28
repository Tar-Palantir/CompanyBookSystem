using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Interface;

namespace ITS.CompanyBookSystem.DataAccess.Interface
{
    /// <summary>
    /// 部门数据访问层接口
    /// </summary>
    public interface IDepartmentsRepository : IRepository<Departments>
    {
    }
}

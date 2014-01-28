using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;

namespace ITS.CompanyBookSystem.DataAccess.Interface
{
    /// <summary>
    /// 预订对象的样式数据访问层接口
    /// </summary>
    public interface IObjectStyleRepository:IRepository<ObjectStyle>
    {
    }
}

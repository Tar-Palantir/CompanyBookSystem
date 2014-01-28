using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Interface;

namespace ITS.CompanyBookSystem.DataAccess.Interface
{
    /// <summary>
    /// 预订对象类型数据访问层接口
    /// </summary>
    public interface IBookObjectTypeRepository : IRepository<BookObjectType>
    {
    }
}

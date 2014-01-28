using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 对实体基类接口的扩展
    /// </summary>
    public interface IEntityBaseExtention : IEntityBase
    {
        /// <summary>
        /// 状态
        /// </summary>
        int State { set; get; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预订对象查询参数
    /// </summary>
    public class BookObjectQueryParam : AdvQueryParam
    {
        /// <summary>
        /// 预订对象类型Id
        /// </summary>
        public Guid? TypeId { set; get; }

        /// <summary>
        /// 预订对象名称
        /// </summary>
        public string Name { set; get; }
    }
}

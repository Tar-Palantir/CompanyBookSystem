using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预订对象结果集
    /// </summary>
    public class BookObjectResult : BookObject
    {
        /// <summary>
        /// 预订对象类型名
        /// </summary>
        public string BookObjectTypeName { set; get; }

        /// <summary>
        /// 预订对象样式名
        /// </summary>
        public string ObjectStyleName { set; get; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预订记录查询参数
    /// </summary>
    public class BookRecordQueryParam : AdvQueryParam
    {
        /// <summary>
        /// 预订对象Id
        /// </summary>
        public Guid? BookObjectId { set; get; }

        /// <summary>
        /// 相关联Id
        /// </summary>
        public Guid? RelevanceId { set; get; }

        /// <summary>
        /// 预订对象类型Id
        /// </summary>
        public Guid? TypeId { set; get; }

        /// <summary>
        /// 预订部门的Id
        /// </summary>
        public Guid? DepartmentId { set; get; }

        /// <summary>
        /// 查询开始日期，下限日期
        /// </summary>
        public DateTime? StartDate { set; get; }

        /// <summary>
        /// 查询结束日期，上限日期
        /// </summary>
        public DateTime? EndDate { set; get; }

        /// <summary>
        /// 查询关键字
        /// </summary>
        public string Value { set; get; }
    }
}

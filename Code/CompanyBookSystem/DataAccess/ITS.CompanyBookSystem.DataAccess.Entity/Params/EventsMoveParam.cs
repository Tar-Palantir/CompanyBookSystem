using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预约事件移动参数
    /// </summary>
    public class EventsMoveParam
    {
        /// <summary>
        /// 移动的事件Id
        /// </summary>
        public Guid EventId { set; get; }

        /// <summary>
        /// 预约人员Id
        /// </summary>
        public Guid? PersonsId { set; get; }

        /// <summary>
        /// 移动的目标索引
        /// </summary>
        public int? TargetSortIndex { set; get; }

        /// <summary>
        /// 移动后的状态
        /// </summary>
        public int? TargetStatus { set; get; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string Modifier { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public Nullable<System.DateTime> DateModified { get; set; }
    }
}

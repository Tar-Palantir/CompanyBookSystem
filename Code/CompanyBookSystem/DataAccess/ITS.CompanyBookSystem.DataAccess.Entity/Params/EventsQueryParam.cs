using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预约事件查询参数
    /// </summary>
    public class EventsQueryParam : AdvQueryParam
    {
        /// <summary>
        /// 事件标题
        /// </summary>
        public string Title { set; get; }

        /// <summary>
        /// 预约人员Id
        /// </summary>
        public Guid? PersonsId { set; get; }

        /// <summary>
        /// 是否已完成
        /// </summary>
        public bool? HasFinished { set; get; }

        /// <summary>
        /// 数据状态
        /// </summary>
        public int? Status { set; get; }
    }
}

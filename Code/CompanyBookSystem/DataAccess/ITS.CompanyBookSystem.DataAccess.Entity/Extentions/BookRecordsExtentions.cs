using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预订记录
    /// </summary>
    public partial class BookRecords : IEntityBaseExtention
    {
        /// <summary>
        /// 循环模式
        /// </summary>
        public int CircleMode { set; get; }

        /// <summary>
        /// 循环模式的周期，第几天或周几，由CircleMode决定
        /// </summary>
        public int CircleDayOrWeek { set; get; }
    }

    /// <summary>
    /// 循环模式
    /// </summary>
    public enum EnumCircleMode
    {
        /// <summary>
        /// 不循环
        /// </summary>
        None = 0,

        /// <summary>
        /// 日循环
        /// </summary>
        Day = 1,

        /// <summary>
        /// 周循环
        /// </summary>
        Week = 2,

        /// <summary>
        /// 月循环
        /// </summary>
        Month = 3
    }
}

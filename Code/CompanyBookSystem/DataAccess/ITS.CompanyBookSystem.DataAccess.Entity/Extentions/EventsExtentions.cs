using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预约事件
    /// </summary>
    public partial class Events : IEntityBaseExtention
    {
        /// <summary>
        /// 执行状态名称
        /// </summary>
        public string StatusName
        {
            get
            {
                return Titan.Common.Helper.EnumHelper.Description((EventStatus)this.Status);
            }
        }

        /// <summary>
        /// 部门名称
        /// </summary>
        public string DepartmentName { set; get; }

        /// <summary>
        /// 是否移动了位置
        /// </summary>
        public bool HasMoved { set; get; }
    }

    /// <summary>
    /// 预约事件状态
    /// </summary>
    public enum EventStatus
    {
        /// <summary>
        /// 中断
        /// </summary>
        [Description("中断")]
        Interrupt = -1,

        /// <summary>
        /// 等待
        /// </summary>
        [Description("等待")]
        Wait = 0,

        /// <summary>
        /// 进行中
        /// </summary>
        [Description("进行中")]
        Processing = 1,

        /// <summary>
        /// 已完成
        /// </summary>
        [Description("已完成")]
        Finished = 2
    }
}

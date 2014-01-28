using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ITS.CompanyBookSystem.UI.Front.Models
{
    /// <summary>
    /// 日程控件中的事件类型
    /// </summary>
    public class Event
    {
        /// <summary>
        /// 预订记录Id
        /// </summary>
        public Guid id { set; get; }

        /// <summary>
        /// 关联Id
        /// </summary>
        public Guid? relevanceId { set; get; }

        /// <summary>
        /// 判断当前用户是否是创建预定的用户，相同的才可编辑
        /// </summary>
        public bool isEditable { set; get; }

        /// <summary>
        /// 预订记录标题
        /// </summary>
        public string title { set; get; }

        /// <summary>
        /// 预订对象Id
        /// </summary>
        public string recordObjectId { set; get; }

        /// <summary>
        /// 事件展示样式类名
        /// </summary>
        public string className { set; get; }

        /// <summary>
        /// 预订开始时间
        /// </summary>
        public string start { set; get; }

        /// <summary>
        /// 预订结束时间
        /// </summary>
        public string end { set; get; }

        /// <summary>
        /// 是否全天
        /// </summary>
        public bool allDay { set; get; }

        /// <summary>
        /// 背景色
        /// </summary>
        public string backgroundColor { set; get; }

        /// <summary>
        /// 边框色
        /// </summary>
        public string borderColor { set; get; }

        /// <summary>
        /// 文本颜色
        /// </summary>
        public string textColor { set; get; }
    }
}
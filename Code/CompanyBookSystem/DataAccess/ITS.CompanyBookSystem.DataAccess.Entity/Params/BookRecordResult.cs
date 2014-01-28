using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    /// <summary>
    /// 预订记录结果集
    /// </summary>
    public class BookRecordResult : BookRecords
    {
        /// <summary>
        /// 部门名称
        /// </summary>
        public string DepartmentName { set; get; }

        /// <summary>
        /// 预订对象名称
        /// </summary>
        public string BookObjectName { set; get; }

        /// <summary>
        /// 相关联记录
        /// </summary>
        public string RelevanceRecords { set; get; }

        /// <summary>
        /// 是否是周期性的
        /// </summary>
        public bool IsCircle
        {
            get
            {
                return this.RelevanceId.HasValue && this.RelevanceId != Guid.Empty ? true : false;
            }
        }

        /// <summary>
        /// 是否是全天
        /// </summary>
        public bool IsAllDay
        {
            get
            {
                return StartTime.ToString("HH:mm") == "00:00" && EndTime.ToString("HH:mm") == "00:00" ? true : false;
            }
        }

        /// <summary>
        /// 预定的使用时间
        /// </summary>
        public string UsingTime
        {
            get
            {
                string usingTime;
                if (StartDate == EndDate && !IsAllDay)
                {
                    usingTime = string.Format("使用时间：{0} {1} 到 {2}",
                        StartDate.ToString("yyyy年MM月dd日"), StartTime.ToString("HH:mm"), EndTime.ToString("HH:mm"));
                }
                else if (IsAllDay)
                {
                    if (StartDate == EndDate)
                    {
                        usingTime = string.Format("使用时间：{0} 全天", StartDate.ToString("yyyy年MM月dd日"));
                    }
                    else
                    {
                        usingTime = string.Format("使用时间：从 {0} 到 {1},全天",
                        StartDate.ToString("yyyy年MM月dd日"), EndDate.ToString("yyyy年MM月dd日"));
                    }
                }
                else
                {
                    usingTime = string.Format("使用时间：从 {0} {1} 到 {2} {3}",
                    StartDate.ToString("yyyy年MM月dd日"), StartTime.ToString("HH:mm"),
                    EndDate.ToString("yyyy年MM月dd日"), EndTime.ToString("HH:mm"));
                }

                return usingTime;
            }
        }
    }
}

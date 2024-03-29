//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

namespace ITS.CompanyBookSystem.DataAccess.Entity
{
    public partial class BookRecords
    {
        public System.Guid Id { get; set; }
        public Nullable<System.Guid> RelevanceId { get; set; }
        public System.Guid BookObjectId { get; set; }
        public System.DateTime StartDate { get; set; }
        public System.DateTime EndDate { get; set; }
        public System.DateTime StartTime { get; set; }
        public System.DateTime EndTime { get; set; }
        public string Describe { get; set; }
        public System.Guid DepartmentId { get; set; }
        public string Tel { get; set; }
        public int State { get; set; }
        public string Creator { get; set; }
        public string OperateComputerIP { get; set; }
        public System.DateTime DateCreated { get; set; }
        public string Modifier { get; set; }
        public Nullable<System.DateTime> DateModified { get; set; }
    
        public virtual BookObject BookObject { get; set; }
        public virtual Departments Departments { get; set; }
    }
    
}

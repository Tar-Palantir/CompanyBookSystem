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
    public partial class Events
    {
        public System.Guid Id { get; set; }
        public string Title { get; set; }
        public string PlanWorkTime { get; set; }
        public Nullable<int> SortIndex { get; set; }
        public System.Guid PersonsId { get; set; }
        public string Describe { get; set; }
        public System.Guid DepartmentId { get; set; }
        public int Status { get; set; }
        public int State { get; set; }
        public string Creator { get; set; }
        public string OperateComputerIP { get; set; }
        public System.DateTime DateCreated { get; set; }
        public string Modifier { get; set; }
        public Nullable<System.DateTime> DateModified { get; set; }
    
        public virtual Departments Departments { get; set; }
        public virtual Persons Persons { get; set; }
    }
    
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.DataAccess.Implement;
using Titan.Common.DataStatus;
using ITS.CompanyBookSystem.DataAccess.Entity;

namespace ITS.CompanyBookSystem.DataAccess.Implement
{
    /// <summary>
    /// 数据访问实现层基类
    /// </summary>
    /// <typeparam name="T">数据实体类型</typeparam>
    public class BaseRepository<T> : Repository<T>
        where T : class,global::ITS.CompanyBookSystem.DataAccess.Entity.IEntityBaseExtention
    {
        /// <summary>
        /// 
        /// </summary>
        private System.Data.Entity.DbContext activeContext;
        public BaseRepository()
        {
            activeContext = new ITS.CompanyBookSystem.DataAccess.Entity.CompanyBookSystemEntities();
        }

        #region 重写父类
        /// <summary>
        /// 查询全部
        /// </summary>
        /// <returns>所有未删除的数据列表</returns>
        public override IList<T> GetAll()
        {
            return base.ObjectQuery.Where(p => p.State == (int)StateSign.Normal).ToList();
        }
        /// <summary>
        /// 获取上下文属性
        /// </summary>
        protected override System.Data.Entity.DbContext Context
        {
            get { return activeContext; }
        }
        #endregion
    }
}

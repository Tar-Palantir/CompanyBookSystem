using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.Business.Implement;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.Business.Implement
{
    /// <summary>
    /// 业务逻辑层实现基类
    /// </summary>
    /// <typeparam name="TInterface">接口</typeparam>
    /// <typeparam name="TEntity">数据实体类型</typeparam>
    public abstract class BaseEntityLogic<TInterface, TEntity> : EntityBaseLogic<TEntity>
        where TInterface : class,global::Titan.Common.DataAccess.Interface.IRepository<TEntity>
        where TEntity : class,global::ITS.CompanyBookSystem.DataAccess.Entity.IEntityBaseExtention
    {
        /// <summary>
        /// 数据访问层实例
        /// </summary>
        protected Titan.Common.DataAccess.Interface.IRepository<TEntity> Repository { set; get; }

        #region 构造函数
        /// <summary>
        /// 根据输入的数据层实例配置
        /// </summary>
        /// <param name="repository">数据层实例</param>
        public BaseEntityLogic(TInterface repository)
            : base(repository)
        {
            this.Repository = repository;
        }
        #endregion

        #region 重写父类方法
        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="entity">欲添加的数据</param>
        /// <param name="status">操作状态</param>
        public override void Create(TEntity entity, out OperateStatus status)
        {
            entity.State = (int)StateSign.Normal;
            base.Create(entity, out status);
        }
        /// <summary>
        /// 删除方法
        /// </summary>
        /// <param name="id">欲删除的数据Id</param>
        /// <param name="status">操作状态</param>
        public override void Delete(Guid id, out OperateStatus status)
        {
            TEntity entity = GetById(id);
            entity.State = (int)StateSign.Deleted;
            base.Update(entity, out status);
        }
        #endregion
    }
}

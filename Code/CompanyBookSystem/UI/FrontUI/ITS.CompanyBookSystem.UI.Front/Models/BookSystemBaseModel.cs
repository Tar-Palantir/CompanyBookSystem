using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Titan.Common.DataStatus;
using Titan.Common.Business.Implement;
using Titan.Common.Business.Interface;
using Titan.Common.DataAccess.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;

namespace ITS.CompanyBookSystem.UI.Front.Models
{
    /// <summary>
    /// MVC模型基类
    /// </summary>
    /// <typeparam name="TInterface">业务逻辑层接口</typeparam>
    /// <typeparam name="TEntity">数据实体类型</typeparam>
    public abstract class BookSystemBaseModel<TInterface,TEntity>
        where TInterface : class,global::Titan.Common.Business.Interface.IEntityBaseLogic<TEntity>
        where TEntity : class,global::ITS.CompanyBookSystem.DataAccess.Entity.IEntityBaseExtention
    {
        /// <summary>
        /// 业务逻辑实现
        /// </summary>
        protected TInterface BusinessLogic { set; get; }

        #region 构造函数
        /// <summary>
        /// 自动配置业务逻辑层实例
        /// </summary>
        public BookSystemBaseModel()
        {
            //根据接口通过工厂获取实例
            this.BusinessLogic = BusinessLogicFactory.GetLogicInstance<TInterface>();
        }
        #endregion

        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="entity">欲添加的数据</param>
        /// <param name="status">操作状态</param>
        public virtual void Create(TEntity entity, out OperateStatus status)
        {
            BusinessLogic.Create(entity, out status);
        }
        /// <summary>
        /// 更新方法
        /// </summary>
        /// <param name="entity">欲更新的数据</param>
        /// <param name="status">操作状态</param>
        public virtual void Update(TEntity entity, out OperateStatus status)
        {
            BusinessLogic.Update(entity, out status);
        }
        /// <summary>
        /// 删除方法
        /// </summary>
        /// <param name="id">欲删除的数据Id</param>
        /// <param name="status">操作状态</param>
        public virtual void Delete(Guid id, out OperateStatus status)
        {
            BusinessLogic.Delete(id, out status);
        }
    }
}
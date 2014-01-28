using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Titan.Common.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Entities;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.Business.Interface
{
    /// <summary>
    /// 预约事件业务逻辑层接口
    /// </summary>
    public interface IEventsLogic : IEntityBaseLogic<Events>
    {
        /// <summary>
        /// 删除方法
        /// </summary>
        /// <param name="entity">欲删除的数据实体，包括Id和修改时间和修改人</param>
        /// <param name="status">操作状态</param>
        void Delete(Events entity, out OperateStatus status);
        
        /// <summary>
        /// 返回所有高级查询的结果
        /// </summary>
        /// <typeparam name="TQueryParam">AdvQueryParam类型查询参数</typeparam>
        /// <param name="queryParam">高级查询参数</param>
        /// <returns>满足条件的所有结果集</returns>
        IList<Events> GetAdvQueryAll<TQueryParam>(TQueryParam queryParam) where TQueryParam : AdvQueryParam;

        /// <summary>
        /// 移动预约事件
        /// </summary>
        /// <param name="param">当前事件信息，需要Id、当前SortIndex，如果需要改变状态，可以传入Status</param>
        /// <param name="status">操作状态</param>
        void MoveEvent(EventsMoveParam param, out OperateStatus status);
    }
}

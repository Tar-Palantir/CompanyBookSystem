using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ITS.CompanyBookSystem.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.UI.Front.Models
{
    /// <summary>
    /// 预订对象模型
    /// </summary>
    public class BookObjectModel : BookSystemBaseModel<IBookObjectLogic, BookObject>
    {
        /// <summary>
        /// 根据Id获取主要信息
        /// </summary>
        /// <param name="id">数据Id</param>
        /// <returns>信息</returns>
        public BookObject GetById(Guid id)
        {
            return BusinessLogic.GetById(id);
        }

        /// <summary>
        /// 高级查询获取全部
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public IList<BookObject> GetAdvQueryAll(BookObjectQueryParam param)
        {
            var results= BusinessLogic.GetAdvQueryAll(param);
            foreach (var bookObject in results)
            {
                bookObject.BookObjectType = null;
                bookObject.BookRecords = null;
                bookObject.ObjectStyle = null;
            }
            return results;
        }
    }
}
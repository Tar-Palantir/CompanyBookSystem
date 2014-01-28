using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ITS.CompanyBookSystem.Business.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;
using Titan.Common.DataAccess.Entities;

namespace ITS.CompanyBookSystem.UI.BehindUI.Models
{
    /// <summary>
    /// 预订对象模型
    /// </summary>
    public class BookObjectModel : BookSystemBaseModel<IBookObjectLogic, BookObject>
    {
        /// <summary>
        /// 获取全部
        /// </summary>
        /// <returns>结果集</returns>
        public IList<BookObject> GetAll()
        {
            return BusinessLogic.GetAll();
        }

        /// <summary>
        /// 高级查询获取全部
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public IList<BookObject> GetAdvQueryAll(BookObjectQueryParam param)
        {
            var results = BusinessLogic.GetAdvQueryAll(param);
            foreach (var bookObject in results)
            {
                bookObject.BookObjectType = null;
                bookObject.BookRecords = null;
                bookObject.ObjectStyle = null;
            }
            return results;
        }

        /// <summary>
        /// 高级查询
        /// </summary>
        /// <param name="param">查询参数</param>
        /// <returns>分页后的查询结果</returns>
        public PagedResults<BookObjectResult> AdvQuery(BookObjectQueryParam param)
        {
            var sourceResults = BusinessLogic.AdvQuery(param);

            PagedResults<BookObjectResult> results = new PagedResults<BookObjectResult>();
            results.Data = new List<BookObjectResult>(sourceResults.Data.Count);
            results.PagerInfo = sourceResults.PagerInfo;

            foreach (var item in sourceResults.Data)
            {
                results.Data.Add(new BookObjectResult()
                {
                    Id = item.Id,
                    BookObjectTypeId = item.BookObjectTypeId,
                    BookObjectTypeName = item.BookObjectType.Name,
                    ObjectStyleId = item.ObjectStyleId,
                    ObjectStyleName = item.ObjectStyleId == null ? "默认" : item.ObjectStyle.Name,
                    Describe = item.Describe,
                    Location = item.Location,
                    Name = item.Name,
                    State = item.State
                });
            }

            return results;

        }
    }
}
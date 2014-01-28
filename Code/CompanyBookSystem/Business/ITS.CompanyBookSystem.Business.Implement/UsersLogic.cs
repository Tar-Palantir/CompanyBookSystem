using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Entity;
using ITS.CompanyBookSystem.DataAccess.Interface;
using ITS.CompanyBookSystem.Business.Interface;
using Titan.Common.DataStatus;

namespace ITS.CompanyBookSystem.Business.Implement
{
    /// <summary>
    /// 后台用户业务逻辑层实现
    /// </summary>
    public class UsersLogic : BookSystemBaseEntityLogic<IUsersRepository, Users>, IUsersLogic
    {
        #region 构造函数
        /// <summary>
        /// 用于工厂实例化数据层实现类的构造函数
        /// </summary>
        /// <param name="repository">实现数据层接口的对象</param>
        public UsersLogic(IUsersRepository repository)
            : base(repository)
        {
        }
        #endregion

        #region 重写父类方法
        /// <summary>
        /// 添加用户
        /// </summary>
        /// <param name="entity">欲添加的实体</param>
        /// <param name="status">操作状态</param>
        public override void Create(Users entity, out OperateStatus status)
        {
            entity.Password = Titan.Common.Helper.PasswordHasher.Hash(entity.Password);
            base.Create(entity, out status);
        }

        /// <summary>
        /// 更新方法
        /// </summary>
        /// <param name="entity">欲更新的实体数据</param>
        /// <param name="status">操作状态</param>
        public override void Update(Users entity, out OperateStatus status)
        {
            Users oldUser = GetById(entity.Id);
            if (oldUser.Password != entity.Password)
            {
                entity.Password = Titan.Common.Helper.PasswordHasher.Hash(entity.Password);
            }
            base.Update(entity, out status);
        }
        #endregion


        /// <summary>
        /// 用户登录检验
        /// </summary>
        /// <param name="user">欲登录的用户</param>
        /// <returns>返回是否允许登录</returns>
        public bool UserLoginCheck(Users user)
        {
            string userPassword = Titan.Common.Helper.PasswordHasher.Hash(user.Password);

            var userCount = Repository
                .QueryWhere(p => p.LoginName == user.LoginName && p.Password == userPassword)
                .Where(p => p.State == (int)StateSign.Normal)
                .Count();
            return userCount == 1 ? true : false;
        }
    }
}

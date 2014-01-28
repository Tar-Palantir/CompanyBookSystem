using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ITS.CompanyBookSystem.DataAccess.Interface;
using ITS.CompanyBookSystem.DataAccess.Entity;

namespace ITS.CompanyBookSystem.DataAccess.Implement
{
    /// <summary>
    /// 后台用户数据访问层实现
    /// </summary>
    public class UsersRepository : BookSystemBaseRepository<Users>, IUsersRepository
    {
    }
}

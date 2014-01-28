using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using Titan.Common.UI.Attributes;

namespace ITS.CompanyBookSystem.UI.BehindUI.Models
{
    /// <summary>
    /// 登录模型
    /// </summary>
    public class LoginModel
    {
        [Required]
        [Display(Name = "登录名")]
        [StringLength(20)]
        public string LoginName { set; get; }

        [Required]
        [Display(Name="密码")]
        [StringLength(20)]
        public string Password { set; get; }

        [Required]
        [Display(Name="验证码")]
        [StringLength(10)]
        [VerifyCode(ErrorMessage="验证码错误")]
        public string VerifyCode { set; get; }
    }
}
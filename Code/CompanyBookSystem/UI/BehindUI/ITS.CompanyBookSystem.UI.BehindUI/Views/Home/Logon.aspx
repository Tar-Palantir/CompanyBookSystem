<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ITS.CompanyBookSystem.UI.BehindUI.Models.LoginModel>" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>天府软件园有限公司外包解决方案中心预订系统后台管理网站</title>
    <link rel="stylesheet" type="text/css" href="../../Content/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../../Content/themes/login/login.css" />
    <script type="text/javascript" src="../../Scripts/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../../Scripts/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../Scripts/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <div id="updateBrowser" title="浏览器升级">
        <h1 style="margin: 0; padding: 0; height: 15px; font-size: 15px;">
            您的浏览器版本太低，请选择下面几款浏览器之一，点击下载安装</h1>
        <div>
            <a href="http://windows.microsoft.com/zh-CN/internet-explorer/downloads/ie-8" title="点击下载IE8">
                Microsoft Internet Explorer 8 </a>
            <br />
            <span style="font-size: 12px;">(如果您的操作系统是vista sp2或win7，更好的选择是安装<a style="font-size: 13px;
                font-weight: bold" title="点击下载IE9" href="http://windows.microsoft.com/zh-CN/internet-explorer/products/ie/home">Microsoft
                Internet Explorer 9</a>)</span>
        </div>
        <div>
            <a href="http://firefox.com.cn/" title="点击下载Mozilla Firefox">火狐浏览器(Mozilla Firefox)
            </a>
        </div>
        <%--<div id="download-chrome-container" class="download-browser">
			<span id="logo-chrome" class="browserLogo" title="点击下载Google Chrome"></span>
			<span id="download-chrome" class="download-url" title="点击下载Google Chrome">						
				<a href="http://www.google.com/chrome">
					谷歌浏览器(Google Chrome)
				</a>
			</span>
		</div>--%>
    </div>
    <div id="box">
        <div class="box">
            <% using (Html.BeginForm())
               { %>
            <table class="main">
                <tr>
                    <td>
                    </td>
                    <td colspan="2">
                        <span style="color: Red;">
                            <%=Html.ValidationSummary(false)%>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="header">
                        <%:Html.LabelFor(m=>m.LoginName)%>:
                    </td>
                    <td>
                        <input class="easyui-validatebox" type="text" id="LoginName" name="LoginName" required="true"
                            validtype="length[1,20]" value="<%:Model==null?"":Model.LoginName %>" />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="header">
                        <%:Html.LabelFor(m => m.Password)%>:
                    </td>
                    <td>
                        <input class="easyui-validatebox" type="password" id="Password" name="Password" required="true"
                            validtype="length[6,20]" value="" />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="header">
                        <%:Html.LabelFor(m => m.VerifyCode)%>:
                    </td>
                    <td>
                        <input type="text" id="VerifyCode" name="VerifyCode" />
                    </td>
                    <td valign="middle">
                        <%=Html.VerifyCode()%>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="btn">
                        <input type="submit" style="width: 80px; height: 30px;" value="登录" onclick="return check();" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="info">
                        <%--<a href="">用户手册</a> | <a href="网站前台">网站前台</a> | <span>Powerby tianfusoftwarepark Co.Ltd</span>--%>
                    </td>
                </tr>
            </table>
            <% } %>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">


    function check() {
        //表单验证
        if (!$("#formRelatedLink").form("validate")) {
            return false;
        } else {
            return true;
        }
    }

    var updateBrowser_dialogSettging = {
        autoOpen: false,
        modal: true,
        width: 700,
        height: 420,
        closeOnEscape: false,
        open: function (event, ui) {
            $(this).prev().find("a.ui-dialog-titlebar-close").remove();
        }
    };

    $(function () {

        if (window.top != window.self) {
            window.parent.location = "../../Home/Logon/";
        }

        $("#logo-ie8").click(function () {
            window.location = "http://windows.microsoft.com/zh-CN/internet-explorer/downloads/ie-8";
        });
        $("#logo-firefox").click(function () {
            window.location = "http://firefox.com.cn/";
        });
        //            $("#logo-chrome").click(function () {
        //                window.location = "http://www.google.com/chrome";
        //            });
        $("#download-flashPlayer").click(function () {
            window.location = "http://get.adobe.com/cn/flashplayer/";
        });
        $("#updateBrowser").dialog(updateBrowser_dialogSettging);

        var firefoxVer = navigator.userAgent.indexOf("Firefox");

        if (firefoxVer > 2) {
            $("#updateBrowser").dialog("close");
        }

        if ($.browser.msie) {
            var version = parseInt($.browser.version);
            if (version < 8) {
                $("#container").hide();
                $("#updateBrowser").dialog("open");
            }
            else {
                $("#updateBrowser").dialog("close");
            }
        }


    });
</script>


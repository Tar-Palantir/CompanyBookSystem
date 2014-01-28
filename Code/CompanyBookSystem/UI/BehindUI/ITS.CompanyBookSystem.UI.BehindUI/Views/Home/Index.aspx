<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ViewMaster.Master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    天府软件园有限公司外包解决方案中心预订系统后台管理系统
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ResourceContent" runat="server">
    <!--页面初始化-->
    <script type="text/javascript">
        function addTab(title, url) {
            if ($("#mytabs").tabs("exists", title)) {
                $("#mytabs").tabs("select", title)
            } else {
                var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
                $('#mytabs').tabs('add', {
                    title: title,
                    content: content,
                    closable: true
                });
            }
        }

        $(window).resize(function () {
            $('#mytabs').tabs('resize');
        });

    </script>
    <!--功能操作-->
    <script type="text/javascript">

        function LogOut() {
            window.location = "../../Home/LogOut/";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div region="north" title="预订系统后台管理系统" split="true" style="background-position: left top;
        height: 120px; background-color: #dde8fc; background-repeat: no-repeat; background-image: url(../../Content/Styles/images/header_bg_90.png)">
        <div style="width: 280px; position: absolute; bottom: 0px; right: 0px">
            <a href="javascript:void(0);" class="icon-logon" onclick="">欢迎您:管理员</a><a id="linkbtnquit" class="icon-logout"
                    href="javascript:void(0)" onclick="LogOut();">退出系统</a>
        </div>
    </div>
    <div region="center" title="操作中心" style="overflow: hidden;">
        <div id="mytabs" class="easyui-tabs" fit="true" border="false">
            <div title="系统功能配置" style="background-position: left top; padding-left: 20px; overflow: hidden;
                background-repeat: no-repeat; background-image: url(../../Content/Styles/images/content_bg.jpg)">
                <div style="margin-top: 20px;">
                    <a href="javascript:void(0);" class="icon-system2" onclick="addTab('部门管理','../../Departments/Index/')">
                        部门管理</a> <a href="javascript:void(0);" class="icon-system2" onclick="addTab('预订对象类型管理','../../BookObjectType/Index/')">
                            预订对象类型管理</a> <a href="javascript:void(0);" class="icon-system2" onclick="addTab('预订对象管理','../../BookObject/Index/')">
                                预订对象管理</a> <a href="javascript:void(0);" class="icon-system2" onclick="addTab('预订对象样式管理','../../ObjectStyle/Index/')">
                                    预订对象样式管理</a><a href="javascript:void(0);" class="icon-system2" onclick="addTab('预订记录管理','../../BookRecords/Index/')">
                                    预订记录管理</a><a href="javascript:void(0);" class="icon-system2" onclick="addTab('预约人员管理','../../Persons/Index/')">
                                    预约人员管理</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomScript" runat="server">
</asp:Content>

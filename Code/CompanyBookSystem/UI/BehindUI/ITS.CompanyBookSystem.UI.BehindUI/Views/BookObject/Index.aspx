<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ViewMaster.Master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ResourceContent" runat="server">
    <!--功能菜单-->
    <script type="text/javascript">
        var toolbar_buttons = [{
            id: 'btnRefresh',
            text: '刷新',
            iconCls: 'icon-reload',
            handler: function () { Refresh(); }
        }, {
            id: 'btnAdd',
            text: '添加',
            iconCls: 'icon-add',
            handler: function () {
                isEdit = false;
                $('#txtBookObjectName').val("");
                $('#txtBookObjectLocation').val("");
                $('#txtBookObjectDescribe').val("");
                $('#ddlObjectStyle').combobox("setValue", "00000000-0000-0000-0000-000000000000");
                CreateOrUpdateWindowOpen();
            }
        }, {
            id: 'btnEdit',
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                isEdit = true;

                var rows = $('#BookObjectList').datagrid('getSelections');
                if (rows == null || rows.length != 1) {
                    $.messager.alert('错误', '请选择一条记录！');
                    return;
                }

                var data = $('#BookObjectList').datagrid('getSelected');
                $('#txtBookObjectName').val(data.Name);
                $('#txtBookObjectDescribe').val(data.Describe);
                $('#ddlBookObjectType').combobox("setValue", data.BookObjectTypeId);
                $('#ddlObjectStyle').combobox("setValue", data.ObjectStyleId);
                $('#txtBookObjectLocation').val(data.Location);
                CreateOrUpdateWindowOpen();
            }
        }, {
            id: 'btnDelete',
            text: '删除',
            iconCls: 'icon-remove',
            handler: function () {
                var rows = $('#BookObjectList').datagrid('getSelections');
                if (rows == null || rows.length != 1) {
                    $.messager.alert('错误', '请选择一条记录！');
                    return;
                }
                Delete();

            }
        }, {
            id: 'btnSearch',
            text: '搜索',
            disabled: false,
            iconCls: 'icon-search',
            handler: function () {
                Search();
            }
        }];
    </script>
    <!--添加,修改窗体-->
    <script type="text/javascript">

        $(function () { Cancel(); });
        var isEdit = true;
        function CreateOrUpdateWindowOpen() {

            $('#dic_BookObject').window({
                title: '预订对象维护',
                width: 420,
                height: 350,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                modal: true
            });
        }

        //退出
        function Cancel() {
            $('#dic_BookObject').window('close');
        }

        //保存
        function SaveItem() {
            //表单验证
            if (!$("#BookObject").form("validate")) {
                return;
            }

            //封装数据
            var entity = {
                Name: $('#txtBookObjectName').val(),
                BookObjectTypeId: $('#ddlBookObjectType').combobox('getValue'),
                ObjectStyleId: $('#ddlObjectStyle').combobox('getValue'),
                Location: $('#txtBookObjectLocation').val(),
                Describe: $('#txtBookObjectDescribe').val()
            };
            if (!isEdit) {
                //新建
                $.post("../../BookObject/Create/",
                    entity,
                    function (status) {
                        if (status != undefined) {
                            $.messager.alert("操作提示", status.Message == undefined ? status : status.Message);
                            if (status.Succeed) {
                                isEdit = true;
                                $('#dic_BookObject').window('close');
                                $('#BookObjectList').datagrid('reload');
                            }
                        }
                    }
                );

            } else {
                entity.Id = $('#BookObjectList').datagrid('getSelected').Id;
                //更新
                $.post("../../BookObject/Update/",
                        entity,
                        function (status) {
                            if (status != undefined) {
                                $.messager.alert("操作提示", status.Message == undefined ? status : status.Message);
                                if (status.Succeed) {
                                    isEdit = true;
                                    $('#dic_BookObject').window('close');
                                    $('#BookObjectList').datagrid('reload');
                                }
                            }
                        }
                    );

            }
        }
    </script>
    <!--查询-->
    <script type="text/javascript">
        $(function () {
            $('#BookObjectList').datagrid({
                noheader: true,
                iconCls: 'icon-add',
                title: '标题',
                toolbar: toolbar_buttons,
                width: 700,
                height: 350,
                nowrap: false,
                striped: true,
                fit: true,
                singleSelect: true,
                url: '../../BookObject/AdvQuery/',
                sortName: 'Name',
                sortOrder: 'desc',
                remoteSort: false,
                queryParams: {
                    SortName: 'Name'
                },
                frozenColumns: [[
	               { field: 'Name', title: '名称', width: 120, sortable: true,
	                   sorter: function (a, b) {
	                       return (a > b ? 1 : -1);
	                   }
	               }
				]],
                columns: [[
                    { field: 'BookObjectTypeName', title: '类型', width: 150, rowspan: 2 },
                    { field: 'Location', title: '所在位置', width: 150, rowspan: 2 },
                    { field: 'ObjectStyleName', title: '样式', width: 150, rowspan: 2 },
                    { field: 'Describe', title: '描述', width: 400, rowspan: 2 }
				]],
                pagination: true,
                rownumbers: true
            });
            var p = $('#BookObjectList').datagrid('getPager');
            $(p).pagination({
        });
    });

    function Search() {
        var data;
        if ($("#searchfiled").val() == "请输入标题关键字") {
            data = {
                Name: "",
                TypeId: $('#ddlType').combobox('getValue'),
                SortName: "Name"
            }
        }
        else {
            data = {
                Name: $("#searchfiled").val(),
                TypeId: $('#ddlType').combobox('getValue'),
                SortName: "Name"
            }
        }

        $.post("../../BookObject/AdvQuery/",
                data,
                 function (status) {
                     $('#BookObjectList').datagrid("reload", data);
                 });
    }

    //刷新列表
    function Refresh() {
        $('#BookObjectList').datagrid('load');
    }

    </script>
    <!--搜索框输入提示-->
    <script type="text/javascript">
        $(document).ready(function () {
            $('#searchfiled').focus(function () {
                if ($('#searchfiled').val() == "请输入标题关键字") {
                    $('#searchfiled').val("");
                    $('#searchfiled').css({ color: "#000000" });
                }
            });
            $('#searchfiled').focusout(function () {
                if ($('#searchfiled').val() == "") {
                    $('#searchfiled').val("请输入标题关键字");
                    $('#searchfiled').css({ color: "#ccc" });
                }
            });
        })
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div region="north" border="false" style="height: auto;">
        <div id="search-wrapper">
            <p>
                快速查询：<input id="searchfiled" value="请输入标题关键字" style="width: 200px; color: #ccc" onblur="res();" />预订对象类型：<input
                    type="text" class="easyui-combobox" id="ddlType" url="/BookObjectType/GetAll/?isSearch=true"
                    valuefield="Id" textfield="Name" value="00000000-0000-0000-0000-000000000000"
                    style="width: 184px" panelheight="auto" />
            </p>
        </div>
    </div>
    <div region="center">
        <table id="BookObjectList">
        </table>
    </div>
    <div id="dic_BookObject" class="easyui-window" title="My Window" iconcls="icon-save"
        style="width: 600px; height: 250px; padding: 5px;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form id="BookObject" method="post">
                <div class="content" style="top: 4px; bottom: 4px; overflow-y: hidden">
                    <dt class="full">
                        <label for="">
                            名称<span class="req">*</span></label>
                        <input class="easyui-validatebox" type="text" validtype="length[2,20]" name="name"
                            id="txtBookObjectName" value="" required="true" tabindex="1" />
                    </dt>
                    <dt class="full">
                        <label for="">
                            类型<span class="req">*</span></label>
                        <input type="text" class="easyui-combobox" id="ddlBookObjectType" url="/BookObjectType/GetAll/?isSearch=false"
                            valuefield="Id" textfield="Name" value="" style="width: 184px" panelheight="auto"
                            required="true" />
                    </dt>
                    <dt class="full">
                        <label for="">
                            样式<span class="req">*</span></label>
                        <input type="text" class="easyui-combobox" id="ddlObjectStyle" url="/ObjectStyle/GetAll/"
                            valuefield="Id" textfield="Name" value="00000000-0000-0000-0000-000000000000" style="width: 184px" panelheight="auto" />
                    </dt>
                    <dt class="full">
                        <label for="">
                            所在位置<span class="req">*</span></label>
                        <input class="easyui-validatebox" type="text" validtype="length[2,50]" name="name"
                            id="txtBookObjectLocation" value="" required="true" tabindex="1" />
                    </dt>
                    <dt class="full">
                        <label for="">
                            描述
                        </label>
                        <textarea class="easyui-validatebox" id="txtBookObjectDescribe" tabindex="2" rows="4"
                            cols="30" validtype="length[0,200]" style="width: 180px"></textarea>
                    </dt>
                </div>
                </form>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a class="easyui-linkbutton" tabindex="3" iconcls="icon-save" href="javascript:void(0)"
                    onclick="javascript:SaveItem();">保存</a> <a class="easyui-linkbutton" tabindex="4"
                        iconcls="icon-cancel" href="javascript:void(0)" onclick="javascript:Cancel();">取消</a>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomScript" runat="server">
</asp:Content>

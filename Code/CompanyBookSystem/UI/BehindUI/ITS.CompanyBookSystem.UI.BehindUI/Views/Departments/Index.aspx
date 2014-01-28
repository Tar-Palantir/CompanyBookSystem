<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ViewMaster.Master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div region="north" border="false" style="height: auto;">
        <div id="search-wrapper">
            <p>
                快速查询：<input id="ss" class="easyui-searchbox" maxlength="100" searcher="qq" prompt="请输入部门名称关键字进行查询"
                    style="width: 200px" />
            </p>
        </div>
    </div>
    <div region="center">
        <table id="data">
        </table>
    </div>
    <div id="dic_Departments" class="easyui-window" title="My Window" iconcls="icon-save"
        style="width: 600px; height: 250px; padding: 5px;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form id="Departments" method="post">
                <div class="content" style="top: 4px; bottom: 4px; overflow-y: hidden">
                    <dt class="full">
                        <label for="">
                            部门名称<span class="req">*</span></label>
                        <input class="easyui-validatebox" type="text" validtype="length[2,20]" name="name"
                            id="txtDepartmentName" value="" required="true" tabindex="1" />
                    </dt>
                    <dt class="full">
                        <label for="">
                            部门负责人<span class="req">*</span>
                        </label>
                        <input class="easyui-validatebox" type="text" validtype="length[2,10]" name="name"
                            id="txtDepartmentMinister" value="" required="true" tabindex="1" />
                    </dt>
                    <dt class="full">
                        <label for="">
                            描述
                        </label>
                        <textarea class="easyui-validatebox" id="txtDepartmentDescribe" tabindex="2" rows="4"
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
<asp:Content ID="resourceContent" ContentPlaceHolderID="ResourceContent" runat="server">
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
                $('#txtDepartmentName').val("");
                $('#txtDepartmentMinister').val("");
                $('#txtDepartmentDescribe').val("");
                CreateOrUpdateWindowOpen();
                //$('#dic_Departments').window('open');
            }
        }, {
            id: 'btnEdit',
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                isEdit = true;

                var rows = $('#data').datagrid('getSelections');
                if (rows == null || rows.length != 1) {
                    $.messager.alert('错误', '请选择一条记录！');
                    return;
                }

                var data = $('#data').datagrid('getSelected');
                $('#txtDepartmentName').val(data.Name);
                $('#txtDepartmentMinister').val(data.Minister);
                $('#txtDepartmentDescribe').val(data.Describe);
                CreateOrUpdateWindowOpen();
                //$('#dic_Departments').window('open');
            }
        }, {
            id: 'btnDelete',
            text: '删除',
            iconCls: 'icon-remove',
            handler: function () {
                var rows = $('#data').datagrid('getSelections');
                if (rows == null || rows.length != 1) {
                    $.messager.alert('错误', '请选择一条记录！');
                    return;
                }
                Delete();

            }
        }];
    </script>
    <!--添加,修改窗体-->
    <script type="text/javascript">

        var isEdit = true;
        function CreateOrUpdateWindowOpen() {

            $('#dic_Departments').window({
                title: '部门维护',
                width: 420,
                height: 300,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                modal: true
            });
        }

        //退出
        function Cancel() {
            $('#dic_Departments').window('close');
        }

        //保存
        function SaveItem() {
            //表单验证
            if (!$("#Departments").form("validate")) {
                return;
            }

            //封装数据
            var entity = {
                Name: $('#txtDepartmentName').val(),
                Minister: $('#txtDepartmentMinister').val(),
                Describe: $('#txtDepartmentDescribe').val()
            };
            if (!isEdit) {
                //新建
                $.post("../../Departments/Create/",
                    entity,
                    function (status) {
                        if (status != undefined) {
                            $.messager.alert("操作提示", status.Message == undefined ? status : status.Message);
                            if (status.Succeed) {
                                isEdit = true;
                                $('#dic_Departments').window('close');
                                $('#data').datagrid('reload');
                            }
                        }
                    }
                );

            } else {
                entity.Id = $('#data').datagrid('getSelected').Id;
                //更新
                $.post("../../Departments/Update/",
                        entity,
                        function (status) {
                            if (status != undefined) {
                                $.messager.alert("操作提示", status.Message == undefined ? status : status.Message);
                                if (status.Succeed) {
                                    isEdit = true;
                                    $('#dic_Departments').window('close');
                                    $('#data').datagrid('reload');
                                }
                            }
                        }
                    );

            }
        }
    </script>
    <!--删除-->
    <script type="text/javascript">
        function Delete() {
            var entity = $('#data').datagrid('getSelected');
            $.messager.confirm('删除提醒', '您确定要删除所选记录?', function (r) {
                if (r) {
                    $.post("../../Departments/Delete/",
                                entity,
                                function (status) {
                                    if (status != undefined) {
                                        if (status.Succeed) {
                                            $.messager.alert('成功', '删除成功！');
                                            $('#data').datagrid('clearSelections');
                                            $('#data').datagrid('reload');
                                        }
                                        else {
                                            $.messager.alert('失败', '删除失败！');
                                        }
                                    }
                                }
                                );
                }
            });
        }

    </script>
    <!--页面初始化、查询和刷新-->
    <script type="text/javascript">

        //初始化
        $(function () {
            Cancel();
            ConditionQuery();
        });

        //条件查询
        function ConditionQuery(value) {
            $('#data').datagrid({
                noheader: true,
                iconCls: 'icon-add',
                title: '标题',
                toolbar: toolbar_buttons,
                width: 700,
                height: 350,
                nowrap: false,
                striped: true,
                fit: true,
                url: '../../Departments/QuickQuery/',
                sortOrder: 'desc',
                remoteSort: false,
                queryParams: {
                    Value: value,
                    SortName: 'Name'
                },
                idField: 'Name',
                columns: [[
                    { field: 'Name', title: '部门名称', width: 200, align: 'center', sortable: true },
                    { field: 'Minister', title: '部门负责人', width: 200, align: 'center', sortable: true },
                    { field: 'Describe', title: '描述', width: 400, align: 'left' }
				]],
                singleSelect: true,
                fitColumns: true,
                pagination: true,
                rownumbers: true
            });
            var p = $('#data').datagrid('getPager');
            $(p).pagination();
        }

        //刷新栏目列表
        function Refresh() {
            $('#data').datagrid('load');
        }

        //搜索
        function qq(value) {
            ConditionQuery(value);
        }
    </script>
</asp:Content>
<asp:Content ID="BottomScript" ContentPlaceHolderID="BottomScript" runat="server">
</asp:Content>

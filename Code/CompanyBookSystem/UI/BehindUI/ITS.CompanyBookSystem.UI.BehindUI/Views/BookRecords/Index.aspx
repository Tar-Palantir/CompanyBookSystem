<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ViewMaster.Master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div region="north" border="false" style="height: auto;">
        <div id="search-wrapper">
            <p>
                快速查询关键字：<input id="txtName" style="width: 200px; color: #ccc" value="请输入描述关键字进行查询" />
                部门名称：
                <input class="easyui-combobox" name="ddlDepartment" url="../../Departments/GetAll/"
                    id="ddlDepartment" valuefield="Id" textfield="Name" value="00000000-0000-0000-0000-000000000000"
                    style="width: 184px" panelheight="auto" />
                预订类型：
                <input class="easyui-combobox" name="ddlBookObjectType" url="../../BookObjectType/GetAll/?isSearch=true"
                    id="ddlBookObjectType" valuefield="Id" textfield="Name" value="00000000-0000-0000-0000-000000000000"
                    style="width: 184px" panelheight="auto" />
                预订对象:</label><input id="ddlBookObject" class="easyui-combobox" url="../../BookObject/GetAllByType/" valuefield="Id"
                    textfield="Name" value="00000000-0000-0000-0000-000000000000" style="width: 184px"
                    panelheight="auto" />
            </p>
            <p>
                开始时间：<input id="txtStartTime" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'yyyy年MM月dd日',startDate:'%y-%M-01',maxDate:'#F{$dp.$D(\'txtEndTime\')}'})"
                    class="Wdate" readonly="readonly" />
                结束时间：<input id="txtEndTime" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'yyyy年MM月dd日',minDate:'#F{$dp.$D(\'txtStartTime\')}'})"
                    class="Wdate" readonly="readonly" /></p>
        </div>
    </div>
    <div region="center">
        <table id="data">
        </table>
    </div>
</asp:Content>
<asp:Content ID="rescourceContent" ContentPlaceHolderID="ResourceContent" runat="server">
    <script src="../../Scripts/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <!--搜索的输入框输入提示-->
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtName').focus(function () {
                if ($('#txtName').val() == "请输入描述关键字进行查询") {
                    $('#txtName').val("");
                    $('#txtName').css({ color: "#000000" });
                }
            });
            $('#txtName').focusout(function () {
                if ($('#txtName').val() == "") {
                    $('#txtName').val("请输入描述关键字进行查询");
                    $('#txtName').css({ color: "#ccc" });
                }
            });
        })
        
    </script>
    <!--时间格式化-->
    <script type="text/javascript">
        //时间格式化
        Date.prototype.format = function (format) {
            if (!format) {
                format = "yyyy-MM-dd hh:mm:ss";
            }
            var o = {
                "M+": this.getMonth() + 1, // month  
                "d+": this.getDate(), // day
                "h+": this.getHours(), // hour
                "m+": this.getMinutes(), // minute
                "s+": this.getSeconds(), // second 
                "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
                "S": this.getMilliseconds() // millisecond 
            };
            if (/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            }
            for (var k in o) {
                if (new RegExp("(" + k + ")").test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
                }
            }
            return format;
        };

        function fomatDate(str, format) {
            return (new Date(parseInt(str.substring(str.indexOf('(') + 1, str.indexOf(')'))))).format(format);
        }
    </script>
    <!--工具栏-->
    <script type="text/javascript">
        var toolbar_buttons = [{
            id: 'btnRefresh',
            text: '刷新',
            iconCls: 'icon-reload',
            handler: function () {
                Refresh();
            }
        },
        {
            id: 'btnDetail',
            text: '查看明细',
            iconCls: 'icon-listview',
            handler: function () {
                var rows = $('#data').datagrid('getSelections');
                if (rows == null || rows.length != 1) {
                    $.messager.alert('错误', '请选择一条记录！');
                    return;
                }
                Detail();
            }
        }, {
            id: 'btnEdit',
            text: '编辑',
            iconCls: 'icon-edit',
            handler: function () {
                var selectedDate = $('#data').datagrid('getSelected');
                if (selectedDate == null) {
                    $.messager.alert('错误', '请选择一条记录！');
                    return;
                }
                window.location = "../../BookRecords/Update/?id=" + selectedDate.Id;
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
        }, {
            id: 'btnSearch',
            text: '搜索',
            disabled: false,
            iconCls: 'icon-search',

            handler: function () { Search(); }
        }];

    </script>
    <!--页面初始化、查询和刷新-->
    <script type="text/javascript">

        //初始化
        $(function () {
            ConditionQuery();

            $('#ddlBookObjectType').combobox({
                onSelect: function (e, source) {
                    $('#ddlBookObject').combobox("setValue", "00000000-0000-0000-0000-000000000000");
                    $('#ddlBookObject').combobox("reload", '../../BookObject/GetAllByType/?typeId=' + e.Id);
                }
            });

            //设置下拉列表为只读
            $("#ddlBookObjectType").combobox('textbox').attr("readonly", true);
            $("#ddlBookObject").combobox('textbox').attr("readonly", true);
            $("#ddlDepartment").combobox('textbox').attr("readonly", true);
        });

        function ConditionQuery() {
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
                url: '../../BookRecords/AdvQuery/',
                sortOrder: 'desc',
                remoteSort: false,
                queryParams: {
                    SortName: 'DateCreated',
                    SortOrder: 'desc'
                },
                frozenColumns: [[
					{ field: 'BookObjectName', title: '预订对象', width: 140
					}
                    ]],
                columns: [[
					{ field: 'DepartmentName', title: '预订所属部门', width: 140 },
                    { field: 'UsingTime', title: '使用时间', width: 400, rowspan: 2
                    },
                    { field: 'Describe', title: '描述', width: 400, rowspan: 2
                    },
                    { field: 'Creator', title: '预订人', width: 100, align: 'center', sortable: true },
                    { field: 'Tel', title: '联系电话', width: 100, rowspan: 2
                    },
                    { field: 'DateCreated', title: '创建日期', width: 120, align: 'center', sortable: true,
                        formatter: function (value, rec, ri) {
                            if (value == null)
                                return value;
                            else
                                return fomatDate(value.toString(), "yyyy-MM-dd hh:mm");
                        }
                    }
				]],
                singleSelect: true,
                //                fitColumns: true,
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
        function Search() {
            var entity = {
                DepartmentId: $('#ddlDepartment').combobox('getValue'),
                StartDate: $("#txtStartTime").val(),
                EndDate: $("#txtEndTime").val(),
                Value: function () {
                    if ($('#txtName').val() != "请输入描述关键字进行查询") {
                        return $("#txtName").val();
                    }
                    else {
                        return "";
                    }
                },
                SortName: 'DateCreated',
                SortOrder: 'desc'
            };
            var objectId = $("#ddlBookObject").combobox("getValue");
            if (objectId != "00000000-0000-0000-0000-000000000000") {
                entity.BookObjectId = objectId;
            }
            else {
                entity.TypeId = $("#ddlBookObjectType").combobox('getValue');
            }
            var result = $('#data').datagrid('load', entity);
        }
    </script>
    <!--查看明细、删除-->
    <script type="text/javascript">
        //查看明细
        function Detail() {

            var entity = $('#data').datagrid('getSelected');

            var id = entity.Id;
            location.href = "../../BookRecords/Detail/?id=" + id;
        }


        function Delete() {
            var entity = $('#data').datagrid('getSelected');
            $.messager.confirm('删除提醒', '您确定要删除所选记录?', function (r) {
                if (r) {
                    $.post("../../BookRecords/Delete/",
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomScript" runat="server">
</asp:Content>

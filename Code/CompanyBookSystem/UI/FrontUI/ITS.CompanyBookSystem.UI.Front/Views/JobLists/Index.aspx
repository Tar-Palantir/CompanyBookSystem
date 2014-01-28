<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>人员工作安排</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../../Style/ajaxlists.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/dragbox-style.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/jPaginate-style.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/index.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/easyui-combobox.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-ui-1.7.2.custom.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.paginate.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.cookie.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.jsoncookie.js" type="text/javascript"></script>
    <script src="../../Scripts/ajaxLists.js" type="text/javascript"></script>
    <script type="text/javascript">
        function AjaxListsLoad(queryParam) {
            $("#processingList").ajaxlists({ url: "../../JobLists/GetProcessingEvents/", queryParam: queryParam, editable: true });

            var page = $("#finishedList").ajaxlists("GetPage");
            //alert(page);
            queryParam.Page = page;
            $("#finishedList").ajaxlists({ url: "../../JobLists/GetFinishedEvents/", queryParam: queryParam, editable: false });
            
        }
        $(function () {
            $("*").error(function () {
                if ($("#divLoading").length != 0) {
                    if ($("#divLoading").css("display") == "block") {
                        $("#divLoading").css("display", "none");
                    }
                }
            });

            AjaxListsLoad({});
        })
    </script>
    <script type="text/javascript">

        function Create() {
            var entity = {
                PersonsId: $("#ddlPersons").combobox("getValue"),
                Title: $("#create_title").val(),
                Creator: $("#create_creator").val(),
                PlanWorkTime: $("#create_planworktime").val(),
                DepartmentId: $("#create_departments").combobox("getValue"),
                Describe: $("#create_describe").val()
            };
            if ($("#divLoading").length == 0) {
                $(document.body).children(":last").after("<div id='divLoading' class='loading'><div>请稍后……</div></div>");
            }
            $("#divLoading").css("display", "block");
            $.post("../../JobLists/Create/", entity, function (status) {
                if (status != undefined) {
                    $("#divLoading").css("display", "none");
                    if (status.Succeed) {
                        Refresh();
                        Initialization();
                    }
                    else {
                        alert(status.Message == undefined ? status : status.Message);
                    }
                }
            });
        }

        function Update(id, hasMoved, currentIndex) {
            var entity = new Object();
            if (!hasMoved) {
                entity = {
                    Id: id,
                    PersonsId: $("#ddlPersons").combobox("getValue"),
                    PlanWorkTime: $("#planWT_" + id).val(),
                    Status: $("#status_" + id).combobox("getValue"),
                    Describe: $("#describe_" + id).val(),
                    HasMoved: false
                };
            }
            else {
                entity = {
                    Id: id,
                    SortIndex: currentIndex,
                    HasMoved: true
                };
            }
            if ($("#divLoading").length == 0) {
                $(document.body).children(":last").after("<div id='divLoading' class='loading'><div class='image'></div><div class='text'>请稍后……</div></div>");
            }
            $("#divLoading").css("display", "block");
            $.post("../../JobLists/Update/", entity, function (status) {
                if (status != undefined) {
                    $("#divLoading").css("display", "none");
                    if (status.Succeed) {
                        Refresh();
                    }
                    else {
                        alert(status.Message == undefined ? status : status.Message);
                    }
                }
            });
        }

        function Delete(id) {
            var entity = {
                Id: id
            };

            if ($("#divLoading").length == 0) {
                $(document.body).children(":last").after("<div id='divLoading' class='loading'><div>请稍后……</div></div>");
            }
            $("#divLoading").css("display", "block");
            $.post("../../JobLists/Delete/", entity, function (status) {
                if (status != undefined) {
                    $("#divLoading").css("display", "none");
                    if (status.Succeed) {
                        Refresh();
                    }
                    else {
                        alert(status.Message == undefined ? status : status.Message);
                    }
                }
            });
        }

        function Refresh() {
            var personsId = $('#ddlPersons').combobox("getValue");
            AjaxListsLoad({ PersonsId: personsId });
        }

        function Query() {
            var personsId = $('#ddlPersons').combobox("getValue");
            var title = $('#txtQuery').val();
            if (title == "输入标题关键字查询") {
                title = "";
            }
            $("#finishedList").ajaxlists({
                url: "../../JobLists/GetFinishedEvents/",
                queryParam: { PersonsId: personsId, Title: title, Page: 1 },
                editable: false
            });
        }

        function Initialization() {
            $("#create_title").val("");
            $("#create_creator").val("");
            $("#create_planworktime").val("");
            $("#create_departments").combobox("clear");
            $("#create_describe").val("");
        }

    </script>
    <script type="text/javascript">
        $(function () {
            $('#ddlDepartment').combobox({
                url: "../../JobLists/GetAllDepartments/",
                valueField: "Id",
                textField: "Name",
                editable: false,
                onLoadSuccess: function () {
                    var data = $('#ddlDepartment').combobox("getData");
                    data.remove(data[0]);
                    $('#create_departments').combobox({ data: data, valueField: 'Id', textField: 'Name', editable: false });
                },
                onSelect: function (e, source) {
                    $('#ddlPersons').combobox("clear");
                    $('#ddlPersons').combobox("reload", '../../JobLists/GetPersons/?departmentId=' + e.Id);
                    Refresh();
                }
            });

            $('#ddlPersons').combobox({
                url: '../../JobLists/GetPersons/?departmentId=' + $('#ddlDepartment').combobox("getValue"),
                valueField: "Id",
                textField: "Name",
                onSelect: function (e, source) {
                    Refresh();
                }
            });
        });
    </script>
    <!--搜索的输入框输入提示-->
    <script type="text/javascript">
        $(document).ready(function () {
            if ($('#txtQuery').val() != "输入标题关键字查询") {
                $('#txtQuery').css({ color: "#000000" });
            }
            $('#txtQuery').focus(function () {
                if ($('#txtQuery').val() == "输入标题关键字查询") {
                    $('#txtQuery').val("");
                    $('#txtQuery').css({ color: "#000000" });
                }

            });
            $('#txtQuery').focusout(function () {
                if ($('#txtQuery').val() == "") {
                    $('#txtQuery').val("输入标题关键字查询");
                    $('#txtQuery').css({ color: "#ccc" });
                }

            });
        });
    </script>
</head>
<body>
    <div style="margin: 0 auto; width: 1024px;">
        <div id="top">
            <div class="layout top">
                <div class="logo">
                    <a href="#"></a>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
        <div class="layout">
            <div class="margin_top">
                <div style="width: 250px; float: left;">
                    <input type="button" value="返回预订页面" onclick="javascript:window.location.href='../../Home/Index/'" /></div>
                <div style="margin: 10px;">
                    部门：<input class="easyui-combobox" name="ddlDepartment" value="00000000-0000-0000-0000-000000000000"
                        id="ddlDepartment" style="width: 184px" panelheight="auto" />
                    人员：<input class="easyui-combobox" id="ddlPersons" style="width: 184px" panelheight="auto" />
                </div>
                <div style="width: 33%; margin-right: .5%; min-height: 550px; float: left; border: 3px solid #84C2CC;">
                    <div class="querybox">
                        <label style="margin-left: 8px;">
                            已完成任务查询：</label>
                        <input type="text" style="color: #ccc; margin-right: 15px;" id="txtQuery" value="输入标题关键字查询" />
                        <input type="button" value="搜 索" onclick="javascript:Query()" /></div>
                    <div class="column" id="finishedList" style="min-height: 480px; width: 100%; float: none;">
                    </div>
                    <div id='paginate' style="width: 255px;">
                    </div>
                </div>
                <div id="processingList" class="column" style="border: 3px solid #84C2CC;">
                </div>
                <div style="position: relative; left: 0; float: left; width: 30%; margin-right: .5%;
                    height: 400px; border: 3px solid #84C2CC;">
                    <dd style="text-align: center; font-weight: bold; font-size: 16px; margin-top: 10px;">
                        添加任务信息</dd>
                    <dl style="margin: 10px;">
                        <dt style="width: 100px;">
                            <label>
                                标题：</label></dt>
                        <dt>
                            <input type="text" value="" id="create_title" />
                        </dt>
                        <dt style="width: 100px;">
                            <label>
                                创建人：</label></dt>
                        <dt>
                            <input type="text" value="" id="create_creator" />
                        </dt>
                        <dt>
                            <label>
                                部门：</label>
                        </dt>
                        <dt>
                            <input class="easyui-combobox" name="department_enabled" id="create_departments"
                                style="width: 184px" panelheight="auto" />
                        </dt>
                        <dt style="width: 100px;">
                            <label>
                                计划工时：</label></dt>
                        <dt>
                            <input type="text" value="" id="create_planworktime" />
                        </dt>
                        <dt style="width: 100px;">
                            <label>
                                描述：</label></dt>
                        <dt>
                            <textarea style="width: 98%;" rows="3" cols="6" id="create_describe"></textarea>
                        </dt>
                        <dt>
                            <input type="button" value="添 加" onclick="javascript:Create()" style="left: 40%;
                                position: relative;" /></dt>
                    </dl>
                </div>
            </div>
            <div class="layout">
                <div class="foot">
                    <ul>
                        <li>(请使用IE7及以上版本获得最佳浏览效果)</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

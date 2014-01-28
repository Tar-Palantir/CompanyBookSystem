<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/DataMaster.Master"
    Inherits="System.Web.Mvc.ViewPage<ITS.CompanyBookSystem.DataAccess.Entity.BookRecordResult>" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="menubar">
        <div class="mnuBar">
            <ul>
                <li><a href="javascript:void(0)" onclick="window.location='../../BookRecords/Index/'"
                    title="返回"><span class="icon-back">返回</span></a></li>
                <li><a href="javascript:void(0)" onclick="save();" title="保存"><span class="icon-save">
                    保存</span></a></li>
            </ul>
        </div>
    </div>
    <form id="formContent" runat="server">
    <div>
        <table style="width: 100%; table-layout: fixed;">
            <tr>
                <td style="width: 60px;">
                    预订对象：
                </td>
                <td style="width: 200px;">
                    <label id="bookObject">
                        <%:Model.BookObjectName %></label>
                </td>
                <td style="width: 60px;">
                </td>
                <td>
                </td>
            </tr>
            <tr style="line-height: 30px;">
                <td>
                    预订人：
                </td>
                <td>
                    <input id="creator" type="text" value="<%:Model.Creator %>" class="easyui-validatebox"
                        validtype="length[2,20]" required="true" style="height: 20px;" />
                </td>
                <td>
                    联系电话：
                </td>
                <td>
                    <input type="text" id="tel" class="easyui-validatebox" validtype="length[3,20]" required="true"
                        style="height: 20px;" value="<%:Model.Tel %>" />
                </td>
            </tr>
            <tr>
                <td>
                    部门：
                </td>
                <td colspan="3">
                    <input class="easyui-combobox" name="ddlDepartment" url="../../Departments/GetAll/"
                        id="ddlDepartment" valuefield="Id" textfield="Name" value="<%:Model.DepartmentId %>"
                        style="width: 184px" panelheight="auto" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td colspan="3">
                    <label style="font-weight: bold;">
                        当开始时间和结束时间都是0点时，表示全天预订</label>
                </td>
            </tr>
            <tr>
                <td>
                    开始日期：
                </td>
                <td>
                    <input id="txtStartDate" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'yyyy-MM-dd',startDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                        class="Wdate" readonly="readonly" value="<%:Model.StartDate.ToString("yyyy-MM-dd") %>" />
                </td>
                <td>
                    结束日期：
                </td>
                <td>
                    <input id="txtEndDate" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                        class="Wdate" readonly="readonly" value="<%:Model.EndDate.ToString("yyyy-MM-dd") %>" />
                </td>
            </tr>
            <tr>
                <td>
                    开始时间：
                </td>
                <td>
                    <input id="txtStartTime" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'HH:mm',startDate:'%H-%m',quickSel:['9:00:00','%H-%m','%H-30']})"
                        class="Wdate" readonly="readonly" value="<%:Model.StartTime.ToString("HH:mm") %>" />
                </td>
                <td>
                    结束时间：
                </td>
                <td>
                    <input id="txtEndTime" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'HH:mm'})"
                        class="Wdate" readonly="readonly" value="<%:Model.EndTime.ToString("HH:mm") %>" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td colspan="3">
                    <div id="divUpdateAll" <%if(!Model.IsCircle){ %>style="display: none;"
                        <%} %>>
                        <input type="checkbox" id="updateAll" />
                        <label for="updateAll">
                            更新相关的全部记录</label></div>
                </td>
            </tr>
            <tr>
                <td>
                    描述：
                </td>
                <td colspan="3">
                    <textarea id="txtDescribe" style="width: 550px; height: 100px;" rows="4" cols="10"><%:Model.Describe %></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <pre><%:Model.RelevanceRecords %></pre>
                </td>
            </tr>
        </table>
        <input type="hidden" id="recordId" value="<%:Model.Id %>" />
        <input type="hidden" id="reocrdRelevanceId" value="<%:Model.RelevanceId %>" />
    </div>
    </form>
</asp:Content>
<asp:Content ID="resourceContent" ContentPlaceHolderID="ResourceContent" runat="server">
    <script src="../../Scripts/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            //获取封装好的事件
            function GetEventData() {
                var entity = {
                    Id: $("#recordId").val(),
                    BookObjectId: $("#ddlObject").combobox("getValue"),
                    DepartmentId: $("#ddlDepartment").combobox("getValue"),
                    StartDate: $("#txtStartDate").val(),
                    StartTime: "1970-01-01 " + $("#txtStartTime").val(),
                    EndDate: $("#txtEndDate").val(),
                    EndTime: "1970-01-01 " + $("#txtEndTime").val(),
                    Creator: $('#creator').val(),
                    Tel: $('#tel').val(),
                    Describe: $("#txtDescribe").val()
                };

                if (entity.StartDate == entity.EndDate && entity.StartTime >= entity.EndTime) {
                    if (entity.StartTime != "1970-01-01 00:00") {
                        alert("预订开始时间不能大于或等于结束时间 /r/n 预订全天除外");
                        return null;
                    }
                }
                if (document.getElementById("updateAll").checked) {
                    entity.RelevanceId = $("#reocrdRelevanceId").val();
                }
                return entity;

            }
            //保存预订
            function Save() {
                //表单验证
                if (!$("#formContent").form("validate")) {
                    return;
                }
                var entity = GetEventData();
                if (entity != null) {
                    $.post("../../BookRecords/Update/",
                    entity,
                    function (status) {
                        if (status != undefined) {
                            $.messager.alert("操作提示", status.Message == undefined ? status : status.Message);
                            if (status.Succeed) {
                                window.location = "../../BookRecords/Index/";
                            }
                        }
                    }
                );
                }

            }
        })
    </script>
</asp:Content>
<asp:Content ID="bottomScript" ContentPlaceHolderID="BottomScript" runat="server">
</asp:Content>

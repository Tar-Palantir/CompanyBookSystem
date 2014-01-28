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
            </ul>
        </div>
    </div>
    <div class="content" style="top: 27px;">
        <dd>
            预订信息</dd>
        <dl>
            <dt class="entitytype" style="white-space: normal; height: auto">
                <label style="width: auto;">
                    预订对象:</label>
                <label style="white-space: normal;">
                    <%:Model.BookObjectName%></label>
            </dt>
            <dt class="entitytype" style="white-space: normal; height: auto">
                <label style="width: auto;">
                    预订人:</label>
                <label style="white-space: normal;">
                    <%:Model.Creator%></label>
            </dt>
            <dt class="entitytype" style="white-space: normal; height: auto">
                <label style="width: auto;">
                    联系电话:</label>
                <label style="white-space: normal;">
                    <%:Model.Tel%></label>
            </dt>
            <dt class="entitytype" style="white-space: normal; height: auto">
                <label style="width: auto;">
                    部门:</label>
                <label style="white-space: normal;">
                    <%:Model.DepartmentName%></label>
            </dt>
            <dt class="entitytype" style="white-space: normal; height: auto">
                <label style="white-space: normal; width: 100%;">
                    <%:Model.UsingTime%></label>
            </dt>
        </dl>
        <dd>
            描述</dd>
        <dl>
            <dt class="entitytype" style="white-space: normal; height: auto">
                <label style="white-space: normal; width: 100%;">
                    <%:Model.Describe%></label>
            </dt>
        </dl>
        <dd>
            其他</dd>
        <dl>
            <dt class="entitytype" style="word-spacing: break-word; height: auto">
                <pre style="width: 100%"><%:Model.RelevanceRecords%></pre>
            </dt>
        </dl>
    </div>
</asp:Content>
<asp:Content ID="resourceContent" ContentPlaceHolderID="ResourceContent" runat="server">
</asp:Content>
<asp:Content ID="bottomScript" ContentPlaceHolderID="BottomScript" runat="server">
</asp:Content>

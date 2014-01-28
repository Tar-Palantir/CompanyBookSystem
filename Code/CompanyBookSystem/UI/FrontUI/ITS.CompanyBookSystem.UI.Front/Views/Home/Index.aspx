<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../../App_Themes/cupertino/theme.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/fullcalendar.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/fullcalendar.print.css" rel="stylesheet" type="text/css"
        media="print" />
    <link href="../../Style/_Window.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/index.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/easyui-combobox.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/easyui-validatebox.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/prettyCheckboxes.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/fancyBox/source/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../../Scripts/fullcalendar.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../Scripts/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-ui-1.8.23.custom.min.js" type="text/javascript"></script>
    <script src="../../Scripts/_Window.js" type="text/javascript"></script>
    <script src="../../Scripts/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.collapser.min.js" type="text/javascript"></script>
    <script src="../../Scripts/prettyCheckboxes.js" type="text/javascript"></script>
    <script src="../../Scripts/fancyBox/source/jquery.fancybox.js" type="text/javascript"></script>
    <script src="../../Scripts/fancyBox/lib/jquery.mousewheel-3.0.6.pack.js" type="text/javascript"></script>
    <title>天府软件园有限公司预订系统</title>
    <!--窗口设置-->
    <script type="text/javascript">
        $(function () {
            _window.zIndex = 10;

            $("input[type=checkbox]").prettyCheckboxes();
            $("input[type=radio]").prettyCheckboxes({ display: "inline" });

            $("#dayCircle").change(function () { $(".ddlCircle").slideUp("fast"); });
            $("#weekCircle").change(function () { $(".ddlCircle").slideUp("fast"); $("#divWeek").slideDown("linear"); });
            $("#monthCircle").change(function () { $(".ddlCircle").slideUp("fast"); $("#divMonth").slideDown("linear"); });
            $("#isCircle").change(function () {
                if (document.getElementById("isCircle").checked) {
                    $(".divCircle").fadeIn("slow");
                }
                else {
                    $("#dayCircle").prev("label").click();
                    $(".ddlCircle").slideUp("fast");
                    $(".divCircle").fadeOut("fast");
                }
            });

            var tempStartTime = "";
            var tempEndTime = "";
            $("#isAllDay").change(function () {
                if (document.getElementById("isAllDay").checked) {
                    tempStartTime = $("#txtStartTime").val();
                    tempEndTime = $("#txtEndTime").val();
                    $("#txtStartTime").val("00:00");
                    $("#txtEndTime").val("00:00");
                    $("#txtStartTime").attr("disabled", "disabled");
                    $("#txtEndTime").attr("disabled", "disabled");
                }
                else {
                    $("#txtStartTime").val(tempStartTime);
                    $("#txtEndTime").val(tempEndTime);
                    $("#txtStartTime").removeAttr("disabled");
                    $("#txtEndTime").removeAttr("disabled");
                }
            })

            $('.mode').collapser({
                target: 'next',
                effect: 'slide',
                changeText: 0
            });
        })
    </script>
    <!--fancyBox设置-->
    <script type="text/javascript">
        $(document).ready(function () {
            $(".fancybox").fancybox();
        });
    </script>
    <!--fullCalendar设置-->
    <script type="text/javascript">
        $(function () {
            var slotminute = 30;
            var allDayTime = false;
            InitializationCalendar(slotminute);
        })
        function InitializationCalendar(slotminute, allDayTime) {
            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            var op1 = { defaultView: 'agendaWeek',
                theme: true,
                slotMinutes: slotminute,
                firstHour: allDayTime ? 8 : 9,
                minTime: allDayTime ? 0 : 9,
                maxTime: allDayTime ? 24 : 18,
                height: "600",
                header: {
                    left: 'prev,next today',
                    center: 'bookType',
                    right: ''
                },
                buttonText: {
                    prev: '向前',
                    next: '向后',
                    prevYear: '去年',
                    nextYear: '明年',
                    today: '今天',
                    month: '月',
                    week: '周',
                    day: '日'
                },
                titleFormat: {
                    week: "yyyy年MM月dd日"
                },
                columnFormat: {
                    week: 'MM月dd日/dddd'
                },
                currentTimezone: 'Asia/Beijing',
                allDayText: '全天',
                dayNames: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
                dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
                monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                timeFormat: 'HH(:mm)',
                axisFormat: 'HH:mm',
                selectable: true,
                selectHelper: true,
                select: function (start, end, allDay) {
                    if (IsBookable()) {
                        if (start >= new Date(y, m, d)) {
                            var event = {
                                start: start,
                                end: end,
                                allDay: allDay,
                                recordObjectId: $("#ddlObject").combobox("getValue")
                            };
                            if (allDay) {
                                start.setHours(0, 0, 0, 0);
                                end.setHours(23, 59, 59, 0);
                            }

                            var isOverlap = TimeOverlapping(event, function () { calendar.fullCalendar("unselect"); });

                            if (!isOverlap) {
                                var startDate = $.fullCalendar.formatDate(start, "yyyy-MM-dd");
                                var endDate = $.fullCalendar.formatDate(end, "yyyy-MM-dd");
                                var startTime = $.fullCalendar.formatDate(start, "HH:mm");
                                var endTime = $.fullCalendar.formatDate(end, "HH:mm");

                                $('#txtStartDate').val(startDate);
                                $('#txtEndDate').val(endDate);
                                $('#txtStartTime').val(startTime);
                                $('#txtEndTime').val(endTime);
                                if (allDay) {
                                    $('#txtEndTime').val("00:00");
                                    CheckChange("isAllDay", true);
                                }

                                OpenBookWindow();
                            }
                        }
                    }
                    else {
                        alert("请先选择需要预订的对象！");
                        calendar.fullCalendar("unselect");
                    }
                },
                eventClick: function (calEvent, jsEvent, view) {
                    if (calEvent.isEditable) {
                        UpdateInitialization(calEvent.id);
                    }
                    else {
                        var id = calEvent.id;
                        ShowDetail(id);
                    }
                },
                editable: true,
                events: {
                    url: '/Home/RecordsAdvQuery/',
                    type: 'Get',
                    data: {
                        BookObjectId: function () { if ($("#ddlObject").val() != undefined) { return $("#ddlObject").combobox("getValue"); } else { return "00000000-0000-0000-0000-000000000000"; } },
                        TypeId: function () { if ($("#ddlType").val() != undefined) { return $("#ddlType").combobox("getValue"); } else { return "00000000-0000-0000-0000-000000000000"; } },
                        StartDate: function () { var view = $("#calendar").fullCalendar('getView'); return $.fullCalendar.formatDate(view.start, "yyyy-MM-dd"); },
                        EndDate: function () { var view = $("#calendar").fullCalendar('getView'); return $.fullCalendar.formatDate(view.end, "yyyy-MM-dd"); }
                    },
                    error: function () {
                        alert('数据读取错误!');
                    },
                    cache: false
                },
                disableDragging: true,
                disableResizing: true,
                eventResizeStart: function (event, jsEvent, ui, view) {
                    if (event.isEditable) {
                    }
                    else {
                        $("#calendar").fullCalendar('refetchEvents');
                    }
                },
                eventResize: function (event, dayDelta, minuteDelta, revertFunc) {
                    TimeOverlapping(event, revertFunc);
                }
            };

            var calendar = $("#calendar").fullCalendar(op1);

            $('.fc-button-prev').click(function () { Refresh(); });
            $('.fc-button-next').click(function () { Refresh(); });

            //是否可以预订
            function IsBookable() {
                var objectId = $("#ddlObject").combobox('getValue');
                if (objectId == "00000000-0000-0000-0000-000000000000")
                { return false; }
                else { return true; }
            }

            //时间重叠判断
            function TimeOverlapping(event, func) {
                var isTimeOverlap = false;
                $.each(calendar.fullCalendar('clientEvents'), function () {
                    if (event != this && event.recordObjectId == this.recordObjectId) {
                        var newEnd = this.end;
                        if (this.allDay) {
                            if (this.end == null) {
                                newEnd = new Date(this.start.getTime());
                                newEnd.setDate(this.start.getDate() + 1);
                            }
                            else {
                                newEnd = new Date(this.end.getTime());
                                newEnd.setDate(this.end.getDate() + 1);
                            }
                        }
                        if ((this.start < event.end && this.start >= event.start)
                        || (newEnd > event.start && this.start <= event.start)) {
                            alert("对不起，该时间段内已有其他预订");
                            isTimeOverlap = true;
                            func();
                            return false;
                        }
                    }
                });
                return isTimeOverlap;
            }

            //获取封装好的事件
            function GetEventData() {
                var entity = {
                    Id: $("#recordId").val(),
                    BookObjectId: $("#ddlObject").combobox("getValue"),
                    DepartmentId: $("#ddlDepartment").combobox("getValue"),
                    StartDate: "",
                    StartTime: "",
                    EndDate: "",
                    EndTime: "",
                    CircleMode: 0,
                    Creator: $('#creator').val(),
                    Tel: $('#tel').val(),
                    Describe: $("#txtDescribe").val()
                };

                var isAllDay = document.getElementById("isAllDay").checked;
                var isCircle = document.getElementById("isCircle").checked;

                entity.StartDate = $("#txtStartDate").val();
                entity.StartTime = "1970-01-01 " + $("#txtStartTime").val();
                entity.EndDate = $("#txtEndDate").val();
                entity.EndTime = "1970-01-01 " + $("#txtEndTime").val();

                if (!isAllDay) {
                    if (entity.StartDate == entity.EndDate && entity.StartTime >= entity.EndTime) {
                        alert("预订开始时间不能大于或等于结束时间");
                        return null;
                    }
                }

                if (isCircle) {
                    var mode = $("input[name='circle']:checked").val();
                    switch (mode) {
                        case "1": entity.CircleMode = 1;
                            break;
                        case "2": entity.CircleMode = 2;
                            entity.CircleDayOrWeek = $("#weekSelect option:selected").val();
                            break;
                        case "3": entity.CircleMode = 3;
                            entity.CircleDayOrWeek = $("#monthSelect option:selected").val();
                            break;
                        default: return null;
                    }
                }
                else {
                    var start = $('#txtStartDate').val() + " " + $("#txtStartTime").val();
                    var end = $('#txtEndDate').val() + " " + $("#txtEndTime").val();

                    var event = {
                        title: "",
                        start: start,
                        end: end,
                        allDay: isAllDay
                    };
                    var isOverlap = TimeOverlapping(event, function () { });
                    if (isOverlap) {
                        return null;
                    }
                }


                if (document.getElementById("updateAll").checked) {
                    entity.RelevanceId = $("#reocrdRelevanceId").val();
                }

                return entity;

            }

            //初始化
            function Initializaion() {
                $('#bookObject').html("");
                $('#creator').val("");
                $('#tel').val("");
                $('#txtDescribe').val("");
                $('#relevanceRecords').html("");
                $('#ddlDepartment').combobox("clear");

                $('#txtStartDate').val("");
                $('#txtEndDate').val("");
                $('#txtStartTime').val("");
                $('#txtEndTime').val("");

                $('#recordId').val("");
                $('#recordRelevanceId').val("");

                $("#h4Relevance").css("display", "none");
                $('#deleteRecord').css("visibility", "hidden");
                $("#divUpdateAll").css("display", "none");
                $("#divIsCircle").css("display", "block");
                $("#bookwindow input").removeAttr("disabled");
                $('#ddlDepartment').combobox("enable");

                $("#monthSelect option[value='1']").attr("selected", true);
                $("#weekSelect option[value='1']").attr("selected", true);
                $("#dayCircle").prev("label").click();

                CheckChange("isAllDay", false);
                CheckChange("isCircle", false);

                $("div[name='Circle']:not('#divIsCircle')").css("display", "none");

                calendar.fullCalendar('unselect');
            }

            //改变CheckBox至指定状态，不填状态的将自动转换
            function CheckChange(id, checked) {
                if (checked == undefined) {
                    checked = ~document.getElementById(id).checked;
                }
                if (!checked) {
                    document.getElementById(id).checked = false;
                    $("#" + id).prev("label").removeClass("checked");
                } else {
                    document.getElementById(id).checked = true;
                    $("#" + id).prev("label").addClass("checked");
                }
                $("#" + id).change();
            }

            //保存预订
            function Save() {//表单验证
                var entity = GetEventData();
                if (entity != null) {
                    $.post("../../Home/RecordsCreateOrUpdate/",
                    entity,
                    function (status) {
                        if (status != undefined) {
                            alert(status.Message == undefined ? status : status.Message);
                            if (status.Succeed) {
                                calendar.fullCalendar('refetchEvents');
                                Initializaion();
                            }
                            else {
                                var id = $("#recordId").val();
                                if (id != undefined && id != "") {
                                    OpenUpdateWindow();
                                }
                                else { OpenBookWindow(); }
                            }
                        }
                    }
                );
                }

            }

            //显示预订记录的详细信息
            function ShowDetail(gid) {
                $.post("../../Home/GetDetailById/?id=" + gid,
                function (detail) {
                    if (detail != undefined) {
                        $("#lblDetailRecordObject").html(detail.BookObjectName);
                        $("#lblDetailDepartment").html(detail.DepartmentName);
                        $("#lblDetailDescribe").html(detail.Describe);
                        $("#lblDetailTime").html(detail.UsingTime);
                        $("#lblDetailCreator").html(detail.Creator);
                        $("#lblDetailTel").html(detail.Tel);
                        var relevanceRecords = detail.RelevanceRecords;
                        var height = 180;
                        if (relevanceRecords != undefined && relevanceRecords != "") {
                            $("#dtRelevance").css("display", "block");
                            $("#detailRelevanceRecords").html(relevanceRecords);
                            height = 220;
                        }
                        else {
                            $("#dtRelevance").css("display", "none");
                            $("#detailRelevanceRecords").html("");
                        }

                        var myDetailWindow = _window.Open('[id]recordDetailWindow', '预订信息',
                     'isModal=yes,button=OK,class=NOKIA,width=500,height=' + height);
                        myDetailWindow.OnOK = function () { myDetailWindow.Close(); };
                    }
                    else {
                        alert("错误，请刷新后重试");
                    }
                });
            }

            //Json日期转换方法
            function ConvertJSONDateToJSDateObject(jsondate) {
                var date = new Date(parseInt(jsondate.replace("/Date(", "").replace(")/", ""), 10));
                return date;
            }

            //更新窗口初始化
            function UpdateInitialization(gid) {
                $.post("../../Home/GetDetailById/?id=" + gid,
                function (record) {
                    if (record != undefined) {
                        $('#recordId').val(record.Id);

                        $('#bookObject').html(record.BookObjectName);

                        $('#creator').val(record.Creator);
                        $('#creator').attr("disabled", "disabled");

                        $('#tel').val(record.Tel);

                        $('#txtDescribe').val(record.Describe);

                        $('#ddlDepartment').combobox("setValue", record.DepartmentId);
                        $('#ddlDepartment').combobox("disable");

                        $('#deleteRecord').css("visibility", "visible");

                        var startDate = $.fullCalendar.formatDate(ConvertJSONDateToJSDateObject(record.StartDate), "yyyy-MM-dd");
                        var endDate = $.fullCalendar.formatDate(ConvertJSONDateToJSDateObject(record.EndDate), "yyyy-MM-dd");
                        var startTime = $.fullCalendar.formatDate(ConvertJSONDateToJSDateObject(record.StartTime), "HH:mm");
                        var endTime = $.fullCalendar.formatDate(ConvertJSONDateToJSDateObject(record.EndTime), "HH:mm");

                        $("#txtStartDate").val(startDate);
                        $("#txtEndDate").val(endDate);
                        $("#txtStartTime").val(startTime);
                        $("#txtEndTime").val(endTime);

                        $("div[name='Circle']").css("display", "none");

                        if (record.IsCircle) {
                            $("#h4Relevance").css("display", "block");
                            $("#relevanceRecords").html(record.RelevanceRecords);
                            $("#reocrdRelevanceId").val(record.RelevanceId);

                            $("#txtStartDate").attr("disabled", "disabled");
                            $("#txtEndDate").attr("disabled", "disabled");
                            $("#divUpdateAll").css("display", "block");
                            $(".WindowsPanel:not(#mode_1) input:not(#divUpdateAll)").attr("disabled", "disabled");
                        }
                        if (record.IsAllDay) {
                            CheckChange("isAllDay", true);
                        }
                        OpenUpdateWindow();
                    }
                    else {
                        alert("错误，请刷新后重试");
                    }
                });
            }

            //删除预订记录
            function Delete() {
                var id = $("#recordId").val();
                var result = confirm("确定删除？");
                if (result) {
                    $.post("../../Home/RecordsDelete/?id=" + id,
                    function (status) {
                        if (status != undefined) {
                            alert(status.Message == undefined ? status : status.Message);
                            if (status.Succeed) {
                                calendar.fullCalendar('removeEvents', id);
                                Initializaion();
                            }
                            else {
                                OpenUpdateWindow();
                            }
                        }
                    }
                );
                }
            }

            //放弃预订
            function Cancel() {
                Initializaion();
            }

            //数据刷新
            function Refresh() {
                $("#calendar").fullCalendar('refetchEvents');

                if (IsBookable()) {
                    $("#open").removeAttr("disabled");
                    $("#open").removeClass("ui-state-disabled");
                }
                else {
                    $("#open").attr("disabled", "disabled");
                    $("#open").addClass("ui-state-disabled");
                }
            }

            //打开预订窗口
            function OpenUpdateWindow() {
                var myWindow = _window.Open('[id]bookwindow', '修改预订信息',
                     'isModal=yes,button=OK|Cancel,class=NOKIA,width=600,height=400');
                myWindow.OnOK = function () {
                    if (!$("#formContent").form("validate")) {
                        return;
                    } else {
                        Save();
                        myWindow.Close();
                    }
                };
                myWindow.OnCANCEL = function () { Cancel(); myWindow.Close(); };
                $("#deleteRecord").unbind("click");
                $("#deleteRecord").click(function () { Delete(); myWindow.Close(); });
            }

            //打开预订窗口
            function OpenBookWindow() {

                $('#bookObject').html($("#ddlObject").combobox("getText"));

                var myWindow = _window.Open('[id]bookwindow', '请输入预订信息',
                     'isModal=yes,button=OK|Cancel,class=NOKIA,width=600,height=400');
                myWindow.OnOK = function () {
                    if (!$("#formContent").form("validate")) {
                        return;
                    } else {
                        Save();
                        myWindow.Close();
                    }
                };
                myWindow.OnCANCEL = function () { Cancel(); myWindow.Close(); };
            }


            //注入预订类型和对象的选择菜单至fullcalendar的头部中间
            $("#calendar .fc-header-center")
                .html('<div><label class="title">预订对象类型:</label><input id="ddlType" value="00000000-0000-0000-0000-000000000000" style="width: 128px" panelheight="auto" /></div>' +
                '<div><label class="title">预订对象:</label><input id="ddlObject" value="00000000-0000-0000-0000-000000000000" style="width: 128px" panelheight="auto"/></div>' +
                '<div><input class="fc-header-btn fc-button ui-state-default fc-button-content ui-corner-all" type="button" id="open" value="打开预订窗口"/></div><br />' +
                '<div class="font-red"><label class="title">对象简介：</label><label id="objectDescribe"></label>&nbsp;<label class="title">位置：</label><label id="objectLocation"></label></div>' +
                '<div><input class="fc-header-btn fc-button ui-state-default fc-button-content ui-corner-all" type="button" id="map" value="查看地图"/></div>');

            //刷新预订对象的简介
            function RefreshObjectDescribe(id) {
                $.post("../../Home/GetBookObjectById/?id=" + id,
                        function (bookObject) {
                            $("#objectDescribe").html(bookObject.Describe);
                            $("#objectLocation").html(bookObject.Location);
                        });
            }

            $('#ddlType').combobox({
                url: "../../Home/GetAllObjectType/",
                valueField: "Id",
                textField: "Name",
                onSelect: function (e, source) {
                    $('#ddlObject').combobox("setValue", "00000000-0000-0000-0000-000000000000");
                    $('#ddlObject').combobox("reload", '../../Home/GetBookObjects/?typeId=' + e.Id);
                }
            });

            $('#ddlObject').combobox({
                url: '../../Home/GetBookObjects/?typeId=' + $('#ddlType').combobox("getValue"),
                valueField: "Id",
                textField: "Name",
                onLoadSuccess: function () { Refresh(); RefreshObjectDescribe(); },
                onSelect: function (e, source) {
                    Refresh();
                    RefreshObjectDescribe(e.Id);
                }
            });

            $("#open").click(function () { OpenBookWindow(); });
            $("#deleteRecord").click(function () { Delete(); });
            $("#map").click(function () { $("#mapLink").click(); });

            //设置下拉列表为只读
            $("#ddlType").combobox('textbox').attr("readonly", true);
            $("#ddlObject").combobox('textbox').attr("readonly", true);
            $("#ddlDepartment").combobox('textbox').attr("readonly", true);


            var showTimeBtnValue = allDayTime ? "只显示工作时间" : "显示全天时间";
            //注入预订类型和对象的选择菜单至fullcalendar的头部中间
            $("#calendar .fc-header-right")
                .html('<div><input class="fc-button ui-state-default fc-button-content ui-corner-all fc-header-btn" type="button" id="btnSlotMinute" value="' + slotminute + '分钟/格"/></div>' +
                '<div><input class="fc-button ui-state-default fc-button-content ui-corner-all fc-header-btn" type="button" id="btnShowTimeChange" value="' + showTimeBtnValue + '"/></div>' +
                '<div><input class="fc-button ui-state-default fc-button-content ui-corner-all fc-header-btn" type="button" value="进入预约页面" onclick="javascript:window.location.href=\'../../JobLists/Index/\'"/></div>');
            $("#btnSlotMinute").click(function () {
                slotminute = slotminute + 15;
                if (slotminute > 60) {
                    slotminute = 15;
                }
                $("#calendar").fullCalendar("destroy");
                InitializationCalendar(slotminute);
            });
            $("#btnShowTimeChange").click(function () {
                allDayTime = ~allDayTime;
                $("#calendar").fullCalendar("destroy");
                InitializationCalendar(slotminute, allDayTime);
            });
        }
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
                <div id="calendar">
                </div>
            </div>
            <div class="clear">
            </div>
            <div style="display: none;">
                <div id="bookwindow">
                    <form id="formContent" runat="server">
                    <div>
                        <h4 class="mode">
                            基本信息</h4>
                        <div>
                            <table style="width: 100%; table-layout: fixed;">
                                <tr>
                                    <td style="width: 60px;">
                                        预订对象：
                                    </td>
                                    <td style="width: 200px;">
                                        <label id="bookObject">
                                        </label>
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
                                        <input id="creator" type="text" value="" class="easyui-validatebox" validtype="length[2,20]"
                                            required="true" style="height: 20px;" maxlength="20" />
                                    </td>
                                    <td>
                                        联系电话：
                                    </td>
                                    <td>
                                        <input type="text" id="tel" class="easyui-validatebox" maxlength="20" style="height: 20px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        部门：
                                    </td>
                                    <td colspan="2">
                                        <input class="easyui-combobox" name="ddlDepartment" url="../../Home/GetAllDepartments/"
                                            id="ddlDepartment" valuefield="Id" textfield="Name" style="width: 184px" panelheight="auto"
                                            required="true" />
                                    </td>
                                    <td>
                                        <input type="submit" id="deleteRecord" style="visibility: hidden" value="删除该预订记录" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <h4 class="mode">
                            预订时间</h4>
                        <div class="WindowsPanel">
                            <table style="table-layout: fixed; width: 100%">
                                <tr>
                                    <td style="width: 200px;">
                                        日期：
                                        <input id="txtStartDate" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'yyyy-MM-dd',startDate:'%y-%M-%d',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                                            class="Wdate" />
                                    </td>
                                    <td style="width: 40px;">
                                        至
                                    </td>
                                    <td>
                                        <input id="txtEndDate" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                                            class="Wdate" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 200px;">
                                        时间：
                                        <input id="txtStartTime" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'HH:mm',startDate:'%H-%m',maxDate:'#F{$dp.$D(\'txtEndTime\')}',quickSel:['9:00:00','%H-%m','%H-30']})"
                                            class="Wdate" />
                                    </td>
                                    <td style="width: 40px;">
                                        到
                                    </td>
                                    <td>
                                        <input id="txtEndTime" type="text" onfocus="WdatePicker({skin:'blue',dateFmt:'HH:mm',minDate:'#F{$dp.$D(\'txtStartTime\')}'})"
                                            class="Wdate" />
                                    </td>
                                    <td>
                                        <label for="isAllDay">
                                            全天</label>
                                        <input type="checkbox" id="isAllDay" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="divUpdateAll" style="display: none;">
                                            <label for="updateAll">
                                                更新相关的全部记录</label>
                                            <input type="checkbox" id="updateAll" /></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="divIsCircle" name="Circle">
                                            <label for="isCircle">
                                                重复周期</label>
                                            <input type="checkbox" id="isCircle" />
                                        </div>
                                        <div class="divCircle" name="Circle">
                                            <label for="dayCircle" tabindex="1">
                                                日循环</label>
                                            <input type="radio" name="circle" checked="checked" id="dayCircle" value="1" /><label
                                                for="weekCircle" tabindex="2">周循环</label>
                                            <input type="radio" name="circle" id="weekCircle" value="2" /><label for="monthCircle"
                                                tabindex="3">月循环</label>
                                            <input type="radio" name="circle" id="monthCircle" value="3" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div class="ddlCircle" id="divWeek" name="Circle">
                                选择每周的
                                <select id="weekSelect">
                                    <option value="1">周一</option>
                                    <option value="2">周二</option>
                                    <option value="3">周三</option>
                                    <option value="4">周四</option>
                                    <option value="5">周五</option>
                                    <option value="6">周六</option>
                                    <option value="0">周日</option>
                                </select>
                            </div>
                            <div class="ddlCircle" id="divMonth" name="Circle">
                                选择每月的第
                                <select id="monthSelect">
                                    <%for (int i = 1; i <= 31; i++)
                                      {
                                    %><option value="<%=i %>">
                                        <%=i %></option>
                                    <%
                                      } %>
                                </select>天
                            </div>
                        </div>
                        <h4 class="mode">
                            描述及补充信息</h4>
                        <div style="margin-bottom: 10px;">
                            <textarea id="txtDescribe" style="width: 99.5%; height: 94px;" rows="4" cols="10"></textarea>
                        </div>
                        <h4 class="mode" id="h4Relevance">
                            相关预订时间</h4>
                        <div>
                            <pre id="relevanceRecords" style="word-wrap: break-word; width: 250px;"></pre>
                        </div>
                        <input type="hidden" id="recordId" />
                        <input type="hidden" id="reocrdRelevanceId" />
                    </div>
                    </form>
                </div>
            </div>
            <div style="display: none;">
                <div id="recordDetailWindow">
                    <div>
                        <dl class="detail">
                            <dt>
                                <label>
                                    预订对象：</label><label id="lblDetailRecordObject"></label>
                            </dt>
                            <dt style="float: left; width: 50%;">
                                <label>
                                    预订人：</label><label id="lblDetailCreator"></label>
                            </dt>
                            <dt style="float: left; width: 50%;">
                                <label>
                                    联系电话：</label><label id="lblDetailTel"></label>
                            </dt>
                            <dt>
                                <label>
                                    部门：</label><label id="lblDetailDepartment"></label>
                            </dt>
                            <dt>
                                <label id="lblDetailTime">
                                </label>
                            </dt>
                            <dt>
                                <label>
                                    描述：</label><label id="lblDetailDescribe"></label>
                            </dt>
                            <dt id="dtRelevance">
                                <label>
                                    相关联时间：</label>
                                <pre id="detailRelevanceRecords" style="word-wrap: break-word; width: 285px;"></pre>
                            </dt>
                        </dl>
                    </div>
                </div>
            </div>
            <div>
                <a id="mapLink" class="fancybox" rel="gallery1" title="二楼示意图" href="../../Images/二楼示意图.png">
                </a><a class="fancybox" rel="gallery1" title="三楼示意图" href="../../Images/三楼示意图.png">
                </a>
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

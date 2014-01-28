var currentPage = 1;
var pagesize = 15;

//$.fn.ajaxlists = function (url, queryParam, editable) {
$.fn.ajaxlists = function (option) {
    if (typeof (option) == "string") {
        var method = eval(option);
        if ($.isFunction(method)) {
            return method.call();
        }
    }
    if ($("#divLoading").length == 0) {
        $(document.body).children(":last").after("<div id='divLoading' class='loading'><div class='background'><div class='image'></div><div class='text'>请稍后……</div></div></div>");
    }
    $("#divLoading").css("display", "block");
    var lists = $(this);

    if (!option.editable) {
        currentPage = option.queryParam.Page == undefined ? 1 : option.queryParam.Page;

        option.queryParam.PageSize = pagesize;
        option.queryParam.Page = currentPage
    }
    
    $.ajax({
        type: "POST",
        url: option.url,
        data: option.queryParam,
        success: function (data) {
            lists.html("");
            var content = "";
            if (option.editable) {
                if (data != undefined) {
                    $.each(data, function () {
                        content += "<div class='dragbox' id='" + this.Id + "'>";
                        content += "<h2 class='dragbox-title' style='background-color:" + GetColor(this.Status) + ";'>" + this.Title + "<span class='tips'>" + this.StatusName + "</span><span class='tips'>点击查看</span></h2>";
                        content += "<div class='dragbox-content' style='display:none;'><table class='detail'><col /><col /><col /><col />";
                        content += "<tr><td class='name'><label>标题：</label></td><td colspan='3'><label id='title_" + this.Id + "'>" + this.Title + "</label></td></tr>";
                        content += "<tr><td class='name'><label>创建人：</label></td><td><label id='creator_" + this.Id + "'>" + this.Creator + "</label></td></tr>";
                        content += "<tr><td class='name'><label>部门：</label></td><td><label id='department_" + this.Id + "'>" + this.DepartmentName + "</label></td></tr>";
                        content += "<tr><td class='name'><label>创建时间：</label></td><td colspan='3'><label id='datecreated_" + this.Id + "'>" + fomatDate(this.DateCreated) + "</label></td></tr>";
                        content += "<tr><td class='name'><label>计划工时：</label></td><td colspan='3'><input id='planWT_" + this.Id + "' type='text' value='" + this.PlanWorkTime + "' disabled='true'/></td></tr>";
                        content += "<tr><td class='name'><label>状态：</label></td><td colspan='3'><label id='status_" + this.Id + "'>" + this.StatusName + "</label></td></tr>";
                        content += "<tr><td class='name'><label>描述：</label></td><td colspan='3'><textarea id='describe_" + this.Id + "' style='width:210px;height:65px;' disabled='true' cols='6' rows='3'>" + this.Describe + "</textarea></td></tr>";
                        content += "</table><tr><td colspan='4'><input type='button' id='save_" + this.Id + "' value='保 存' style='left: 20%; position: relative; width: 50px;display:none;' onclick='javascript:Update(\"" + this.Id + "\",false)'/>";
                        content += "<input id='edit_" + this.Id + "' type='button' style='left: 20%; position: relative; width: 50px;' value='编 辑' onclick='javascript:Edit(\"" + this.Id + "\")'/>";
                        content += "<input type='button' style='left: 40%; position: relative; width: 50px;' value='删 除' onclick='javascript:Delete(\"" + this.Id + "\")'/></td></tr></div></div>";
                    });
                }
            }
            else {
                if (data.rows != undefined) {
                    $.each(data.rows, function () {
                        content += "<div class='dragbox' id='" + this.Id + "'>";
                        content += "<h2 class='dragbox-title' style='background-color:" + GetColor(this.Status) + ";'>" + this.Title + "<span class='tips'>" + this.StatusName + "</span><span class='tips'>点击查看</span></h2>";
                        content += "<div class='dragbox-content' style='display:none;'><table class='detail'><col/><col/><col /><col />";
                        content += "<tr><td class='name'><label>标题：</label></td><td colspan='3'><label id='title_finished_" + this.Id + "'>" + this.Title + "</label></td></tr>";
                        content += "<tr><td class='name'><label>创建人：</label></td><td><label id='creator_finished_" + this.Id + "'>" + this.Creator + "</label></td></tr>";
                        content += "<tr><td class='name'><label>部门：</label></td><td><label id='department_finished_" + this.Id + "'>" + this.DepartmentName + "</label></td></tr>";
                        content += "<tr><td class='name'><label>创建时间：</label></td><td colspan='3'><label id='datecreated_finished_" + this.Id + "'>" + fomatDate(this.DateCreated) + "</label></td></tr>";
                        content += "<tr><td class='name'><label>计划工时：</label></td><td colspan='3'><label id='planWT_finished_" + this.Id + "'>" + this.PlanWorkTime + "</label></td></tr>";
                        content += "<tr><td class='name'><label>状态：</label></td><td colspan='3'><label id='status_finished_" + this.Id + "'>" + this.StatusName + "</label></td></tr>";
                        content += "<tr><td class='name'><label>描述：</label></td><td colspan='3'><label id='describe_finished_" + this.Id + "'>" + this.Describe + "</label></td></tr>";
                        content += "</table></div></div>";
                    });
                }
            }

            lists.html(content);
            $("#divLoading").css("display", "none");
            lists.children('.dragbox').each(function () {
                $(this).hover(function () {
                    $(this).find('h2').addClass('collapse');
                }, function () {
                    $(this).find('h2').removeClass('collapse');
                }).find('h2').hover(function () {
                    $(this).find('.tips').css('visibility', 'visible');
                }, function () {
                    $(this).find('.tips').css('visibility', 'hidden');
                }).click(function () {
                    $(this).siblings('.dragbox-content').toggle();
                    $('.dragbox-content').not($(this).siblings('.dragbox-content')).hide();
                }).end().find('.tips').css('visibility', 'hidden');
            });

            lists.sortable({
                connectWith: '.column',
                handle: 'h2',
                cursor: 'move',
                placeholder: 'placeholder',
                forcePlaceholderSize: true,
                opacity: 0.4,
                start: function (event, ui) {
                    $('.dragbox-content').css("display", "none");
                },
                stop: function (event, ui) {

                    $(ui.item).find('h2').click();
                    var currentId = $(ui.item).attr("id");
                    var sortorder = '';
                    var itemorder = new Array();
                    if (option.editable) {
                        itemorder = lists.sortable('toArray');
                    }
                    else {
                        itemorder = $(".column").not(this).sortable('toArray');
                    }
                    var currentIndex = null;
                    for (var i = 0; i < itemorder.length; i++) {
                        if (itemorder[i] == currentId) {
                            currentIndex = i + 1;
                            break;
                        }
                    }
                    Update(currentId, true, currentIndex);
                }
            }).disableSelection();

            if (!option.editable) {
                var count = 1;
                var start = 1;
                if (data.total == undefined || data.total == 0) {
                }
                else if (data.total % pagesize == 0) {
                    count = data.total / pagesize;
                }
                else {
                    count = Math.floor(data.total / pagesize) + 1;
                }

                if (data.page != undefined && data.page != 0) {
                    start = data.page;
                }

                $("#paginate").paginate({
                    count: count,
                    start: start,
                    display: 9,
                    border: false,
                    text_color: '#888',
                    background_color: '#EEE',
                    text_hover_color: 'black',
                    background_hover_color: '#CFCFCF',
                    onChange: function (page) {
                        lists.ajaxlists({
                            url: option.url,
                            queryParam: { PersonsId: option.queryParam.PersonsId,
                                Title: option.queryParam.Title,
                                Page: page,
                                PageSize: pagesize
                            },
                            editable: false
                        });
                    }
                });
            }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {

            $("#divLoading").css("display", "none");
        }
    });
};

function GetPage() {
    return currentPage;
}
function GetColor(status) {
    switch (status) {
        case -1: return "Red";
        case 0: return "Silver";
        case 1: return "Orange";
        case 2: return "Green";
        default: return "Silver";
    }
};

function Edit(id) {
    $("#planWT_" + id + ",#describe_" + id).removeAttr("disabled");
    $("#save_" + id).css("display", "inline");
    $("#edit_" + id).css("display", "none");

    var statusName = $("#status_" + id).html();
    $("#status_" + id).replaceWith("<input id='status_" + id + "' name='status' class='easyui-combobox' panelheight='auto'/>");
    var data = $.JSONCookie("EventStatus");
    if (data.Status == undefined) {
        $.ajax({
            type: "POST",
            url: '../../JobLists/GetStatusList/',
            cache: true,
            success: function (data) {
                $.JSONCookie("EventStatus", { Status: data }, { expires: 0.004 });
                $("#status_" + id).combobox({ data: data, valueField: 'Value', textField: 'Key', editable: false });
                $("#status_" + id).combobox("setText", statusName);
            }
        });
    }
    else {
        $("#status_" + id).combobox({ data: data.Status, valueField: 'Value', textField: 'Key', editable: false });
        $("#status_" + id).combobox("setText", statusName);
    }
}
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

function fomatDate(str) {
    return (new Date(parseInt(str.substring(str.indexOf('(') + 1, str.indexOf(')'))))).format("yyyy-MM-dd hh:mm:ss");
}

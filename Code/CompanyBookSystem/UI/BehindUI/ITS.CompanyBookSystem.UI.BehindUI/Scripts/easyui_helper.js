/** 
*  EasyUi帮助JS 
* 
* @author 王玉玺 
* @date 2012/9/4 
* 
*/
function submitForm(url, formid) {

    $('#formid').form('submit', {
        url: url,
        onSubmit: function () {
            var flag = $(this).form('validate');
            if (flag) {
                showProcess(true, '温馨提示', '正在提交数据...');
            }
            return flag;
        },
        success: function (data) {
            showProcess(false);
            if (data == 1) {
                top.showMsg('温馨提示', '提交成功！');
                if (parent !== undefined) {
                    if ($.isFunction(window.reloadParent)) {
                        reloadParent.call();
                    } else {
                        parent.$("#tt").datagrid('reload');
                        parent.closeMyWindow();
                    }
                }
            } else {
                $.messager.alert('温馨提示', data);
            }
        },
        onLoadError: function () {
            showProcess(false);
            $.messager.alert('温馨提示', '由于网络或服务器太忙，提交失败，请重试！');
        }
    });
}

function showProcess(isShow, title, msg) {
    if (!isShow) {
        $.messager.progress('bar').progressbar('setValue', 100);
        $.messager.progress('close');
        return;
    }
    var win = $.messager.progress({
        title: title,
        msg: msg,
        text:"",
        interval: 1000
    });
}
$.extend($.fn.validatebox.defaults.rules, {
    mobile: {
        validator: function (value, param) {
            return /^((\(\d{2,3}\))|(\d{3}\-))?13\d{9}$/.test(value);
        },
        message: '手机号码不正确'
    },
    //最大字符验证
    maxLength: {
        validator: function (value, param) {
            return value.length <= param[0];
        },
        message: '该输入项不可超过{0}字符！'
    },
    //最小字符验证
    minLength: {
        validator: function (value, param) {
            return value.length >= param[0];
        },
        message: '该输入项不可低于{0}字符！'
    },
    //定长字符验证
    fixLength: {
        validator: function (value, param) {
            return value.length == param[0];
        },
        message: '该输入项只能为{0}字符！'
    },
    //邮政编码
    ZIP: {
        validator: function (value, param) {
            return /^[1-9]\d{5}$/.test(value);
        },
        message: '邮政编码不存在'
    },
    MustLittle: {
        validator: function (value, param) {

            var num = $('#' + param[0]).val();
            if (num) {
                var total = parseInt(num, 10);
                var main = parseInt(value, 10);
                return main <= total;
            }
            else return true;
        },
        message: '主营业收入不能超过全年营业收入'
    },
    MustBig: {
        validator: function (value, param) {
            var num = $('#' + param[0]).val();
            if (num) {
                var total = parseInt(num, 10);
                var main = parseInt(value, 10);
                return main >= total;
            }
            else return true;
        },
        message: '主营业收入不能超过全年营业收入'
    }
});
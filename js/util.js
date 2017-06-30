/**
 * 通用js
 */

/**
 * 截取字符串
 * @param oldString 传入字符串
 * @param num       保留的长度
 * @param addString 加入后缀字符
 * @returns {string}    返回新的字符串
 */
function subStringUtil(oldString, num, addString) {
    var newString = "";
    if(oldString==null||oldString==""){
        return oldString;
    }
    if (oldString.length > num) {
        newString = oldString.substring(0, num - 1);
        newString += addString;
    } else {
        newString = oldString;
    }
    return newString;
}

/**
 * 截取字符串
 * @param {} originStr
 * @param {} showLen
 * @param {} replaceSymbol
 * @return {}
 */
function cutString(str, len, replaceSymbol) {
    if (!str || !len) {
        return '';
    }
    var a = 0;
    var i = 0;
    var temp = '';
    for (i = 0; i < str.length; i++) {
        if (str.charCodeAt(i) > 255) {
            a += 2;
        } else {
            a++;
        }
        if (a > len) {
            return temp + replaceSymbol;
        }
        temp += str.charAt(i);
    }
    return str;
}


function getStrLength(str) {
    var num = 0;
    for (var i = 0; i < str.length; i++) {
        if (str.charCodeAt(i) > 255) {
            num += 2;
        } else {
            num++;
        }
    }
    return num;
}

function toHexStr(str) {
    var hexstr = "";
    var byteCount = 0;
    for (var i = 0; i < str.length; i++) {
        byteCount = str.charCodeAt(i);
        if (byteCount.length == 1) {
            byteCount = "0" + byteCount;
        }
        byteCount = byteCount.toString(16).toUpperCase();
        hexstr += byteCount;
    }
    return hexstr;
}

function fmtTime(timeStr) {
    var tt = parseInt(timeStr) / 1000;
    var hh = Math.floor(tt / 3600);
    hh = hh < 10 ? "0" + hh : "" + hh;
    var mm = Math.floor(tt % 3600 / 60);
    mm = mm < 10 ? "0" + mm : "" + mm;
    var ss = Math.ceil(tt % 3600 % 60);
    //var ss =tt % 3600 % 60;
    ss = ss < 10 ? "0" + ss : "" + ss;
    return hh + ":" + mm + ":" + ss;
}

function addZero(num){
    var istr = num + "";
    if(istr.length == 2){ return istr;}
    if(istr.length ==1 ){ return "0" + istr;}
    if(istr.length ==0 ){ return "00";}
}

//秒转换为hh:mm:ss格式
function secToTimeStr(sec) {
    var hours_rec = parseInt(sec/3600);
    if (hours_rec >= 24) {
        hours_rec = hours_rec - 24;
    }
    var minus_rec = parseInt((sec%3600)/60);
    var sec_rec = parseInt(sec%60);
    var result = addZero(hours_rec) + ":" + addZero(minus_rec) + ":" + addZero(sec_rec);
    return result;
}

//取得Cookie
function getCookie(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "=");
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1;
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1) c_end = document.cookie.length;
            return unescape(document.cookie.substring(c_start, c_end));
        }
    }
    return "";
}
//设置Cookie
function setCookie(c_name, value, expiredays) {
    if(expiredays==null||expiredays=="")
        expiredays = 1;
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + expiredays);
    document.cookie = c_name + "=" + value + ((expiredays == null) ? "" : ";expires=" + exdate.toUTCString());
}

//删除Cookie
function DelCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = getCookie(name);
    document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString();
}

//删除Cookie二
function DelCookie2(name) {
    setCookie(name,"",-1);

}

 function getParam(name) {
	var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
	var r=window.location.search.substr(1).replace(new RegExp(/(amp;)/g),'').match(reg);
	if (r != null) {
		return r[2];
	}
	return null;
}
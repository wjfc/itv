/**
 * Created by sungang on 15/12/1.
 */
var Action = {
    focusPos: "",
    browType: "GOOGLE",
    oldFocus: "",
    KEY: {},
    chsLog: function (str) {
        var logdiv = document.getElementById("chs-log");
        if (!logdiv) {
            var div = document.createElement('div');
            div.innerHTML = [
                '<div id="chs-log">',
                'test-log:',
                '</div>'
            ].join('');
            document.body.appendChild(div);
            logdiv = document.getElementById("chs-log");
        }
        logdiv.innerHTML = logdiv.innerHTML + "-" + str;
    },
    chsAlert: {},
    tipTimer: null,
    tipOldFocusPos: "",
    chsTip: function (str, fun, showTime) {
        var tipDiv = document.getElementById("chs-tip");
        if (!tipDiv) {
            var div = document.createElement('div');
            div.innerHTML = [
                '<div id="chs-tip" class="chs-tip">',
                '<div class="chs-tip-title">友情提示</div>',
                '<div class="chs-tip-content" id="chs-tip-content"></div>',
                '</div>'
            ].join('');
            document.body.appendChild(div);
            tipDiv = document.getElementById("chs-tip");
        }
        tipDiv.style.visibility = "visible";
        document.getElementById("chs-tip-content").innerHTML = str;
        if (Action.focusPos != "CHS-TIP") {
            Action.tipOldFocusPos = Action.focusPos;
            Action.focusPos = "CHS-TIP";
        }
        if (Action.tipTimer != null) {
            clearTimeout(Action.tipTimer);
            Action.tipTimer = null;
        }
        Action.tipTimer = setTimeout(function () {
            tipDiv.style.visibility = "hidden";
            Action.focusPos = Action.tipOldFocusPos;
            fun();
        }, showTime);
    },


    regist: function () {
        var div = document.createElement('div');
        div.innerHTML = [
            '<div id="process">',
            '</div>'
        ].join('');
        document.body.appendChild(div);
    },
    lockAction: function () {
        $("#process").css("display", "block");
        this.oldFocus = this.focusPos;
        this.focusPos = "";
    },

    unLockAction: function () {
        $("#process").css("display", "none");
        this.focusPos = this.oldFocus;
        this.oldFocus = "";
    },

    initAction: function () {
        this.regist();
        this.initBrowType();
        this.initKey();
    },
    initBrowType: function () {
        //判断盒子类型
        /* try {
         var userAgent = window.navigator.userAgent;
         if (userAgent.indexOf("Chrome") > 0) {
         this.browType = "Chrome";
         //document.onkeyup = this.handleMethod;
         document.onkeydown= this.handleMethod;
         } else if (userAgent.indexOf("DVNBrowser") >= 0) {
         this.browType = "DVN";  //天柏的盒子
         document.onirkeypress = this.handleMethod;
         document.onkeypress = this.handleMethod;
         } else if (userAgent.indexOf("Coship") >= 0) {
         this.browType = "COSHIP"; //同洲盒子
         document.onirkeypress = this.handleMethod;
         document.onkeypress = this.handleMethod;
         } else if (userAgent.indexOf("iPanel") >= 0) {
         this.browType = "IPANEL";    //茁壮
         document.onirkeypress = this.handleMethod;
         document.onkeypress = this.handleMethod;
         } else if (userAgent.indexOf("Firefox") > 0) {
         this.browType = "Firefox";
         document.onkeypress = this.handleMethod;
         } else {
         this.browType = "PUBLIC";   //其他所有通用的盒子
         document.onkeypress = this.handleMethod;
         }
         } catch (e) {
         this.browType = "PUBLIC";
         document.onkeypress = this.handleMethod;
         }*/
        //document.onkeydown = this.handleMethod;
        //document.onkeyup = this.handleMethod;
        //document.onsystemevent = this.handleMethod;


        //判断盒子类型
        try {
            var userAgent = window.navigator.userAgent;
            if (userAgent.indexOf("Chrome") > 0) {
                this.browType = "Chrome";
                //document.onkeyup = this.handleMethod;
                document.onkeydown = this.handleMethod;
            } else if (userAgent.indexOf("DVNBrowser") >= 0) {
                if (userAgent.indexOf("Coship") >= 0) {
                    this.browType = "TVOS";  //TVOS的盒子
                } else if (userAgent.indexOf("iPanel") >= 0) {
                    this.browType = "DVN_IPANEL";  //无锡天柏中间件
                } else {
                    this.browType = "DVN";  //天柏的盒子
                }
                //document.onirkeypress = this.handleMethod;
                document.onkeypress = this.handleMethod;
            } else if (userAgent.indexOf("Coship") >= 0) {
                this.browType = "COSHIP"; //同洲盒子
                document.onirkeypress = this.handleMethod;
                document.onkeypress = this.handleMethod;
            } else if (userAgent.indexOf("iPanel") >= 0) {
                this.browType = "IPANEL";    //茁壮
                document.onirkeypress = this.handleMethod;
                document.onkeypress = this.handleMethod;
            } else if (userAgent.indexOf("Firefox") > 0) {
                this.browType = "Firefox";
                document.onkeypress = this.handleMethod;
            } else if (userAgent.indexOf("Android") >= 0) { // && userAgent.indexOf("Skyworth") >= 0
                this.browType = "ANDROID";
                document.onkeydown = this.handleMethod;
            } else {
                this.browType = "PUBLIC";   //其他所有通用的盒子
                document.onkeypress = this.handleMethod;
            }
        } catch (e) {
            this.browType = "PUBLIC";
            document.onkeypress = this.handleMethod;
        }
    },
    handleMethod: function () {
        var keyCode = event.keyCode || event.which;
        //event.preventDefault();
        eventHandle(keyCode);
    },
    initKey: function () {
        if (this.browType == "IE" || this.browType == "Firefox" || this.browType == "Chrome") {
            this.KEY = {
                UP: 38,
                DOWN: 40,
                LEFT: 37,
                RIGHT: 39,
                ENTER: 13,
                PAGEUP: 33,
                PAGEDOWN: 34,
                //后退-
                BACK: 189,
                //退出+
                EXIT: 187,
                NUMBER0: 48,
                NUMBER1: 49,
                NUMBER2: 50,
                NUMBER3: 51,
                NUMBER4: 52,
                NUMBER5: 53,
                NUMBER6: 54,
                NUMBER7: 55,
                NUMBER8: 56,
                NUMBER9: 57,
                //音量>
                VOLUMNUP: 190,
                //音量减<
                VOLUMNDOWN: 188,
                STOP: 48,//stop
                STOPPOINT: 68,//stop
                //静音：?
                VOLUMNNO: 191,
                F1: 65, //A
                F2: 66, //B
                F3: 67, //C
                F4: 68,  //D
                INFO: 73  //I
            };
        } else if (this.browType == "DVN") {
            Utility.ioctlWrite("JsAddKeyState", "N");
            //苏州天柏盒子        华南安卓的盒子
            this.KEY = {
                UP: 38,
                DOWN: 40,
                LEFT: 37,
                RIGHT: 39,
                ENTER: 13,
                PAGEDOWN: 121,
                PAGEUP: 120,
                //BACK: 122,
                BACK: 8,
                EXIT: 0x72,
                NUMBER0: 48,
                NUMBER1: 49,
                NUMBER2: 50,
                NUMBER3: 51,
                NUMBER4: 52,
                NUMBER5: 53,
                NUMBER6: 54,
                NUMBER7: 55,
                NUMBER8: 56,
                NUMBER9: 57,
                VOLUMNUP: 190,
                VOLUMNDOWN: 188,
                VOLUMNNO: 77,//静音
                STOP: 65,//播放时按退出响应的键值
                STOP1: 0x41,
                STOPPOINT: 80,//播放时按后退响应的键值
                //STOPPOINT1:68,
                MENU: 72,
                F1: 96,
                F2: 97,
                F3: 98,
                F4: 99,
                END: 0x20, //播放结束事件
                END1: 0x2B,//43
                END2: 48,//stop
                INFO: 112,//信息
                VODEND: 45012

            };
        } else if (this.browType == "TVOS") {
            Utility.ioctlWrite("JsAddKeyState", "N");
            //TVOS盒子
            this.KEY = {
                UP: 38,
                DOWN: 40,
                LEFT: 37,
                RIGHT: 39,
                ENTER: 13,
                PAGEDOWN: 121,
                PAGEUP: 120,
                BACK: 640,
                EXIT: 0x72,
                NUMBER0: 48,
                NUMBER1: 49,
                NUMBER2: 50,
                NUMBER3: 51,
                NUMBER4: 52,
                NUMBER5: 53,
                NUMBER6: 54,
                NUMBER7: 55,
                NUMBER8: 56,
                NUMBER9: 57,
                VOLUMNUP: 190,
                VOLUMNDOWN: 188,
                VOLUMNNO: 77,//静音
                STOP: 48,//播放时按退出响应的键值
                STOP1: 0x41,
                STOPPOINT: 80,//播放时按后退响应的键值
                //STOPPOINT1:68,
                MENU: 72,
                F1: 96,
                F2: 97,
                F3: 98,
                F4: 99,
                END: 768, //播放结束事件
                //END1:0x2B,
                INFO: 112,//信息
                VODEND: 45012

            };
        } else if (this.browType == "DVN_IPANEL") {
            //Utility.ioctlWrite("JsAddKeyState","N");
            //无锡天柏中间件
            this.KEY = {
                UP: 38,
                DOWN: 40,
                LEFT: 37,
                RIGHT: 39,
                ENTER: 13,
                PAGEDOWN: 121,
                PAGEUP: 120,
                BACK: 122,
                BACK1: 8,
                EXIT: 0x72,
                NUMBER0: 48,
                NUMBER1: 49,
                NUMBER2: 50,
                NUMBER3: 51,
                NUMBER4: 52,
                NUMBER5: 53,
                NUMBER6: 54,
                NUMBER7: 55,
                NUMBER8: 56,
                NUMBER9: 57,
                VOLUMNUP: 190,
                VOLUMNDOWN: 188,
                VOLUMNNO: 77,//静音
                STOP: 48,//播放时按退出响应的键值
                STOP1: 0x41,
                STOPPOINT: 80,//播放时按后退响应的键值
                //STOPPOINT1:68,
                MENU: 72,
                F1: 96,
                F2: 97,
                F3: 98,
                F4: 99,
                END: 0x20, //播放结束事件
                //END1:0x2B,
                INFO: 112,//信息
                VODEND: 45012
            };
        }
        else if (this.browType == "COSHIP") {
            //讲键值转换成
            Utility.ioctlWrite("JsAddKeyState", "N");
            //Coship浏览器其他类型的盒子
            this.KEY = {
                UP: 28,
                DOWN: 29,
                LEFT: 30,
                RIGHT: 31,
                ENTER: 13,
                PAGEDOWN: 121,
                PAGEUP: 120,
                BACK: 32,
                EXIT: 114,//退出+
                NUMBER0: 48,
                NUMBER1: 49,
                NUMBER2: 50,
                NUMBER3: 51,
                NUMBER4: 52,
                NUMBER5: 53,
                NUMBER6: 54,
                NUMBER7: 55,
                NUMBER8: 56,
                NUMBER9: 57,
                VOLUMNUP: 41,//音量+
                VOLUMNDOWN: 39,//音量-
                VOLUMNNO: 40,//静音
                //STOP: 48,//退出播放    TODO
                //STOP: 0x41,//播放时按退出响应的键值
                STOP: 65,//播放时按退出响应的键值
                //STOPPOINT: 68,//暂停播放    TODO
                STOPPOINT: 0x20,//播放时按后退响应的键值
                MENU: 113,//菜单
                INFO: 112,//信息
                CHANNELUP: 122,//频道+
                CHANNELDOWN: 123,//频道-
                VOD: 74,//点播
                LIKE: 70,//喜爱
                NAVIGATION: 19,//导航
                F1: 96,
                F2: 97,
                F3: 98,
                F4: 99,
                //END: 0x20, //播放结束事件  TODO
                END: 0x2B,

                VODEND: 45012 //播放结束
            };


        }else if(this.browType == "ANDROID"){
            Utility.ioctlWrite("JsAddKeyState", "N");
            this.KEY = {
                UP:28,
                DOWN:29,
                LEFT:30,
                RIGHT:31,
                ENTER:13,
                PAGEUP:120,
                PAGEDOWN:121,
                BACK:32,
                EXIT:114,
                NUMBER0:48,
                NUMBER1:49,
                NUMBER2:50,
                NUMBER3:51,
                NUMBER4:52,
                NUMBER5:53,
                NUMBER6:54,
                NUMBER7:55,
                NUMBER8:56,
                NUMBER9:57,
                VOLUMNUP:190,
                VOLUMNDOWN:188,
                VOLUMNNO:0x28,//静音
                STOP:48,//播放时按退出响应的键值
                STOPPOINT:65,//播放时按后退响应的键值
                STOPPOINT1:65,
                MENU:113,
                F1:96,
                F2:97,
                F3:98,
                F4:99,
                END:0x20, //播放结束事件
                END1:0x2B,
                INFO:112//信息
            };

        }
        else {
            // 其他通用键值
            this.KEY = {
                UP: 38,
                DOWN: 40,
                LEFT: 37,
                RIGHT: 39,
                ENTER: 13,
                PAGEDOWN: 34,
                PAGEUP: 33,
                BACK: 189,
                //BACK1:189,
                //退出+
                EXIT: 187,
                NUMBER0: 48,
                NUMBER1: 49,
                NUMBER2: 50,
                NUMBER3: 51,
                NUMBER4: 52,
                NUMBER5: 53,
                NUMBER6: 54,
                NUMBER7: 55,
                NUMBER8: 56,
                NUMBER9: 57,
                //音量>
                VOLUMNUP: 190,
                //音量减<
                VOLUMNDOWN: 188,
                STOP: 48,//stop
                STOPPOINT: 68,//stop
                //静音：?
                VOLUMNNO: 191,
                F1: 65, //A
                F2: 66, //B
                F3: 67, //C
                F4: 68,  //D
                VODEND: 45012
            };
        }
    },

    /**
     *
     * @param url
     * @param callback
     * @param flag  为true时，不锁定焦点， 为false或不传时候，锁定焦点。
     */
    callGetService: function (url, callback, flag) {
        if (!flag) {
            //请求前的处理
            Action.lockAction();
        }
        setTimeout(function () {
            $.ajax({
                url: url,    //请求的url地址
                dataType: "json",   //返回格式为json
                async: true, //请求是否异步，默认为异步，这也是ajax重要特性
                type: "GET",   //请求方式
                beforeSend: function () {

                },
                success: function (data) {
                    if (!flag) {
                        Action.unLockAction();
                    }
                    callback(data);
                },
                complete: function () {
                    /*//请求完成的处理
                     Action.unLockAction();*/
                },
                error: function () {
                    if (!flag) {
                        Action.unLockAction();
                    }
                    //请求出错处理
                    Action.chsTip("请求失败，请稍后重试！", function () {

                    }, 3000);
                }
            });
        }, 5);

    },

    /**
     *
     * @param url
     * @param callback
     * @param flag  为true时，不锁定焦点， 为false或不传时候，锁定焦点。
     */
    callGetServiceError: function (url, callback, errorback, flag) {
        if (!flag) {
            //请求前的处理
            Action.lockAction();
        }
        setTimeout(function () {
            $.ajax({
                url: url,    //请求的url地址
                dataType: "json",   //返回格式为json
                async: true, //请求是否异步，默认为异步，这也是ajax重要特性
                type: "GET",   //请求方式
                beforeSend: function () {

                },
                success: function (data) {
                    if (!flag) {
                        Action.unLockAction();
                    }
                    callback(data);
                },
                complete: function () {
                    /*//请求完成的处理
                     Action.unLockAction();*/
                },
                error: function () {
                    if (!flag) {
                        Action.unLockAction();
                    }
                    //请求出错处理
                    errorback();
                    /*//请求出错处理
                     Action.chsTip("请求失败，请稍后重试！", function () {

                     },3000);*/
                }
            });
        }, 5);

    },

    callPostService: function (url, data, callback, flag) {
        if (!flag) {
            //请求前的处理
            Action.lockAction();
        }
        setTimeout(function () {
            $.ajax({
                url: url,    //请求的url地址
                dataType: "json",   //返回格式为json
                async: true, //请求是否异步，默认为异步，这也是ajax重要特性
                data: data,    //参数值
                type: "POST",   //请求方式
                beforeSend: function () {

                },
                success: function (data) {
                    if (!flag) {
                        Action.unLockAction();
                    }
                    callback(data);
                },
                complete: function () {
                    //请求完成的处理
                    //Action.unLockAction();
                },
                error: function () {
                    if (!flag) {
                        Action.unLockAction();
                    }
                    //请求出错处理
                    Action.chsTip("请求失败，请稍后重试！", function () {

                    }, 3000);
                }
            });
        }, 5);
    },

    goBack: function () {
        window.history.go(-1);
    }
};

/**
 * 文广专用
 * @param playerUrl
 */

function toPlayPage(playerUrl) {
    if (Action.browType == "DVN" || Action.browType == "ANDROID") {
        var p = playerUrl.indexOf("sitvPlayer.do");
        if (p >= 0) {
            playerUrl = playerUrl.replace("sitvPlayer", "player");
        }
    }
    //playerUrl = playerUrl.replace("sitvPlayer", "player");
    playerUrl = playerUrl.replace("sitvPlayer", "sitvPlayer1");
    window.location.href = playerUrl;
}

/**
 * cctv  专用  央视
 * @param playerUrl
 */
/*function toPlayPage(playerUrl) {
    if (Action.browType == "DVN" || Action.browType == "ANDROID") {
        var p = playerUrl.indexOf("cctvPlayer.do");
        if (p >= 0) {
            playerUrl = playerUrl.replace("cctvPlayer", "player");
        }
    }
    //playerUrl = playerUrl.replace("sitvPlayer", "player");
    playerUrl = playerUrl.replace("cctvPlayer", "cctvPlayer1");
    window.location.href = playerUrl;
}*/

/**
 * ifeng  专用  凤凰专区
 * @param playerUrl
 */
/*function toPlayPage(playerUrl) {
    if (Action.browType == "DVN" || Action.browType == "ANDROID") {
        var p = playerUrl.indexOf("iFengPlayer.do");
        if (p >= 0) {
            playerUrl = playerUrl.replace("iFengPlayer", "player");
        }
    }
    //playerUrl = playerUrl.replace("sitvPlayer", "player");
    //playerUrl = playerUrl.replace("cctvPlayer", "cctvPlayer1");
    window.location.href = playerUrl;
}*/
/*剧集后退地址*/
function goBack(){
    Action.goBack();
}

Action.initAction();


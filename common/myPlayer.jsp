<%--
  Created by IntelliJ IDEA.
  User: sungang
  Date: 16/7/13
  Time: 上午9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="1280*720; text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>CHS播放器</title>
    <link type="text/css" href="../css/common.css" rel="stylesheet">
    <style type="text/css">
        body {
            background-color: transparent;
            color: #ffffff;
        }

        .icon-mute {
            position: absolute;
            left: 100px;
            top: 60px;
            background: url("images/ico-stop.png") no-repeat;
            width: 60px;
            height: 50px;
            display: none;
        }

        .ad-timer {
            position: absolute;
            left: 985px;
            top: 50px;
            width: 149px;
            height: 53px;
            background: url(images/ad_time_bg.png);
            line-height: 53px;
            text-align: center;
            color: red;
            display: none;
        }

        .ad-pause-bg {
            position: absolute;
            left: 200px;
            top: 70px;
            background: url(images/puase_adBorder.png) no-repeat;
            width: 766px;
            height: 459px;
            display: none;
        }

        .ad-pause-bg > .ad {
            position: absolute;
            left: 249px;
            top: 60px;
            width: 500px;
            height: 380px;
        }

        .ad-pause-bg > .ad > img {
            width: 500px;
            height: 380px;
        }

        /*进度条*/
        .controls-bar {
            position: absolute;
            left: 146px;
            top: 570px;
            width: auto;
            height: auto;
            display: none;
        }

        .controls-bar > .controls-bg {
            float: left;
            background: url("images/vod_hd.png") no-repeat;
            width: 837px;
            height: 108px;
            font-size: 24px;
        }

        .controls-bar > .controls-bg > .c-icons {
            position: absolute;
            left: 14px;
            top: 36px;
        }

        .controls-bar > .controls-bg > .c-icons > li {
            float: left;
            width: 36px;
            height: 37px;
            margin-right: 3px;
            visibility: hidden;
        }

        .controls-bar > .controls-bg > .c-icons > li.c-play {
            background: url("images/play_focus_icon.png") no-repeat;
            visibility: visible;
        }

        .controls-bar > .controls-bg > .c-icons > li.c-pause {
            background: url("images/suspend_focus.png") no-repeat;
        }

        .controls-bar > .controls-bg > .c-icons > li.c-stop {
            background: url("images/stop_focus.png") no-repeat;
        }

        .controls-bar > .controls-bg > .c-icons > li.c-backward {
            background: url("images/slow_focus_icon.png") no-repeat;
        }

        .controls-bar > .controls-bg > .c-icons > li.c-forward {
            background: url("images/speed_focus_icon.png") no-repeat;
        }

        .controls-bar > .controls-bg > .curTime {
            position: absolute;
            left: 215px;
            top: 39px;
            width: 100px;
            height: 30px;
            text-align: center;

        }

        .controls-bar > .controls-bg > .durTime {
            position: absolute;
            left: 715px;
            top: 40px;
            width: 100px;
            height: 30px;
            text-align: center;
        }

        .controls-bar > .controls-bg > .progress-bar {
            position: absolute;
            left: 328px;
            top: 47px;
            width: 380px;
            height: 15px;
            background-color: #FFC911;
        }

        .controls-bar > .controls-bg > .progress-bar > .point-dot {
            position: absolute;
            left: 100%;
            top: 0px;
            background: url("images/dot.png") no-repeat;
            width: 23px;
            height: 25px;
            margin-left: -6px;
            margin-top: -6px;
        }

        .controls-bar > .controls-bg > .c-movieName {
            position: absolute;
            left: 45px;
            top: 0px;
            width: 700px;
            height: 30px;
            line-height: 30px;
            color: #111111;
        }

        .controls-bar > .controls-bg > .c-statusText {
            position: absolute;
            left: 413px;
            top: 82px;
            height: 24px;
            width: 217px;
            line-height: 24px;
        }

        .controls-bar > .controls-ad {
            float: left;
        }

        .controls-bar > .controls-ad > img {
            margin-left: 5px;
            height: 108px;
        }

        .volume-bar {
            position: absolute;
            left: 200px;
            top: 643px;
            background: url("images/vo.png") no-repeat;
            width: 800px;
            height: 58px;
            display: none;
        }

        .volume-bar > .volume-progress {
            position: absolute;
            left: 105px;
            top: 25px;
            background: url("images/vo_gre.png");
            width: 580px;
            height: 6px;
        }

        .volume-bar > .volume-progress > .volume-dot {
            margin-left: 100%;
            margin-top: -7px;
            background: url("images/vo_g.png") no-repeat;
            width: 28px;
            height: 18px;
        }

        .volume-bar > .volume-num {
            position: absolute;
            left: 732px;
            top: 16px;
            width: 50px;
            height: 22px;
            text-align: center;
            line-height: 22px;
            font-size: 18px;
        }

        .video-tip {
            position: absolute;
            top: 184px;
            left: 411px;
            width: 543px;
            height: 301px;
            background: url("images/box_bg.gif");
            width: 361px;
            height: 202px;
            font-size: 24px;
            display: none;
        }

        .tip-title {
            width: 100%;
            height: 40px;
            text-align: center;
            line-height: 40px;
        }

        .tip-content {
            width: 100%;
            height: 40px;
            text-align: center;
            line-height: 40px;
            padding-top: 10px;
        }

        .con-container {
            position: absolute;
            left: 200px;
            top: 70px;
            height: 492px;
            width: 769px;
            background: url(images/tab_content_bg.png) no-repeat;
            font-size: 18px;
            display: none;

        }

        .con-container > .tabs {
            width: 100%;
            height: 65px;
        }

        .con-container > .tabs > li {
            float: left;
            width: 256px;
            height: 65px;
        }

        .con-container > .tabs > li.l-focus {
            background: url("images/tab_focus_L.png") no-repeat;
        }

        .con-container > .tabs > li.m-focus {
            background: url("images/tab_focus_M.png") no-repeat;
        }

        .con-container > .tabs > li.r-focus {
            background: url("images/tab_focus_R.png") no-repeat;
        }

        .con-container > .content {
            padding: 20px;
            height: 387px;
            width: 728px;
            color: #000000;
            font-size: 22px;
            overflow: hidden;
        }

        .con-container > .content > li {
            line-height: 34px;
        }

        .con-container > .content > li.help {
            margin-left: 80px;
            margin-top: 40px;
            height: 387px;
            width: 645px;
            display: none;
        }

        .con-container > .content > li.xuanshi {
            margin-top: 40px;
            padding-left: 100px;
            line-height: 60px;
        }

        .con-container > .content > li.xuanshi > div {
            width: 100%;
            text-align: left;
            display: block;
        }

        .con-container > .content > li.xuanshi > div.xs-time > ul {
            padding-left: 40px;
            display: block;
        }

        .con-container > .content > li.xuanshi > div.xs-time > ul > li {
            float: left;
            width: 100px;
            text-align: center;
            margin-right: 50px;
            border: solid #ffffff 3px;
        }

        .con-container > .content > li.xuanshi > div.xs-time > ul > li.focus {
            border: solid #D0E62F 3px;
        }

        .con-container > .content > li.xuanshi > div.xs-time > ul > li > span.focus {
            border-bottom: solid #000000 2px;
        }

        .con-container > .content > li.xuanshi > div.xs-tishi {
            clear: both;
        }

        .con-container > .content > li.info {
            display: none;
            padding: 10px;
        }

        .errorTip {
            color: #ff0000;
            display: none;
        }
    </style>
</head>
<body onunload="CHS.video.close();">
<!-- 静音标示 -->
<div class="icon-mute"></div>

<!-- 视频广告倒计时显示条 -->
<div class="ad-timer">广告倒计时<span id="time">20</span>秒</div>

<!-- 两个广告位  1进度条广告（播控条） 2 暂停广告   -->
<div class="ad-pause-bg">
    <div class="ad">
        <img src="images/pause_ad.gif" width="500" height="380">
    </div>
</div>

<div class="controls-bar">
    <div class="controls-bg">
        <!-- 五个按钮 播放，暂停，停止，快退，快进-->
        <ul class="c-icons">
            <li class="c-play"></li>
            <li class="c-pause"></li>
            <li class="c-stop"></li>
            <li class="c-backward"></li>
            <li class="c-forward"></li>
        </ul>
        <!-- 当前时间，滚动条，总时长-->
        <div class="curTime">00:00:00</div>
        <div class="progress-bar">
            <div class="point-dot"></div>
        </div>
        <div class="durTime">01:12:56</div>

        <div class="c-movieName">我是特种兵</div>
        <div class="c-statusText">播放</div>
    </div>
    <!-- 进度条广告 -->
    <div class="controls-ad">
        <img src="images/control_ad.gif" width="240" height="145">
    </div>
</div>

<!-- 音量条 -->
<div class="volume-bar">
    <div class="volume-progress">
        <div class="volume-dot"></div>
    </div>
    <div class="volume-num">7</div>
</div>

<div class="video-tip">
    <div class="tip-title">友情提示</div>
    <div class="tip-content">正在连接网络，请稍侯....</div>
</div>

<!-- 信息，帮助，推荐 -->
<div class="con-container">
    <ul class="tabs">
        <li></li>
        <li></li>
        <li></li>
    </ul>
    <ul class="content">
        <li class="help">
            <ul>
                <li>【上】暂停,【后退】、【退出】退出播放
                </li>
                <li>【左】、【上页】快退，【右】、【下页】快进
                </li>
                <li>【确认】播放，长按【右】快速快进，长按【左】快速快退
                </li>
                <li>【F1】帮助，【F2】选时，【信息】了解节目详情
                </li>
            </ul>
        </li>
        <li class="xuanshi">
            <div class="xs-title">忍者神龟 00:00:00 - <span id="xs-durTime">00:00:00</span> <span class="errorTip">输入有误，请重新输入</span></div>
            <div class="xs-time">
                <ul>
                    <li class="focus">
                        <span class="focus">0</span>
                        <span>0</span>
                    </li>
                    <li>
                        <span>0</span>
                        <span>0</span>

                    </li>
                    <li>
                        <span>0</span>
                        <span>0</span>
                    </li>
                </ul>
            </div>
            <div class="xs-tishi">友情提示：输入时分秒，快速切换至对应时间点播放。</div>
        </li>
        <li class="info">
            <div class="actor">演员：忍者神龟</div>
            <div class="director">导演：忍者神龟</div>
            <div class="description">剧情简介：忍者神龟忍者神龟忍者神，忍者神龟忍者神龟忍者神龟忍者神龟，龟忍者神忍者神龟忍者神龟忍者神龟，龟忍者神龟，忍者神龟忍者神龟忍者神龟忍者神龟。</div>
        </li>
    </ul>
</div>
<script type="text/javascript" src="../js/constant.js"></script>
<script type="text/javascript" src="../js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../js/action.js"></script>
<script type="text/javascript" src="../js/showlist.js"></script>
<script type="text/javascript" src="../js/stb.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<script type="text/javascript">

    //进度条总长度
    var PROGRESSWIDTH = 380;
    //音量条总长度
    var VOLUMEWIDTH = 580;
    var movieInfo = {};

    function initPage() {
        getMovieInfo();
    }

    function getMovieInfo() {
        var url = "../movie/getMovieByCateIdAssetId.do?categoryId=${param.categoryId}&assetId=${param.assetId}";
        Action.callGetService(url, function (data) {
            movieInfo = data.searchResult[0];
            movieInfo.assetId = 'R0A8DmJfxGXO4Qgy4f92';
            queryPriceAuth();
        });
    }

    //询价鉴权
    function queryPriceAuth() {
        var url = "../confirmMessage/queryPriceAuth.do?assetId=" + movieInfo.assetId + "&stbNo=" + CHS.STB.getStbNo() + "&serviceType=10000";
        Action.callGetService(url, function (data) {
            if (data.errorcode == 0 || data.errorcode == "0") {
                movieInfoShow();
                var playAssetid = toHexStr(movieInfo.assetId) + ":normal";
                CHS.video.initVideo(playAssetid, movieInfo.title);
                CHS.video.vodFullPlay(300);
                //总时长
                $(".durTime").html(fmtTime(CHS.video.getDuration()));
                //选时总时长显示
                $("#xs-durTime").html(fmtTime(CHS.video.getDuration()));
                showProgress();
                getProgress();
            } else {
                hideVideoTip();
                Action.chsTip(data.errormsg, function () {
                    Action.goBack();
                }, 3000);
            }
        });
    }

    function movieInfoShow() {
        $(".c-movieName").html(movieInfo.title);
        $(".actors").html("演员：" + movieInfo.actors);
        $(".directors").html("导演：" + movieInfo.director);
        $(".description").html("剧情简介：" + movieInfo.shortDesc);
    }

    var mainTimer = null;
    //每一秒钟刷新进度条和播控状态
    function getProgress() {
        var curStatus = CHS.video.getCurState();
        var speed = CHS.video.getSpeed();
        statusShow(curStatus, speed);
        if (curStatus != 0) {
            var curPos = CHS.video.getCurPosition();
            var duration = CHS.video.getDuration();
            $(".curTime").html(fmtTime(curPos));
            var tt = curPos / duration;
            if (tt >= 1) {
                tt = 1;
            }
            $(".progress-bar").css("width", tt * PROGRESSWIDTH + "px");

            if (mainTimer != null) {
                clearTimeout(mainTimer);
                mainTimer = null;
            }
            mainTimer = setTimeout(function () {
                getProgress();
            }, 1000);
        }
    }

    var progressShowTimer = null;

    function showProgress() {
        $(".controls-bar").css("display", "block");
        var curStatus = CHS.video.getCurState();
        if (curStatus == 2) {
            if (progressShowTimer != null) {
                clearTimeout(progressShowTimer);
                progressShowTimer = null;
            }
            progressShowTimer = setTimeout(function () {
                $(".controls-bar").css("display", "none");
            }, 6000);
        } else {
            clearTimeout(progressShowTimer);
            progressShowTimer = null;
        }
    }

    //状态显示
    function statusShow(status, speed) {
        $(".c-icons>li").css("visibility", "hidden");
        if (status == 0 || status == 1) {
            $(".c-icons>li.c-stop").css("visibility", "visible");
            $(".c-statusText").html("准备");
        } else if (status == 2 || speed == 1) {
            hideVideoTip();
            $(".c-icons>li.c-play").css("visibility", "visible");
            $(".c-statusText").html("播放");
        } else if (status == 3) {
            hideVideoTip();
            $(".c-icons>li.c-pause").css("visibility", "visible");
            $(".c-statusText").html("暂停");
        } else if (status == 4) {
            hideVideoTip();
            if (speed > 1) {
                $(".c-icons>li.c-forward").css("visibility", "visible");
                $(".c-statusText").html("快进&nbsp;X" + parseInt(CHS.video.getSpeed()));
            } else if (speed < 0) {
                $(".c-icons>li.c-backward").css("visibility", "visible");
                $(".c-statusText").html("快退&nbsp;X" + parseInt(CHS.video.getSpeed()));
            }
        }
    }

    function showVideoTip(title, content) {
        $(".tip-title").html(title);
        $(".tip-content").html(content);
        $(".video-tip").css("display", "block");
    }

    function hideVideoTip() {
        $(".tip-title").html("");
        $(".tip-content").html("");
        $(".video-tip").css("display", "none");
    }

    //帮助 详情  选时
    var conFocus = "";
    function conEffect() {
        $(".con-container>.tabs>li").removeClass("r-focus");
        $(".con-container>.tabs>li").removeClass("m-focus");
        $(".con-container>.tabs>li").removeClass("l-focus");
        $(".con-container>.content>li").hide();
        if (conFocus == "INFO") {
            $(".con-container>.tabs>li:eq(2)").addClass("r-focus");
            $(".con-container>.content>li.info").css("display", "block");
        } else if (conFocus == "HELP") {
            $(".con-container>.tabs>li:eq(0)").addClass("l-focus");
            $(".con-container>.content>li.help").css("display", "block");
        } else if (conFocus == "XUANSHI") {
            $(".con-container>.tabs>li:eq(1)").addClass("m-focus");
            $(".con-container>.content>li.xuanshi").css("display", "block");
            $(".errorTip").css("display", "none");
            $(".xs-time>ul>li>span").html(0);
            conFocus = "H1";
            xsEffect();
        }
        $(".con-container").css("display", "block");
    }

    function xsEffect() {
        $(".xs-time>ul>li").removeClass("focus");
        $(".xs-time>ul>li>span").removeClass("focus");
        if (conFocus == "H1") {
            $(".xs-time>ul>li:eq(0)").addClass("focus");
            $(".xs-time>ul>li:eq(0)>span:eq(0)").addClass("focus");
        } else if (conFocus == "H2") {
            $(".xs-time>ul>li:eq(0)").addClass("focus");
            $(".xs-time>ul>li:eq(0)>span:eq(1)").addClass("focus");
        } else if (conFocus == "M1") {
            $(".xs-time>ul>li:eq(1)").addClass("focus");
            $(".xs-time>ul>li:eq(1)>span:eq(0)").addClass("focus");
        } else if (conFocus == "M2") {
            $(".xs-time>ul>li:eq(1)").addClass("focus");
            $(".xs-time>ul>li:eq(1)>span:eq(1)").addClass("focus");
        } else if (conFocus == "S1") {
            $(".xs-time>ul>li:eq(2)").addClass("focus");
            $(".xs-time>ul>li:eq(2)>span:eq(0)").addClass("focus");
        } else if (conFocus == "S2") {
            $(".xs-time>ul>li:eq(2)").addClass("focus");
            $(".xs-time>ul>li:eq(2)>span:eq(1)").addClass("focus");
        }
    }

    function setTimeNum(num) {
        $(".errorTip").css("display", "none");
        if (conFocus == "H1") {
            $(".xs-time>ul>li:eq(0)>span:eq(0)").html(num);
            conFocus = "H2";
            xsEffect();
        } else if (conFocus == "H2") {
            $(".xs-time>ul>li:eq(0)>span:eq(1)").html(num);
            conFocus = "M1";
            xsEffect();
        } else if (conFocus == "M1") {
            if (num >= 6) {
                num = 5;
            }
            $(".xs-time>ul>li:eq(1)>span:eq(0)").html(num);
            conFocus = "M2";
            xsEffect();
        } else if (conFocus == "M2") {
            $(".xs-time>ul>li:eq(1)>span:eq(1)").html(num);
            conFocus = "S1";
            xsEffect();
        } else if (conFocus == "S1") {
            if (num >= 6) {
                num = 5;
            }
            $(".xs-time>ul>li:eq(2)>span:eq(0)").html(num);
            conFocus = "S2";
            xsEffect();
        } else if (conFocus == "S2") {
            $(".xs-time>ul>li:eq(2)>span:eq(1)").html(num);
        }
    }

    function eventHandle(keyCode) {
        switch (keyCode) {
            case Action.KEY.UP:
                if (Action.focusPos == "PLAY") {
                    CHS.video.pause();
                    showProgress();
                    getProgress();
                }
                break;
            case Action.KEY.DOWN:
                if (Action.focusPos == "PLAY") {
                    //window.history.go(-1);
                }
                break;
            case Action.KEY.LEFT:
                if (Action.focusPos == "PLAY") {
                    CHS.video.backward();
                    showProgress();
                    getProgress();
                } else if (Action.focusPos == "CON") {
                    if (conFocus == "S2") {
                        conFocus = "S1";
                    } else if (conFocus == "S1") {
                        conFocus = "M2";
                    } else if (conFocus == "M2") {
                        conFocus = "M1";
                    } else if (conFocus == "M1") {
                        conFocus = "H2";
                    } else if (conFocus == "H2") {
                        conFocus = "H1";
                    }
                    xsEffect();
                }
                break;
            case Action.KEY.RIGHT:
                if (Action.focusPos == "PLAY") {
                    CHS.video.forward();
                    showProgress();
                    getProgress();
                } else if (Action.focusPos == "CON") {
                    if (conFocus == "H1") {
                        conFocus = "H2";
                    } else if (conFocus == "H2") {
                        conFocus = "M1";
                    } else if (conFocus == "M1") {
                        conFocus = "M2";
                    } else if (conFocus == "M2") {
                        conFocus = "S1";
                    } else if (conFocus == "S1") {
                        conFocus = "S2";
                    }
                    xsEffect();
                }
                break;
            case Action.KEY.INFO:
                Action.focusPos = "CON";
                conFocus = "INFO";
                conEffect();
                break;
            case Action.KEY.F1:
                Action.focusPos = "CON";
                conFocus = "HELP";
                conEffect();
                break;
            case Action.KEY.F2:
                Action.focusPos = "CON";
                conFocus = "XUANSHI";
                conEffect();
                break;
            case Action.KEY.NUMBER0:
                if (Action.focusPos == "CON") {
                    setTimeNum(0);
                }
                break;
            case Action.KEY.NUMBER1:
                if (Action.focusPos == "CON") {
                    setTimeNum(1);
                }
                break;
            case Action.KEY.NUMBER2:
                if (Action.focusPos == "CON") {
                    setTimeNum(2);
                }
                break;
            case Action.KEY.NUMBER3:
                if (Action.focusPos == "CON") {
                    setTimeNum(3);
                }
                break;
            case Action.KEY.NUMBER4:
                if (Action.focusPos == "CON") {
                    setTimeNum(4);
                }
                break;
            case Action.KEY.NUMBER5:
                if (Action.focusPos == "CON") {
                    setTimeNum(5);
                }
                break;
            case Action.KEY.NUMBER6:
                if (Action.focusPos == "CON") {
                    setTimeNum(6);
                }
                break;
            case Action.KEY.NUMBER7:
                if (Action.focusPos == "CON") {
                    setTimeNum(7);
                }
                break;
            case Action.KEY.NUMBER8:
                if (Action.focusPos == "CON") {
                    setTimeNum(8);
                }
                break;
            case Action.KEY.NUMBER9:
                if (Action.focusPos == "CON") {
                    setTimeNum(9);
                }
                break;
            case Action.KEY.ENTER:
                if (Action.focusPos == "PLAY") {
                    CHS.video.play();
                    showProgress();
                    getProgress();
                } else if (Action.focusPos == "CON") {
                    if (conFocus == "H1" || conFocus == "H2" || conFocus == "M1" || conFocus == "M2" || conFocus == "S1" || conFocus == "S2") {
                        var h1 = $(".xs-time>ul>li:eq(0)>span:eq(0)").html();
                        var h2 = $(".xs-time>ul>li:eq(0)>span:eq(1)").html();
                        var m1 = $(".xs-time>ul>li:eq(1)>span:eq(0)").html();
                        var m2 = $(".xs-time>ul>li:eq(1)>span:eq(1)").html();
                        var s1 = $(".xs-time>ul>li:eq(2)>span:eq(0)").html();
                        var s2 = $(".xs-time>ul>li:eq(2)>span:eq(1)").html();
                        var tt = "" + h1 + h2 + m1 + m2 + s1 + s2;
                        if (tt > $("#xs-durTime").html()) {
                            $(".errorTip").css("display", "block");
                        } else {
                            var pos = ((parseInt(h1) * 10 + parseInt(h2)) * 3600 + (parseInt(m1) * 10 + parseInt(m2)) * 60 + (parseInt(s1) * 10 + parseInt(s2)) * 1) * 1000;
                            Action.focusPos = "PLAY";
                            $(".con-container").css("display", "none");
                            showProgress();
                            getProgress();
                            CHS.video.playPos(pos);
                        }
                    }
                }
                break;
            case Action.KEY.BACK:
            case Action.KEY.EXIT:
                if (Action.focusPos == "CON") {
                    Action.focusPos = "PLAY";
                    $(".con-container").css("display", "none");
                } else {
                    Action.goBack();
                }
                event.preventDefault();
                break;
        }
    }

    $(document).ready(function () {
        Action.focusPos = "PLAY";
        showVideoTip();
        initPage();
    });
</script>
</body>
</html>

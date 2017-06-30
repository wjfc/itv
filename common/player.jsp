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
    <%-- 机顶盒流控，用720*576（标清） --%>
    <meta http-equiv="Content-Type" content="1280*720;text/html; charset=UTF-8">
    <title>CHS播放器</title>
    <link type="text/css" href="../css/common.css" rel="stylesheet">
    <style type="text/css">
        body {
            background-color: transparent;
            color: #ffffff;
        }

    </style>
</head>
<body onunload="">
<%@ include file="commonJS.jsp" %>
<script type="text/javascript" src="../js/stb.js"></script>
<script type="text/javascript">

    var movieInfo = {};
    var clientId = CHS.STB.getStbNo();

    var mpeg_opened = false;
    var vod = new VODControl();
    var setResumeFlag=true;
    var queryErrorTime=null;
    var autoPriceTimer=null;
    var queryPriceFlag=true;          //是否询价 默认 true
    var offerId="1000";               //询价offerID 默认1000
    var resumePoint=0;

    function initPage() {
        getMovieInfo();
    }

    function getMovieInfo() { //  文广 凤凰专区  和央视的专区的 请求地址有点不一样
        var url = "../movie/detail.do?categoryId=${param.categoryId}&assetId=${param.assetId}";
        Action.callGetServiceError(url, function (data) {
            movieInfo = data;
            //首先获取续看点

            getResumePoint();
        }, function () {
            Action.goBack();
        }, false);
    }


    function mpeg_open() {
        if (!mpeg_opened) {
            vod.Install();
            mpeg_opened = true;
        }
        return true;
    }

    function mpeg_close() {
        if (!mpeg_opened) {
            vod.GiveUp();
            mpeg_opened = false;
        }
        return true;
    }


    function mpeg_write(ioctl, value) {
        var result;
        if (mpeg_opened) {
            return vod.SetUp(ioctl, value);
        } else {
            alert('[mpeg_write]Please open device first !');
        }
    }

    function mpeg_read(ioctl) {
        var result;
        if (mpeg_opened) {
            return vod.Get(ioctl);
        } else {
            alert('[mpeg_read]Please open device first !');
        }
    }

    /*停止视频，关闭视频窗口*/
    function destroyWindow() {
        mpeg_open();
        mpeg_write('CableMPEGClose', ' ');
        mpeg_write('CableMpegWindowDestory', '');
        mpeg_write('JseBrowserControl', 'status:1');
    }

    /**
     * 获得续看点 如果没有续看点 则从零开始播
     * 如果首次播放 则插入续看记录（此功能 在后台代码处理）
     * */
    function getResumePoint() {
        var url = "../confirmMessage/getResumePoint.do?assetId=" + movieInfo.assetId + "&stbNo=" + clientId + "&videoType=" + movieInfo.videoType + "&categoryId=" + movieInfo.categoryId;
        Action.callGetServiceError(url, function (data) {
            if (data.code == "0") {
                var remetime = data.resumePoint;
                offerId=data.offerId;
                if (remetime == undefined || remetime == "") {
                    resumePoint = 0;
                } else
                    resumePoint = parseInt(remetime);
            }
            //先播放，播放之后在进行询价鉴权
            var playAssetid = toHexStr(movieInfo.assetId) + ":normal";
            mpeg_open();
            mpeg_write('CableTVWindowDestory', '');
            destroyWindow();
            Play(playAssetid, resumePoint, movieInfo.title);

            autoPriceTimer=setTimeout(function(){
                queryPriceAuth();
            },6000);
        }, function () {
            //如果请求异常，允许播放
            Play(playAssetid, 0, movieInfo.title);
        }, false);
    }

    function Play(curPlayURL, pos, CalbleAssetNAME) {
        mpeg_open();
        var curState = mpeg_read('CableMPEGState');
        mpeg_write('printf', 'CableMPEGState=' + curState + '\n');
        if (curState == 0) {
            if (curPlayURL != '' && curPlayURL != ' ') {
                mpeg_write('SetupServerIPFile', curPlayURL);
                curState = mpeg_read('CableMPEGState');
                if (curState == 1) {
                    if (CalbleAssetNAME != undefined && CalbleAssetNAME != '') {
                        mpeg_write('CableMPEGName', CalbleAssetNAME);
                    }
                    if (pos == 0) {
                        mpeg_write('CableMPEGPlay', ' ');
                    } else {
                        mpeg_write('CableMPEGPlay', pos);
                    }
                    curState = mpeg_read('CableMPEGState');
                    if (curState != 2) {
                        mpeg_write('printf', 'play failed\n');
                    } else {
                        mpeg_write('JseBrowserControl', 'status:0');
                    }
                } else {
                    mpeg_write('printf', 'SetupServerIPFile failed\n');
                }
            }
        } else {
            if (curState != 2) {
                mpeg_write('printf', 'play\n');
                mpeg_write('CableMPEGPlay', ' ');
                mpeg_write('JseBrowserControl', 'status:0');
                curState = 3;
            } else {
                mpeg_write('printf', 'pause\n');
                Pause();
            }
        }
        mpeg_close();
    }

    //询价鉴权
    function queryPriceAuth() {
        var url = "../confirmMessage/queryPriceAuth.do?assetId=" + movieInfo.assetId + "&stbNo=" + clientId + "&videoType=movie"+"&offerId="+offerId;
        Action.callGetServiceError(url, function (data){
            if(data.errorcode == 0 || data.errorcode == "0"){
                //返回0 代表允许播放
            }else {
                //鉴权不通过 退出
                //showVideoTip(Constant.queryPriceTitle,Constant.queryPriceContent);
                mpeg_open();
                mpeg_write('CableTVWindowDestory', '');
                destroyWindow();
                queryErrorTime=setTimeout(function(){
                    queryPriceFlag=false;
                    queryErrorFunc();
                },1800);
            }
            clearTimeout(autoPriceTimer);
        },function(){
            //如果请求异常，允许播放
            //showVideoTip("友情提示","网络连接失败");
        },true);
    }

    function queryErrorFunc(){
        clearTimeout(queryErrorTime);
        Action.goBack();
    }


    /**
     * 设置续看点 单位毫秒；
     * @param resumeNum
     */
    function setResumePoint(playPos) {
        if(setResumeFlag){
            setResumeFlag=false;
            var url = "../confirmMessage/setResumePoint.do?stbNo=" + clientId + "&assetId=" + movieInfo.assetId + "&resumePointNum=" + playPos;
            Action.callGetServiceError(url, function (data) {
                /*var backUrl=getCookie("sitvPlayer");
                Action.chsLog(" backUrl="+backUrl);
                if(backUrl!=""){
                    window.location.href="../sitv/rainBowChildSchoolList.do?menuType=lxzw";
                }else*/
                window.location.href=document.referrer;
            }, function () {
                window.location.href=document.referrer;
            }, true);
        }
    }

    function getPlayPos() {
        mpeg_open();
        var stopposition = mpeg_read('CableMPEGPos');
        mpeg_write('CableMPEGClose', ' ');
        mpeg_write('JseBrowserControl', 'status:1');
        mpeg_close();
        return stopposition;
    }

    function eventHandle(keyCode) {
        event.preventDefault();
        switch (keyCode) {
            case 80:
            //无锡后退键(流控后退）
            case 65:
            //苏州返回键（流控返回）
            case 48:
                //苏州盒子需要手动关流
                destroyWindow();
                var pos = getPlayPos();
                setResumePoint(pos);
                break;
            //无锡播放完成（流控播放完成）
            case 32:
            case 43:
                setResumePoint(1);
                break;
            //返回
            case 8:
            //退出
            case 114:
                //window.history.go(-1);
                break;
        }
    }


    $(document).ready(function () {
        initPage();
    });
</script>
</body>
</html>

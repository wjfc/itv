<%--
  Created by IntelliJ IDEA.
  User: Litao
  Date: 2016/11/28
  Time: 10:03
  To change this template use File | Settings | File Templates.
  能力接口 播放器
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html>
<head>
  <meta http-equiv="Content-Type" content="1280*720; text/html; charset=UTF-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <title>CHS播放器--能力专用</title>
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
      /*width: 380px;*/
      width: 0px;
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
      margin-left: 580px;
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

    .on{
      display: block;
    }
  </style>
</head>
<body onunload="closePageAndPlay()">
<!-- 静音标示 -->
<div class="icon-mute" ></div>

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
    <div class="durTime">00:00:00</div>

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
  <div class="volume-num">0</div>
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
      <div class="xs-title"><span id="xs-title"></span> 00:00:00 - <span id="xs-durTime">00:00:00</span> <span class="errorTip">输入有误，请重新输入</span></div>
      <div class="xs-time">
        <ul>
          <li>
            <span>0</span>
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
      <div class="actors">演员：</div>
      <div class="directors">导演：</div>
      <div class="description">剧情简介：</div>
    </li>
  </ul>
</div>

<%@ include file="commonJS.jsp" %>
<script type="text/javascript" src="../js/Vodcontrol.js"></script>
<script type="text/javascript">
  //进度条总长度
  var PROGRESSWIDTH = 380;
  //音量条总长度
  var VOLUMEWIDTH = 580;
  var movieAssetid;                 //影片assetid
  var movieName;                    //影片 名称
  var movieInfo = {};               //影片信息对象
  var queryPriceFlag=true;          //是否询价 默认 true
  var clientId=getStbNo();        //获取盒子号
  var resumePoint="${resumePoint}"==null?"0":"${resumePoint}";                //续看点  默认0
  var setResumeFlag=true;           //控制设置续看点   防止设置两次
  var currentTime = 0,totalTime = 0,realCurrentTime_Hour = 0,realCurrentTime_min = 0,realCurrentTime_sec = 0,realTotalTime_Hour = 0,realTotalTime_min = 0,realTotalTime_sec = 0;
  var speedArray = [-33,-9,1,9,33], nowSpeed = 1, preSpeed = 0;
  var spos = 2;
  var isDragOpeartion = false;	    //是否是拖动操作
  var DragOpearStart = false;       //是否开始拖动
  var isOperTimeout = false;		//拖动失效
  var isFast = false;				//当前是否为快进或快退状态
  var isOpearter=false;             //当前是否在操作；默认不操作
  var statusNum=0;                  //播放状态
  var dragTimer;				    //拖动定时器
  var autoPower=null;
  var isInquire="${parameBean.playType}"==null?"0":"${parameBean.playType}";   //是否询价  0 不询价  1 询价
  var movieType="${parameBean.movieType}";
  Utility.ioctlWrite("JsAddKeyState","N");	//将键值转化为moto的键值

  function initPage(){
    showVideoTip();
    Action.chsLog("cateId=${categoryId} , assid= ${assetId}");
    Action.chsLog("cateId=${param.categoryId} , assid= ${param.assetId}");
    getMovieInfo();
    /*movieInfo.assetId="${param.assetId}";
     movieInfo.title="${param.moviename}";
     play_video();*/
  }

  function getMovieInfo() {
    var url = "../movie/detail.do?categoryId=${categoryId}&assetId=${assetId}";
    Action.callGetServiceError(url, function (data) {
      if(data!=null&&data!=""){
        movieInfo = data;
        //首先获取续看点
        getResumePoint();
      }else{
        showVideoTip("友情提示","该节目已过期,详情联系96296");
        setTimeout(function(){Action.goBack();},3000);
      }
    },function(){
      showVideoTip("友情提示","该节目已过期,详情联系96296");
      setTimeout(function(){Action.goBack();},3000);
    },false);
  }

  /**
   * 获得续看点 如果没有续看点 则从零开始播
   * 如果首次播放 则插入续看记录（此功能 在后台代码处理）
   * */
  function getResumePoint(){
    var url = "../confirmMessage/onlyInquiry.do?assetId=" + movieInfo.movassetid + "&stbNo=" + clientId + "&videoType=10000&categoryId="+movieInfo.category_id+"&isInquiry="+isInquire+"&movieType="+movieType;
    Action.callGetServiceError(url, function (data){
        if(data.code == "0"){
            //Action.chsLog(data.code);
            if(isInquire=="1"){
              //显示询价页
            }else{

            }

            //先播放，播放五秒之后在进行询价鉴权
            autoPower=setTimeout(function(){
              autoPower_F(movieInfo.movassetid,clientId,data.offerId);
            },5000);
        }
         play_video();
        //queryPriceAuth();
    },function(){
      //如果请求异常，允许播放
      //play_video();
    },false);
    //先播放，播放之后在进行询价鉴权
    Action.chsLog(" play assetId="+movieInfo.movassetid);
    play_video();
  }

  function autoPower_F(movassetid,client_id,offerId){
    if(offerId=="0"){
      offerId="1000";
    }
    var url="../confirmMessage/getAutoPower.do?assetId=" + movassetid + "&stbNo=" + client_id+"&offerId="+offerId;
    Action.callGetServiceError(url,
            function (data){
              if(data.code=="0"){
                if(data.isAuto=="Y"){
                  //鉴权通过
                }else{
                  //鉴权不通过
                }
              }else{
                //鉴权失败
              }
            },
            function (){
              //鉴权异常
            },false
    );

    if (autoPower != null) {
      clearTimeout(autoPower);
      autoPower = null;
    }
  }

  var initVodTimer=null;
  var playWindow=null;
  function play_video(){
    movieAssetid=toHexStr(movieInfo.movassetid) + ":normal";
    movieName=movieInfo.movieName;
    /*if(movieInfo.assetId=="2016082605590301STV3"){
     movieAssetid=toHexStr("2016082605590301STV31") + ":normal";
     }
     if(movieInfo.assetId=="2016082505589597STV3"){
     movieAssetid=toHexStr("11261791") + ":normal";
     movieName="谍影重重";
     movieInfo.title="谍影重重";
     }*/
    vodFullPlay(movieAssetid,movieName,resumePoint,"","");
    //获取cep推荐数据
    initVodTimer=setTimeout(function(){
      initVodPage();
    },600);

  }
  var progressStartTimer=null;
  /**
   *  此方法 可以为了以后加载广告用
   *  暂时没有用到
   **/
  function initVodPage(){
    mpeg_open();
    var curState=mpeg_read('CableMPEGState');
    mpeg_close();
    if(curState!=2){
      initVodTimer=setTimeout("initVodPage()", 1000);
      return;
    }
    statusNum=curState;
    if (initVodTimer != null) {
      clearTimeout(initVodTimer);
      initVodTimer = null;
    }

    //显示影片信息
    movieInfoShow();
    if(movieName.length>16){
      $("#xs-title").innerHTML = movieName.substring(0,16) +"..";
    } else {
      $("program_name2").innerHTML = movieName;
    }
    //隐藏提示框
    hiddenVideoTip();
    Utility.setEnv("moto_assetid", movieInfo.assetId);
    Utility.setEnv("SmartAssociationUrl", "");
    $(".curTime").html("00:00:00");
    //页面是否使用同洲浏览器来进行静音图标的控制,true表示是
    Utility.setBrwMuteLogo(false);
    mp.setSingleMedia("");   //将播放模式设为静帧模式
    //初始化音量
    initSound();
    //设置滚动条
    //setProgress();
    isOpearter=true;
    //设置1000毫秒之后才开始刷新时间，主要是为了防止文广视频 前两秒出现问题
    progressStartTimer = setTimeout(function () {
      mainTimer=setInterval('setProgress()',1000);
      //显示当前播放状态
      statusShow();
      //显示刚状态框 和滚动框
      if(isOpearter){
        showPlayWindow();
      }
      clearTimeout(progressStartTimer);
      progressStartTimer=null;
    }, 1000);
  }

  function getPlayStatue(){
    mpeg_open();
    var curState=mpeg_read('CableMPEGState');
    mpeg_close();
    return curState;
  }

  //设置进度条上的滚动长度、当前播放时间  显示播放状态
  var mainTimer = null;
  var currPlayPoint=0;
  function setProgress(){
    if(!totalTime || totalTime == 0){
      //获取节目总时间(天柏的盒子不一定能及时获取到总时长)
      totalTime = getTotalTime();
      //总时长
      $(".durTime").html(secToTimeStr(totalTime));
      //选时总时长显示
      $("#xs-durTime").html(secToTimeStr(totalTime));
    }

    if(isDragOpeartion){//正在拖动
      currentTime += nowSpeed;
    }else{
      currentTime = getCurrentTime();
    }
    if(isDragOpeartion && currentTime > totalTime){
      currentTime = totalTime;
    }

    if(currentTime > totalTime){
      currentTime = totalTime;
    }
    currentTime = currentTime > 0 ? currentTime : 0;
    realCurrentTime_Hour = addZero(parseInt(currentTime/3600));
    realCurrentTime_min = addZero(parseInt((currentTime%3600)/60));
    realCurrentTime_sec = addZero(parseInt(currentTime%60));
    realTotalTime_Hour = addZero(parseInt(totalTime/3600));
    realTotalTime_min = addZero(parseInt((totalTime%3600)/60));
    realTotalTime_sec = addZero(parseInt(totalTime%60));

    $(".progress-bar").css("width", parseInt((currentTime/totalTime)*PROGRESSWIDTH) +"px");
    $(".curTime").html(realCurrentTime_Hour+":"+realCurrentTime_min+":"+realCurrentTime_sec);

    if(currentTime>=totalTime){
      currPlayPoint=1;
    }else{
      currPlayPoint=currentTime*1000;
    }

    /*if (mainTimer != null) {
     clearTimeout(mainTimer);
     mainTimer = null;
     }*/
  }

  function movieInfoShow() {
    $(".c-movieName").html(movieInfo.title);
    $(".actors").html("演员：" + movieInfo.actors);
    $(".directors").html("导演：" + movieInfo.director);
    $(".description").html("剧情简介：" + movieInfo.shortDesc);
  }


  function showPlayWindow(){
    $(".controls-bar").addClass("on");
    //控制台可以隐藏  六秒后隐藏 播控条
    if(isOpearter){
      playWindow=setTimeout(function(){
        hiddenPlayWindow();
      },6000);
    }
  }

  function hiddenPlayWindow(){
    if(statusNum==2){
      $(".controls-bar").removeClass("on");
    }
    if (playWindow != null) {
      clearTimeout(playWindow);
      playWindow = null;
    }
    isOpearter=false;
  }

  //状态显示
  function statusShow(status) {
    if(status==undefined||status==null||status==""){
      mpeg_open();
      status=mpeg_read('CableMPEGState');
      mpeg_close();
    }
    $(".c-icons>li").css("visibility", "hidden");
    if (status == 0) {
      $(".c-icons>li.c-stop").css("visibility", "visible");
      $(".c-statusText").html("准备");
    } else if (status == 2) {
      //hideVideoTip();
      $(".c-icons>li.c-play").css("visibility", "visible");
      $(".c-statusText").html("播放");
    } else if (status == 3) {
      //hideVideoTip();
      $(".c-icons>li.c-pause").css("visibility", "visible");
      $(".c-statusText").html("暂停");
    } else if (status == 4) {
      //hideVideoTip();
      if (nowSpeed > 1) {
        $(".c-icons>li.c-forward").css("visibility", "visible");
        $(".c-statusText").html("快进&nbsp;" + nowSpeed +"倍");
      } else if (nowSpeed < 0) {
        $(".c-icons>li.c-backward").css("visibility", "visible");
        $(".c-statusText").html("快退&nbsp;"+ nowSpeed+"倍");
      }
    }
  }

  /**
   * 设置提示框 提示内容
   */
  function showVideoTip(title, content){
    if(title==null||title==""||content==null||content==""){
    }else{
      $(".tip-title").html(title);
      $(".tip-content").html(content);
    }
    $(".video-tip").addClass("on");
  }

  function hiddenVideoTip(){
    $(".video-tip").removeClass("on");
  }

  function ForwardBackOperaion(opear){
    /* if(DragOpearStart && !isFast) {
     isOperTimeout = true;
     isDragOpeartion = true;
     }*/

    nowSpeed=speedArray[spos];
    statusShow(statusNum);
    if (playWindow != null) {
      clearTimeout(playWindow);
      playWindow = null;
    }
    isFast=true;
    if(opear=="left"){
      fastBackward(nowSpeed);
    }else if(opear=="right"){
      fastForward(nowSpeed);
    }
    if(mainTimer==null){
      mainTimer=setInterval('setProgress()',1000);
    }
    isOpearter=false;
    $(".controls-bar").addClass("on");
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

  var setProcessTimerOne=null;
  function setProcessTimer(){
    setProcessTimerOne=setTimeout(function(){
      setProgress();
      clearTimeout(setProcessTimerOne);
      setProcessTimerOne=null;
    },300)
  }

  function disAppearNew(){
    isOpearter=false;
    $(".controls-bar").removeClass("on");
    if (playWindow != null) {
      clearTimeout(playWindow);
      playWindow = null;
    }
  }

  function eventHandle(keyCode) {
    switch (keyCode) {
      case Action.KEY.UP:
        if (Action.focusPos == "PLAY") {
          clearAllTimer();
          mp.setSingleMedia("");   //将播放模式设为静帧模式
          Pause();
          statusNum=3;
          statusShow(statusNum);
          isOpearter=false;
          setProcessTimer();
          $(".controls-bar").addClass("on");
        } else if (Action.focusPos == "CON") {
          if (conFocus == "H1" || conFocus == "H2" || conFocus == "M1" || conFocus == "M2" || conFocus == "S1" || conFocus == "S2") {
            conFocus = "XUANSHI";
            /*conEffect();
             xsEffect();*/
          }
        }
        break;
      case Action.KEY.DOWN:
        if (Action.focusPos == "PLAY") {
          setResumePoint(currPlayPoint);
          //window.history.go(-1);
        } else if (Action.focusPos == "CON") {
          if (conFocus == "XUANSHI") {
            conFocus = "H1";
            xsEffect();
          }
        }
        break;
      case Action.KEY.LEFT:
        if (Action.focusPos == "PLAY") {
          dragOpearFast("left");
        } else if (Action.focusPos == "CON") {
          if (conFocus == "XUANSHI") {
            conFocus = "HELP";
            conEffect();
          } else if (conFocus == "INFO") {
            conFocus = "XUANSHI";
            conEffect();
            conFocus = "H1";
            xsEffect();
          } else if (conFocus == "S2") {
            conFocus = "S1";
            xsEffect();
          } else if (conFocus == "S1") {
            conFocus = "M2";
            xsEffect();
          } else if (conFocus == "M2") {
            conFocus = "M1";
            xsEffect();
          } else if (conFocus == "M1") {
            conFocus = "H2";
            xsEffect();
          } else if (conFocus == "H2") {
            conFocus = "H1";
            xsEffect();
          }
        }
        break;
      case Action.KEY.RIGHT:
        if (Action.focusPos == "PLAY") {
          dragOpearFast("right");
        } else if (Action.focusPos == "CON") {
          if (conFocus == "HELP") {
            conFocus = "XUANSHI";
            conEffect();
            conFocus = "H1";
            xsEffect();
          } else if (conFocus == "XUANSHI") {
            conFocus = "INFO";
            conEffect();
          } else if (conFocus == "H1") {
            conFocus = "H2";
            xsEffect();
          } else if (conFocus == "H2") {
            conFocus = "M1";
            xsEffect();
          } else if (conFocus == "M1") {
            conFocus = "M2";
            xsEffect();
          } else if (conFocus == "M2") {
            conFocus = "S1";
            xsEffect();
          } else if (conFocus == "S1") {
            conFocus = "S2";
            xsEffect();
          }
        }
        break;
      case Action.KEY.PAGEUP: //快退
        if (Action.focusPos == "PLAY") {
          statusNum=4;
          if(spos>0){spos--;}
          if(spos>=2){
            spos=1;
          }
          //快退
          ForwardBackOperaion("left");
        }
        break;
      case Action.KEY.PAGEDOWN: //快进
        if (Action.focusPos == "PLAY") {
          statusNum=4;
          if(spos<4){
            spos++;
          }
          if(spos<=2){
            spos=3;
          }
          //快进
          ForwardBackOperaion("right");
        }
        break;
      case Action.KEY.VOLUMNUP:
        event.preventDefault();
        clearTimeout(volumeTimer);
        disAppearNew();
        volumeOperate(1);
        showVolumeConsole();
        volumeTimer = setTimeout("hideVolumeConsole()", 5000);
        break;
      case Action.KEY.VOLUMNDOWN:
        event.preventDefault();
        clearTimeout(volumeTimer);
        disAppearNew();	//隐藏控制台
        volumeOperate(-1);
        showVolumeConsole();
        volumeTimer = setTimeout("hideVolumeConsole()", 5000);
        break;
      case Action.KEY.VOLUMNNO:
        event.preventDefault();
        setMute();
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
        conFocus = "H1";
        xsEffect();
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
          if (statusNum == 2) {
            clearAllTimer();
            mp.setSingleMedia("");   //将播放模式设为静帧模式
            Pause();
            statusNum=3;
            statusShow(statusNum);
            isOpearter=false;
            setProcessTimer();
            $(".controls-bar").addClass("on");
            //mainTimer=setInterval('setProgress()',1000);
          } else {

            recovePlay();
            spos=2;
            nowSpeed=1;
            statusNum=2;
            isFast=false;
            statusShow(statusNum);
            isOpearter=true;
            showPlayWindow();
            if(mainTimer==null){
              mainTimer=setInterval('setProgress()',1000);
            }

          }
        } else if (Action.focusPos == "CON") {
          if (conFocus == "H1" || conFocus == "H2" || conFocus == "M1" || conFocus == "M2" || conFocus == "S1" || conFocus == "S2") {
            var h1 = $(".xs-time>ul>li:eq(0)>span:eq(0)").html();
            var h2 = $(".xs-time>ul>li:eq(0)>span:eq(1)").html();
            var m1 = $(".xs-time>ul>li:eq(1)>span:eq(0)").html();
            var m2 = $(".xs-time>ul>li:eq(1)>span:eq(1)").html();
            var s1 = $(".xs-time>ul>li:eq(2)>span:eq(0)").html();
            var s2 = $(".xs-time>ul>li:eq(2)>span:eq(1)").html();
            var tt = (parseInt(h1)*10+parseInt(h2))*3600 + (parseInt(m1)*10+parseInt(m2))*60 + parseInt(s1)*10 + parseInt(s2);
            if (tt > getTotalTime()) {
              $(".errorTip").css("display", "block");
            } else {
              /*var pos = ((parseInt(h1) * 10 + parseInt(h2)) * 3600 + (parseInt(m1) * 10 + parseInt(m2)) * 60 + (parseInt(s1) * 10 + parseInt(s2)) * 1) * 1000;*/
              var pos = (parseInt(h1) * 10 + parseInt(h2)) * 3600 + (parseInt(m1) * 10 + parseInt(m2)) * 60 + (parseInt(s1) * 10 + parseInt(s2)) * 1;
              Action.focusPos = "PLAY";
              $(".con-container").css("display", "none");
              //CHS.video.playPos(pos);       //无锡天柏盒子不支持此方法
              /*if(pos>=1000){
               pos=pos/1000;
               }*/
              spos=2;
              nowSpeed=1;
              statusNum=2;
              statusShow(statusNum);
              if (playWindow != null) {
                clearTimeout(playWindow);
                playWindow = null;
              }
              isOpearter=true;
              if(mainTimer==null){
                mainTimer=setInterval('setProgress()',1000);
              }
              showPlayWindow();
              playControl("play",0,pos);
            }
          }
        }
        break;
      case Action.KEY.BACK:
        event.preventDefault();
        if(queryPriceFlag){
          if (Action.focusPos == "CON") {
            Action.focusPos = "PLAY";
            $(".con-container").css("display", "none");
          } else {
            setResumePoint(currPlayPoint);
            //window.history.go(-1);
          }
        }
        break;

      case Action.KEY.EXIT:
        event.preventDefault();
        if(queryPriceFlag){
          if (Action.focusPos == "CON") {
            Action.focusPos = "PLAY";
            $(".con-container").css("display", "none");
          } else {
            // 设置续看点
            setResumePoint(currPlayPoint);
          }
        }
        break;
      case Action.KEY.VODEND:
      case Action.KEY.END:
        event.preventDefault();
        setResumePoint(1);  //视频播放完成 传1   下次播放 重新开始播
        //window.history.go(-1);
        break;
        /*case 768:  //TVOS 视频播放完成出发
         event.preventDefault();
         setResumePoint(1);  //视频播放完成 传1   下次播放 重新开始播*/
        break;
      case Action.KEY.STOPPOINT:
      case Action.KEY.STOP:
        event.preventDefault();
        setResumePoint(currPlayPoint);
        break;
      case 0x71:	//菜单键
        event.preventDefault();
      default:
        commonEventHandle(keyCode);   //其他报错代码
        break;
    }
  }

  document.onkeyup = grabUpEvent;
  function grabUpEvent(){
    var keycode = event.keyCode || event.which;
    isDragOpeartion = false;
    DragOpearStart = false;
    clearInterval(dragTimer);//清除拖动定时器
    switch (keycode){
      case Action.KEY.LEFT:
        if(!isOperTimeout) {
          if (Action.focusPos == "PLAY") {
            statusNum = 4;
            if (spos > 0) {
              spos--;
            }
            if(spos>=2){
              spos=1;
            }
            //快退
            ForwardBackOperaion("left");
          }
        }else{//拖动结束，重新设置控制台
          statusNum=2;
          spos=2
          nowSpeed=speedArray[spos];
          isFast=false;
          //recovePlay();
          playControl("play",0,currentTime);
          statusShow(statusNum);
          isOpearter=true;
          showPlayWindow();
        }
        break;
      case Action.KEY.RIGHT:
        if(!isOperTimeout){
          if (Action.focusPos == "PLAY") {
            statusNum=4;
            if(spos<4){
              spos++;
            }
            if(spos<=2){
              spos=3;
            }
            //快进
            ForwardBackOperaion("right");
          }
        }else{//拖动结束，重新设置控制台
          statusNum=2;
          spos=2
          nowSpeed=speedArray[spos];
          isFast=false;
          //recovePlay();
          playControl("play",0,currentTime);
          statusShow(statusNum);
          isOpearter=true;
          showPlayWindow();
        }
        break;
      default :
        event.preventDefault();
        break;
    }
  }
  //进度条拖动操作
  function dragOpearFast(derc){
    isOpearter=false; //设置控制台不可隐藏
    $(".controls-bar").addClass("on");
    if(!DragOpearStart){
      //不是快进快退状态
      DragOpearStart=true;
      isOperTimeout = false;
      if(derc=="left"){
        dragTimer = setInterval("DragOpear('left')", 2000);
      }else{
        dragTimer = setInterval("DragOpear('right')", 2000);
      }
      //statusNum=4;
    }
  }

  function DragOpear(derc){
    isOperTimeout = true;
    isDragOpeartion = true;
    if(isDragOpeartion&&!isFast) {
      if (derc == "left") {
        spos = spos - 1;
        if (spos > 1) {
          spos = 1;
        } else if (spos < 0) {
          spos = 0;
        }
        nowSpeed = -totalTime / 20;
      } else {
        spos = spos + 1;
        if (spos < 3) {
          spos = 3;
        } else if (spos > (speedArray.length - 1)) {
          spos = speedArray.length - 1;
        }
        nowSpeed = totalTime / 20;
      }
      if (nowSpeed == 1) {
        playControl("resume", 0, 0);
      } else {
        playControl("forward", nowSpeed, 0);
      }
    }
  }

  var msgstr="";
  var msgTitle="友情提示";
  //document.onirkeypress = errorEventHandle;
  /*  document.onkeyup = errorEventHandle;
   document.onkeypress = errorEventHandle;*/
  document.onirkeypress = errorEventHandle;
  document.onsystemevent = errorEventHandle;
  function errorEventHandle(e){
    commonEventHandle(event.keyCode);
  }
  function commonEventHandle(keycode){
    //Action.chsLog(keycode);
    switch (keycode){
      case 5551:
      case 8002:
      case 45015: // 信号线
        msgstr = "信号线脱落，将自动退出<br/>服务代码0x9051<br/>机顶盒代码 "+keycode;
        showVideoTip("友情提示",msgstr);
        sigalErrorTimer = setTimeout(function(){
          clearTimeout(sigalErrorTimer);
          window.history.go(-1);
          sigalErrorTimer=null;
        },3000);
        break;
      case 65535:
        playControl("stop",0,0);//停止播放
        Utility.ioctlRead("Standby");		//待机
        break;
      /*case 5242:
       msgstr = "节目已过期，请点播其他节目<br/>服务代码：0x9100";	//首页
       showVideoTip(msgTitle,msgstr);
       break;*/
      //case 5501:
      case 12056:
      case 45003:   //应用报0x9052的错误
        msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x9052";
        showVideoTip(msgTitle,msgStr);
        break;
      case 45004:
        msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x5004";
        showVideoTip(msgTitle,msgstr);
        break;
      case 45006:
        //msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x5004";
        msgstr = "锁频信号丢失，请检查信号线";
        showVideoTip(msgTitle,msgstr);
        break;
      case 5209:
      case 45783:
      case 45011:
      case 0x2A:
        msgstr = "快退到节目头，将转为播放状态";
        showVideoTip("友情提示",msgstr);
        spos=2;
        statusNum=2;
        nowSpeed=1;
        sigalErrorTimer = setTimeout(function(){
          clearTimeout(sigalErrorTimer);
          hiddenVideoTip();
          sigalErrorTimer=null;
        },1500);
        break;
      case 5210:
      case 45012:
      case 0x2B:
        msgstr = "节目播放结束，即将退出";
        showVideoTip("友情提示",msgstr);
        break;
      case 5550:
      case 45016: // 恢复信号线
        break;
      case 5242:
      case 45017:
        var secondMsg;
        var messageId = event.userInt;
        var evtstr = DVB.getEvent(45017, messageId);
        var infoObj = eval('('+evtstr+')');
        var fristMsg  = infoObj.SubMsgFi;
        var secondMsg = infoObj.SubMsgSe;
        /*if(window.navigator.userAgent.indexOf("DVNBrowser") >= 0){
         secondMsg =event.modifiers;
         }*/
        if(typeof(iPanel)!='undefined'){
          secondMsg = messageId;
        }
        //Action.chsLog("messageId="+messageId+"   secondMsg"+secondMsg);
        switch(secondMsg){
          case 0x0002:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0002";
            break;
          case 0x0005:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0005";
            break;
          case 0x0006:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0006";
            break;
          case 0x0008:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0008";
            break;
          case 0x0010:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0010";
            break;
          case 0x0019:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0019";
            break;
          case 0x0020:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0020";
            break;
          case 0x0023:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0023";
            break;
          case 0x0024:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0024";
            break;
          case 0x000B:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x000B";
            break;
          case 0x9003:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x9003";
            break;
          case 0x9100:
            msgstr = "节目已过期，请点播其他节目<br/>服务代码：0x9100";	//首页
            break;
          case 0x8001:
            msgstr = "用户未注册或余额不足，请充值或联系96296<br/>服务代码：0x8001";	//首页
            break;
          case 0x8002:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x8002";
            break;
          case 0x8003:
            msgstr = "用户未注册或余额不足，请充值或联系96296<br/>服务代码：0x8003";
            break;
          case 0x800F:
            msgstr = "异常错误，请充值或联系96296<br/>服务代码:0x800F";
            break;
          case 0x8FFF:
            msgstr = "服务器系统异常错误，请充值或联系96296<br/>服务代码:0x8FFF";
            break;
          case 0x8050:
            msgstr = "影片ID重复，不能插入，请充值或联系96296<br/>服务代码:0x8050";
            break;
          case 0x8051:
            msgstr = "影片未找到，不能更新，请充值或联系96296<br/>服务代码:0x8051";
            break;
          case 0x805F:
            msgstr = "影片更新插入异常错误请充值或联系96296<br/>服务代码:0x805F";
            break;
          case 0x0003:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0003";
            break;
          case 0x0004:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x0004";
            break;
          case 0x001A:
            msgstr = "用户未注册或余额不足，请充值或联系96296<br/>服务代码：0x001A";	//返回首页
            break;
          case 0x001B:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x001B";
            break;
          case 0x9051:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x9051";
            break;
          case 0x9052:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x9051";
            break;
          default:
            msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：" + secondMsg;
            break;
        }
        netErrorEvent = true;
        showVideoTip("友情提示",msgstr);
        break;
      case 45020:
        msgstr = "信号太差，将自动退出<br/>错误代码0x9051";
        showVideoTip("友情提示",msgstr);
        sigalErrorTimer = setTimeout(function(){
          clearTimeout(sigalErrorTimer);
          window.history.go(-1);
          sigalErrorTimer=null;
        },3000);
        break;
      case 45022:
        msgstr = "网络连接失败，请退出重试或联系96296<br/>服务代码：0x5002";
        showVideoTip("友情提示",msgstr);
        break;
      default:
        event.preventDefault();
        break;
    }
  }

  /**
   * 设置续看点 单位毫秒；
   * @param resumeNum
   */
  function setResumePoint(resumeNum){
    /*if(setResumeFlag){
      var url = "../confirmMessage/setResumePointOldApp.do?stbNo="+clientId
              +"&assetId="+movieInfo.assetId+"&resumePointNum="+resumeNum+"&videoType=10000";
      Action.callGetServiceError(url,function(data){
        window.history.go(-1);
      },function(){
        window.history.go(-1);
      },true);
    }
    setResumeFlag=false;*/
    window.history.go(-1);
  }

  function closePageAndPlay(){
    setResumePoint(1);
    destroyWindow();
  }

  //清空所有定时器
  function clearAllTimer(){
    clearInterval(mainTimer);
    clearTimeout(playWindow);
    clearTimeout(initVodTimer);
    clearInterval(fastWard);

    mainTimer=null;
    playWindow=null;
    initVodTimer=null;
    fastWard=null;
  }

  $(document).ready(function () {
    Action.focusPos = "PLAY";
    initPage();
  });
</script>
</body>
</html>

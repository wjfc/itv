Coship.setDrawFocusRing(1);
Utility.setDrawFocusRing(0);
var vod;
var mp = new MediaPlayer();
var mpeg_opened=false;
var totalVolumeProgressWidth = 580;
var startVolumePoint = 105;
var volumeStep = 0;
var volumeTimer=0;
var showVolumeConsoleFlag = true,isMute = false;  //showVolumeConsoleFlag：是否显示音量控制；isMute：是否静音
if(window.navigator.appName!="Microsoft Internet Explorer"){
    vod = new VODControl();
}


function mpeg_open(){
    //if(window.navigator.appName=="Microsoft Internet Explorer" || window.navigator.appName=="Netscape") return;
    if(!mpeg_opened){
        vod.Install();
        mpeg_opened=true;
    }
    return true;
}

function mpeg_read(ioctl){
    //if(window.navigator.appName=="Microsoft Internet Explorer" || window.navigator.appName=="Netscape") return;
    var result;
    if(mpeg_opened){
        rev = vod.Get(ioctl);
        return rev;
    }else{
        alert('[mpeg_read]Please open device first !');
    }
}

function mpeg_write(ioctl,value){
    //if(window.navigator.appName=="Microsoft Internet Explorer" || window.navigator.appName=="Netscape") return;
    var result;
    if(mpeg_opened){
        rev = vod.SetUp(ioctl,value);
        return rev;
    }else{
        alert('[mpeg_write]Please open device first !');
    }
}

function mpeg_close(){
    //if(window.navigator.appName=="Microsoft Internet Explorer" || window.navigator.appName=="Netscape") return;
    if(!mpeg_opened){
        vod.GiveUp();
        mpeg_opened=false;
    }
    return true;
}


function getStbNo()
{
    //if(window.navigator.appName=="Microsoft Internet Explorer" || window.navigator.appName=="Netscape") return "test";
    mpeg_open();
    var stbno=mpeg_read('STBNo');
    mpeg_close();
    return 	stbno;
}


/**
 * 窗口播放 1275,715
 * @param movieAssetId          影片assetid
 * @param movirTitle            影片名称
 * @param playPos               影片开始时间
 * @param StartTime
 * @param EndTime
 */
function vodFullPlay(movieAssetId,movirTitle,playPos,StartTime,EndTime){
    mpeg_open();
    mpeg_write("MpegWidowState", "N");
    mpeg_write('CableMpegWindowCreate', '1,1,1275,715');//创建点播节目窗口，指定位置大小
    mpeg_write('CableMpegFullScreen','0');//0为窗口状态下播放（上个接口设置为1280,720后，同样也是全屏的效果）
    var curState=mpeg_read('CableMPEGState');
    mpeg_write('printf','CableMPEGState='+curState+'\n');
    if(curState==0){
        if(movieAssetId!=''&&movieAssetId!=' '){
            mpeg_write('SetupServerIPFile',movieAssetId);
            curState=mpeg_read('CableMPEGState');
            if(curState==1){
                if (movirTitle!=undefined && movirTitle!='' ){
                    mpeg_write('CableMPEGName',movirTitle);
                }
                if (StartTime!=undefined && StartTime !='' && EndTime!=undefined && EndTime !=''){
                    if(playPos==0){
                        mpeg_write('CableMPEGPlay','0:'+StartTime+':'+EndTime);
                    }else{
                        mpeg_write('CableMPEGPlay',playPos+':'+StartTime+':'+EndTime);
                    }
                }else {
                    if(playPos==0){
                        mpeg_write('CableMPEGPlay',' ');
                    }else{
                        mpeg_write('CableMPEGPlay',playPos);
                    }
                }
                curState=mpeg_read('CableMPEGState');
                if(curState!=2){
                    mpeg_write('printf','play failed\n');
                }else{
                    mpeg_write('JseBrowserControl','status:0');
                }
            }else{
                mpeg_write('printf','SetupServerIPFile failed\n');
            }
        }
    }else{
        if(curState!=2){
            mpeg_write('printf','play\n');
            mpeg_write('CableMPEGPlay',' ');
            mpeg_write('JseBrowserControl','status:0');
            curState=3;
        }else{
            mpeg_write('printf','pause\n');
            Pause();
        }
    }
    mpeg_close();
}

function Play_nj(curPlayURL,CalbleAssetNAME,pos,StartTime,EndTime){
    mpeg_open();
    var curState=mpeg_read('CableMPEGState');
    mpeg_write('printf','CableMPEGState='+curState+'\n');
    if(curState==0){
        if(curPlayURL!=''&&curPlayURL!=' '){
            mpeg_write('SetupServerIPFile',curPlayURL);
            curState=mpeg_read('CableMPEGState');
            if(curState==1){
                if (CalbleAssetNAME!=undefined && CalbleAssetNAME !='' ){
                    mpeg_write('CableMPEGName',CalbleAssetNAME);
                }
                if (StartTime!=undefined && StartTime !='' && EndTime!=undefined && EndTime !=''){
                    if(pos==0){
                        mpeg_write('CableMPEGPlay','0:'+StartTime+':'+EndTime);
                    }else{
                        mpeg_write('CableMPEGPlay',pos+':'+StartTime+':'+EndTime);
                    }
                }else {
                    if(pos==0){
                        mpeg_write('CableMPEGPlay',' ');
                    }else{
                        mpeg_write('CableMPEGPlay',pos);
                    }
                }
                curState=mpeg_read('CableMPEGState');
                if(curState!=2){
                    mpeg_write('printf','play failed\n');
                }else{
                    mpeg_write('JseBrowserControl','status:0');
                }
            }else{
                mpeg_write('printf','SetupServerIPFile failed\n');
            }
        }
    }else{
        if(curState!=2){
            mpeg_write('printf','play\n');
            mpeg_write('CableMPEGPlay',' ');
            mpeg_write('JseBrowserControl','status:0');
            curState=3;
        }else{
            mpeg_write('printf','pause\n');
            Pause();
        }
    }
    mpeg_close();
}

/*停止视频，关闭视频窗口*/
function destroyWindow(){
    mpeg_open();
    mpeg_write('CableMPEGClose',' ');
    mpeg_write('CableMpegWindowDestory','');
    mpeg_write('JseBrowserControl','status:1');
}

/* 暂停*/
function Pause(){
    /*mpeg_open();
    mpeg_write('CableMPEGPause',' ');
    mpeg_close();*/
    playControl("pause",0,0);
}

/* 播放 */
function recovePlay(){
    /*mpeg_open();
    var pos=getCurrentTime();
    //getCurrentTime();
    mpeg_write('CableMPEGPlay',pos*1000);
    mpeg_close();*/
    //var pos=getCurrentTime();
    //playControl("play",0,pos);
    mp.setMuteFlag(0);//设置为有声
    playControl("resume",0,0);
}



//快进
function fastForward(nowSpeed){
    if(nowSpeed == 1){
        playControl("resume",0,0);
    }else{
        playControl("forward",nowSpeed,0);
    }
}

var fastWard=null;
//快退
function fastBackward(nowSpeed){
    if(nowSpeed == 1){
        playControl("resume",0,0);
    } else{
        playControl("forward",nowSpeed,0);
    }
    fastWard=setInterval("isStartOrEnd()",400);
}

//判断是否快进到头 或者快进到尾
function isStartOrEnd(){
    var currtime=getCurrentTime();
    var totleTime=getTotalTime();
    if(currtime<1){//代表快退到头 然后播放
        spos=2;
        nowSpeed=1;
        isFast=false;
        $(".c-icons>li").css("visibility", "hidden");
        $(".c-icons>li.c-play").css("visibility", "visible");
        $(".c-statusText").html("播放");
        if(fastWard!=null){
            clearInterval(fastWard);
            fastWard=null;
        }
    }else if(currtime>=(totleTime-1)){
        spos=2;
        nowSpeed=1;
        isFast=false;
        $(".c-icons>li").css("visibility", "hidden");
        $(".c-icons>li.c-play").css("visibility", "visible");
        $(".c-statusText").html("播放");
        if(fastWard!=null){
            clearInterval(fastWard);
            fastWard=null;
        }
    }
}

//初始化音量
function initSound(){
    var volume;
    try{
        /*var volumeMode = sysDa.get("VolumeSaveMode") != "" ? parseInt(sysDa.get("VolumeSaveMode")) : 0;
        if (volumeMode == 0) {
            volume = mp.getVolume();//获取当前系统音量。
        } else {
            volume = sysDa.get("UniformVolume") != "" ? parseInt(sysDa.get("UniformVolume")) : 16;
        }*/
        volume = mp.getVolume()
    }catch(e) {
        volume = 15;
    }
    if(volume == null || volume == undefined || volume == ""){
        volume = 15;
    }
    mp.setVolume(volume); //设置系统音量。volume:0~31，表示音量。
    volumeStep = totalVolumeProgressWidth/31;
    $(".volume-num").html(volume);
    $(".volume-progress").css("width",volumeStep * volume+"px");
    //$("volumePoint").style.left = startVolumePoint + volumeStep * volume;
    $(".volume-dot").css("margin-left",(volumeStep * volume)+"px");
}
function setMute(){
    if(isMute){
        isMute = false;
        //设置为有声
        mp.setMuteFlag(0);
        $(".icon-mute").removeClass("on");
    }else {
        isMute = true;
        //设置为静音
        mp.setMuteFlag(1);
        $(".icon-mute").addClass("on");
    }
}
function volumeOperate(num){
    if(isMute){
        isMute = false;
        //设置为有声
        mp.setMuteFlag(0);
        $(".icon-mute").removeClass("on");
    }
    if(showVolumeConsoleFlag){
        var volume = mp.getVolume();
        volume = volume + num;
        if(volume < 0){
            volume = 0;
        }
        if(volume > 31){
            volume = 31;
        }
        mp.setVolume(volume);
        volumeStep = totalVolumeProgressWidth/31;
        $(".volume-num").html(volume);
        $(".volume-progress").css("width",volumeStep * volume+"px");
        $(".volume-dot").css("margin-left",(volumeStep * volume)+"px");
        //totalVolumeProgressWidth%(startVolumePoint + volumeStep * volume)+
    }
}
function showVolumeConsole(){
    $(".volume-bar").addClass("on");
    showVolumeConsoleFlag = true;
}

function hideVolumeConsole(){
    $(".volume-bar").removeClass("on");
    showVolumeConsoleFlag = false;
}

//获取当前播放的时间点(MotoVod是内置对象)
function getCurrentTime(){

    return MotoVod.getCurrentTime();
}
//获取节目总时长
function getTotalTime(){

    return MotoVod.getTotalTime();
}
//是否是时移节目
function isTimeShift(){
    return MotoVod.isTimeShift();
}
//获取时移节目名称
function getTimeShiftName(){
    var name = MotoVod.getTimeShiftName();
    return name.substring(1, name.length);
}
//获取点播节目名称
function getProgramName(){
    return MotoVod.getProgramName();
}
//获取时移的起始时间
function getBeginTime(){
    return MotoVod.getBeginTime();
}
//获取时移的结束时间
function getEndTime(){
    return MotoVod.getEndTime();
}
//播放控制
function playControl(type, speed, jumptime){
    MotoVod.playControl(type,speed,jumptime);
}
//判断是否创建小视屏点播窗口
function isCreateMpegWindow(){
    return MotoVod.isCreateMpegWindow();
}
//是否小视频点播窗口切换成全屏
function isMpegWindowFullScreen(){
    return MotoVod.isMpegWindowFullScreen();
}
//是否录制完毕
function isRecordOver(){
    return MotoVod.isRecordOver();
}
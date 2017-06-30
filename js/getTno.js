var vod;
var mpeg_opened=false;
var DebugMode = 0;
if(window.navigator.appName!="Microsoft Internet Explorer"){
	try{
		vod = new VODControl();
	}catch(e){
		//TODO handle the exception
	}
}

function mpeg_read(ioctl){
	if(window.navigator.appName=="Microsoft Internet Explorer") return;
	var rev;
	if(mpeg_opened && vod){
	   if (DMX.Browser.iPanel30 && ioctl == 'STBNo'){//兼容栖霞 茁壮3.0海信HI3716M 盒子获取盒子号多一位问题
	     rev = vod.Get('STBNo');
	   }else {
	     rev = vod.Get(ioctl);
	   }
		return rev;
	}else{
		//alert('[mpeg_read]Please open device first !');
	}
}

function mpeg_write(ioctl,value){
    if(window.navigator.appName=="Microsoft Internet Explorer") return;
 	var rev;
	if(mpeg_opened && vod){
		rev = vod.SetUp(ioctl,value);
		return rev;
	}else{
		//alert('[mpeg_write]Please open device first !');
	}
}

function mpeg_open(){
    if(window.navigator.appName=="Microsoft Internet Explorer") return;
	if(!mpeg_opened && vod){
		vod.Install();	
		mpeg_opened=true;
	}
	return true;
}

function mpeg_close(){
    if(window.navigator.appName=="Microsoft Internet Explorer") return;
	if(!mpeg_opened && vod){
		vod.GiveUp();
		mpeg_opened=false;
	}
	return true;
}
/**
 * 获取机顶盒序列号
 * @return
 */
function getStbNo(){
    if(window.navigator.appName=="Microsoft Internet Explorer"||DebugMode==1) return "test";
	mpeg_open();
	var stbno=mpeg_read('STBNo');			 
	return stbno;
}

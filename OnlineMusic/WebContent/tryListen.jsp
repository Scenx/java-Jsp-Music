<%@ page contentType="text/html; charset=gb2312" language="java" import="java.io.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<html>
<head>
<title>在线试听</title>
<style>
#lrcAreaDiv td, #lrcAreaDiv font {font-size: 16px;}
#lrcArea td { color:#000000; }
.lrcLine_will { overflow:hidden; height:20; width:0; filter:alpha(opacity=100); }
</style>
</head>
<body style="padding:0px; margin:0px; text-align:center" onselectstart="self.event.returnValue=false" oncontextmenu="return false;">
<span id="lrcContent" style="display:none;">${lrcContent}</span>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="30" background="images/newWindow_title.gif" style="font-size:16px">&nbsp;试听歌曲：${songName}</td>
    </tr>
  </table>
<object classid="clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6" id="mediaPlayer" width="480" height="64">
<param name="url" value="${realPath}">
<param name="volume" value="100">
<param name="playcount" value="100">
<param name="enableerrordialogs" value="0">
<param name="autostart" value="1">
</object>
<div id="lrcAreaDiv" style="overflow:hidden; height:260; width:480;">
<table border="0" cellspacing="0" cellpadding="0" id="lrcArea" width="100%" style="position:relative; top:120px;">
  <tr><td nowrap height="20" align="center">
    <table border="0" cellspacing="0" cellpadding="0">
      <tr><td nowrap height="20"><span id="lrcLine1" style="height:20; color:#FF0000">正在加载歌词……</span></td>
      </tr>
      <tr style="position:relative; top: -20px; z-index:6;">
        <td nowrap height="20"><div id="lrcLine_will1" class="lrcLine_will"></div></td>
      </tr>
    </table>
  </td></tr>
  <%int lineNumber=Integer.parseInt(request.getAttribute("lineNumber").toString());
   for(int i=0;i<lineNumber;i++){%>
  <tr style="position:relative; top: <%=-20*i%>px;"><td nowrap height="20" align="center">
    <table border="0" cellspacing="0" cellpadding="0">
      <tr><td nowrap height="20"><span id="lrcLine<%=i+2%>" style="height:20"></span></td></tr>
      <tr style="position:relative; top: -20px; z-index:6;">
        <td nowrap height="20"><div id="lrcLine_will<%=i+2%>" class="lrcLine_will"></div></td>
      </tr>
    </table>
  </td></tr>
  <%}%>
 
</table>
</div>
<script language="JavaScript">
var getLrcContent=lrcContent.innerHTML;		//获取歌词内容
if(getLrcContent!=""){
	lrcobj = new lrcClass(getLrcContent);	//初始化lrcClass类的对象，参数为歌词内容
	var lrc0, lrc1;
	moveflag = false;
	movable = false;
	moven = false;
	var lrctop;
	predlt = 0;
	curdlt = 0;
	curpot = 0;
	//定义一个解析lrc歌词的函数
	function lrcClass(lyric){		//参数为歌词内容
		this.inr = [];
		this.oTime = 0;
		this.dts = -1;
		this.dte = -1;
		this.dlt = -1;
		this.ddh;
		this.fjh;
		if(/\[offset\:(\-?\d+)\]/i.test(lyric)) this.oTime = RegExp.$1/1000;//获取歌词中是否有时间补偿值，时间补偿值的单位为毫秒，正数表示整体提前，负数表示整体滞后
		lyric = lyric.replace(/\[\:\][^$\n]*(\n|$)/g,"$1");
		lyric = lyric.replace(/\[[^\[\]\:]*\]/g,"");
		lyric = lyric.replace(/\[[^\[\]]*[^\[\]\d]+[^\[\]]*\:[^\[\]]*\]/g,"");
		lyric = lyric.replace(/\[[^\[\]]*\:[^\[\]]*[^\[\]\d\.]+[^\[\]]*\]/g,"");
	
		while(/\[[^\[\]]+\:[^\[\]]+\]/.test(lyric)){
			lyric = lyric.replace(/((\[[^\[\]]+\:[^\[\]]+\])+[^\[\r\n]*)[^\[]*/,"\n");
			var zzzt = RegExp.$1;
			/^(.+\])([^\]]*)$/.exec(zzzt);
			var ltxt = RegExp.$2;
			var eft = RegExp.$1.slice(1,-1).split("][");
			for(var ii=0; ii<eft.length; ii++){
				var sf = eft[ii].split(":");
				var tse = parseInt(sf[0],10) * 60 + parseFloat(sf[1]);
				var sso = { t:[] , w:[] , n:ltxt }
				sso.t[0] = tse-this.oTime;
				this.inr[this.inr.length] = sso;
			}
		}
		this.inr = this.inr.sort( function(a,b){return a.t[0]-b.t[0];} );
		
		for(var ii=0; ii<this.inr.length; ii++){
			while(/<[^<>]+\:[^<>]+>/.test(this.inr[ii].n)){
				this.inr[ii].n = this.inr[ii].n.replace(/<(\d+)\:([\d\.]+)>/,"%=%");
				var tse = parseInt(RegExp.$1,10) * 60 + parseFloat(RegExp.$2);
				this.inr[ii].t[this.inr[ii].t.length] = tse-this.oTime;
			}
			lrcLine_will1.innerHTML = "<font>"+ this.inr[ii].n.replace(/&/g,"&").replace(/</g,"<").replace(/>/g,">").replace(/%=%/g,"</font><font>") +" </font>";
			var fall = lrcLine_will1.getElementsByTagName("font");
			for(var wi=0; wi<fall.length; wi++){
				this.inr[ii].w[this.inr[ii].w.length] = fall[wi].offsetWidth;
			}
			this.inr[ii].n = lrcLine_will1.innerText;
		}
		//定义一个方法，用于控制歌词的同步显示
		this.wghLoad = function(tme){
			if(tme<this.dts || tme>=this.dte){
				var ii;
				for(ii=this.inr.length-1; ii>=0 && this.inr[ii].t[0]>tme; ii--){
				}
				if(ii<0) return;
				this.ddh = this.inr[ii].t;
				this.fjh = this.inr[ii].w;
				this.dts = this.inr[ii].t[0];
				this.dte = (ii<this.inr.length-1)?this.inr[ii+1].t[0]:mediaPlayer.currentMedia.duration;
				
				if(!movable){
					lrctop = 140;
					lrcArea.style.pixelTop = 140;
					loseLight(lrcLine1);
					for(var wi=1; wi<=this.inr.length; wi++){
						eval("lrcLine"+wi).innerText = this.inr[wi-1].n;
						eval("lrcLine_will"+wi).innerText = this.inr[wi-1].n;
					}
					movable = true;
				}
				if(moven){
					moven = false;
				}else{
					if(this.dlt>0) loseColor(eval("lrcLine_will"+this.dlt));
					if(this.dlt==ii-1){
						predlt = this.dlt+1;
						if(predlt>0){
						}
						lrcChangePosition(1,this.dte-this.dts);//改变歌词顶部的位置，实现歌词向上滚动
					}
					if(ii-this.dlt>1 || ii-this.dlt<=-1){
						if(this.dlt==-1 || ii==0){
							lrcTopPosition(ii-this.dlt-1);				//设置歌词的顶部位置
							lrcChangePosition(1,this.dte-this.dts);	//改变歌词顶部的位置，实现歌词向上滚动
						}else{
							lrcTopPosition(ii-this.dlt);				//设置歌词的顶部位置
						}
						if(this.dlt>=0) loseColor(eval("lrcLine_will"+(this.dlt+1)));
					}
					if(this.dlt>=0) loseLight(eval("lrcLine"+(this.dlt+1)));
					highlight(eval("lrcLine"+(ii+1)));
				}
				this.dlt = ii;
				curdlt = ii;
				curpot = ii;
			}
		}
	}
	//开始播放歌词的方法
	function wghLoad_lrc(){
		lrcobj.wghLoad(mediaPlayer.controls.currentPosition);
		if(arguments.length==0){
			lrc0 = window.setTimeout("wghLoad_lrc()",10);
		}
	}
	//当页面卸载时，取消对lrc0的延迟执行
	window.onunload=function(){
		clearTimeout(lrc0);
	}
	//设置歌词的顶部位置
	function lrcTopPosition(nline){
		lrctop -= 20*nline;
		lrcArea.style.top = lrctop;
	}
	//改变歌词顶部的位置，实现歌词向上滚动
	function lrcChangePosition(step,dur){
		if(moveflag) return;
		lrcArea.style.top = lrctop--;
		if(step<20){
			step++;
			window.setTimeout("lrcChangePosition("+step+","+dur+");",dur*50);
		}
	}
	//设置当前演唱的歌词行的颜色，即让当前歌词行高亮显示
	function highlight(lid){
		lid.style.color = "#FF0000";		//设置将要演唱的歌词的颜色
	}
	//清除当前歌词的高亮显示
	function loseColor(lid){
		window.clearTimeout(lrc1);
	}
	//演唱后的歌词行的颜色
	function loseLight(lid){
		lid.style.color = "#000000";		//设置演唱后的歌词的显示颜色
	}
	wghLoad_lrc();							//开始播放歌词
}else{
	document.getElementById("lrcLine1").innerHTML="很抱歉，该歌曲没有提供歌词！";
}
</script>
</body>
</html>
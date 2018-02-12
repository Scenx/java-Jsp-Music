<%@ page contentType="text/html; charset=gb2312" language="java" import="java.io.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<html>
<head>
<title>歌曲连播</title>
<script language="javascript">
/**************判断客户端是否安装RealPlayer播放器和Windows Media Player播放器*****************************/
    var RealPlayer5=0;
    var RealPlayer4=0;
    var RealPlayerG2=0;
	var checkRealPlayer=false;
	var meidaplay=0;
	var isMeidaplay=false;
    // 通过VBScript的CreateObject()函数动态的创建RealPlayer对象和Media Player对象
    document.write("<script language='VBScript'\> \n");
    document.write("on error resume next \n");
    document.write("RealPlayerG2 = (NOT IsNull(CreateObject(\"rmocx.RealPlayer G2 Control\")))\n");
    document.write("RealPlayer5 = (NOT IsNull(CreateObject(\"RealPlayer.RealPlayer(tm) ActiveX Control (32-bit)\")))\n");
    document.write("RealPlayer4 = (NOT IsNull(CreateObject(\"RealVideo.RealVideo(tm) ActiveX Control (32-bit)\")))\n");
    document.write("meidaplay = (NOT IsNull(createObject(\"MediaPlayer.MediaPlayer\")))\n");

    document.write("</script\> \n");

    //Real Player播放器
    if ( RealPlayerG2 || RealPlayer5 || RealPlayer4 ){
    	checkRealPlayer=true;		//已经安装Real Player播放器
    }else{
		checkRealPlayer=false;		//未安装Real Player播放器
    }
    //Windows Media Player播放器
     if(meidaplay){
   		 isMeidaplay=true;			//已经安装Windows Media Player播放器
    }else{
   		 isMeidaplay=false;			//未安装Windows Media player播放器
    }   
/********************************************************************************/
//初始化方法
function init(){
	if(isMeidaplay){	//检测是否安装Windows Media Player播放器
		document.getElementById("myPlayer").innerHTML="<object classid='clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6' id='wghMediaPlayer' name='wghMediaPlayer' width='360' height='64'><param name='volume' value='100'><param name='playcount' value='100'><param name='enableerrordialogs' value='0'><param name='ShowStatusBar' value='-1'></object> ";
		document.getElementById("wghMediaPlayer").AutoRewind=false;
		document.getElementById("wghMediaPlayer").SendPlayStateChangeEvents=true;
		document.getElementById("wghMediaPlayer").attachEvent("PlayStateChange",checkPlayStatus);
		if(form1.playList.options.length>0){
			form1.playList.options[0].selected=true;
			document.getElementById("wghMediaPlayer").url=form1.playList.value;
			document.getElementById("wghMediaPlayer").controls.play();		//开始播放
		}
				document.getElementById("wghMediaPlayer").AutoStart=true;	//设置自动播放
	}else if(checkRealPlayer){		//检测是否安装RealPlayer播放器
			document.getElementById("myPlayer").innerHTML="<object classid='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' id='wghMediaPlayer' name='wghMediaPlayer' width='360' height='64'><param name='volume' value='100'><param name='playcount' value='100'><param name='enableerrordialogs' value='0'><param name='ShowStatusBar' value='-1'><param name='SendPlayStateChangeEvents' value='1'></object> ";
		document.getElementById("wghMediaPlayer").AutoRewind=false;
		document.getElementById("wghMediaPlayer").AutoStart=true;			//设置自动播放
		if(form1.playList.options.length>0){
			realPlayerPlay();	//连续播放
		}
	}else{
		alert("请安装Windows Media Player或Real Player播放器！");
		window.close();
	}
}
//Real Player播放器的连续播放的方法
function realPlayerPlay(){
	if(document.getElementById('wghMediaPlayer').getPlayState()==0){
		document.getElementById("wghMediaPlayer").doStop();
		
		if(form1.playType.value==0){			//表示顺序播放
			if(form1.playList.options.selectedIndex<form1.playList.options.length-1){
				form1.playList.options[form1.playList.options.selectedIndex+1].selected=true;
			}else{
				form1.playList.options[0].selected=true;
			}
		}else{									//随机播放
			var randomValue=Math.round(Math.random() * (form1.playList.options.length - 1)) ;	//生成一个0至歌曲总数-1的随机整数
			form1.playList.options[randomValue].selected=true;
		}

		document.getElementById("wghMediaPlayer").Source=form1.playList.value;
		document.getElementById("wghMediaPlayer").doPlay();
	}
	var timer=setTimeout("realPlayerPlay()",1000);	
}
//双击列表框中指定歌曲时执行的方法
function list_dblClick(){
	if(isMeidaplay){				//是否安装Windows Media Player播放器
		document.getElementById("wghMediaPlayer").detachEvent("PlayStateChange",checkPlayStatus);
		document.getElementById("wghMediaPlayer").url=form1.playList.value;	//将列表框的值指定给Media Player播放器
		document.getElementById("wghMediaPlayer").controls.play();							//开始播放
		setTimeout('document.getElementById("wghMediaPlayer").controls.play();document.getElementById("wghMediaPlayer").attachEvent("PlayStateChange",checkPlayStatus);',1000);
	}else if(checkRealPlayer){		//检测是否安装RealPlayer播放器
		document.getElementById("wghMediaPlayer").Source=form1.playList.value;	//将列表框的值指定给Real Player播放器
		document.getElementById("wghMediaPlayer").doPlay();						//开始播放
	}
}
//使用Media Player播放器时，当播放状态改变时执行的方法
function checkPlayStatus(){
	try{
		if(document.getElementById("wghMediaPlayer").playState==10){
			if(form1.playType.value==0){			//表示顺序播放
				if(form1.playList.options.selectedIndex<form1.playList.options.length-1){
					form1.playList.options[form1.playList.options.selectedIndex+1].selected=true;
				}else{
					form1.playList.options[0].selected=true;
				}
			}else{									//随机播放
				var randomValue=Math.round(Math.random() * (form1.playList.options.length - 1)) ;	//生成一个0至歌曲总数-1的随机整数
				form1.playList.options[randomValue].selected=true;
			}
				document.getElementById("wghMediaPlayer").url=form1.playList.value;
				document.getElementById("wghMediaPlayer").controls.play();
			
		}else{
			if(document.getElementById("wghMediaPlayer").playState==8){
				document.getElementById("wghMediaPlayer").detachEvent("PlayStateChange",checkPlayStatus);
				document.getElementById("wghMediaPlayer").controls.stop();
				if(form1.playType.value==0){			//表示顺序播放
					if(form1.playList.options.selectedIndex<form1.playList.options.length-1){
						form1.playList.options[form1.playList.options.selectedIndex+1].selected=true;
					}else{
						form1.playList.options[0].selected=true;
					}
				}else{									//随机播放
					var randomValue=Math.round(Math.random() * (form1.playList.options.length - 1)) ;	//生成一个0至歌曲总数-1的随机整数
					form1.playList.options[randomValue].selected=true;
				}
				document.getElementById("wghMediaPlayer").url=form1.playList.value;
				document.getElementById("wghMediaPlayer").controls.play();
				setTimeout('document.getElementById("wghMediaPlayer").controls.play();document.getElementById("wghMediaPlayer").attachEvent("PlayStateChange",checkPlayStatus);',1000);
			}	
		}			
	}catch(e){
	}
}
</script>

</head>
<body onselectstart="self.event.returnValue=false" oncontextmenu="return false;" onLoad="init()">
<form name="form1" method="post" action="">
<table width="363" height="185" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2" id="myPlayer">正在加载播放器……
    </td>
    </tr>
  <tr>
    <td width="60" height="35">播放列表</td>
    <td width="303" align="right"><select name="playType" id="playType">
      <option value="0" selected>顺序播放</option>
      <option value="1">随机播放</option>
    </select></td>
  </tr>
  <tr>
    <td colspan="2"><select name="playList" size="10" id="playList" ondblclick="list_dblClick();" style=" width:360px">
      <logic:iterate id="song" name="songNameList" type="com.model.SongForm" scope="request" indexId="ind">
        <option value="<bean:write name="song" property="fileURL" filter="true"/>">
        <bean:write name="song" property="songName" filter="true"/>
      </logic:iterate>
    </select></td>
    </tr>
</table>
</form>
</body>
</html>

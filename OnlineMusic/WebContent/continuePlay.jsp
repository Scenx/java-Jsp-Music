<%@ page contentType="text/html; charset=gb2312" language="java" import="java.io.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<html>
<head>
<title>��������</title>
<script language="javascript">
/**************�жϿͻ����Ƿ�װRealPlayer��������Windows Media Player������*****************************/
    var RealPlayer5=0;
    var RealPlayer4=0;
    var RealPlayerG2=0;
	var checkRealPlayer=false;
	var meidaplay=0;
	var isMeidaplay=false;
    // ͨ��VBScript��CreateObject()������̬�Ĵ���RealPlayer�����Media Player����
    document.write("<script language='VBScript'\> \n");
    document.write("on error resume next \n");
    document.write("RealPlayerG2 = (NOT IsNull(CreateObject(\"rmocx.RealPlayer G2 Control\")))\n");
    document.write("RealPlayer5 = (NOT IsNull(CreateObject(\"RealPlayer.RealPlayer(tm) ActiveX Control (32-bit)\")))\n");
    document.write("RealPlayer4 = (NOT IsNull(CreateObject(\"RealVideo.RealVideo(tm) ActiveX Control (32-bit)\")))\n");
    document.write("meidaplay = (NOT IsNull(createObject(\"MediaPlayer.MediaPlayer\")))\n");

    document.write("</script\> \n");

    //Real Player������
    if ( RealPlayerG2 || RealPlayer5 || RealPlayer4 ){
    	checkRealPlayer=true;		//�Ѿ���װReal Player������
    }else{
		checkRealPlayer=false;		//δ��װReal Player������
    }
    //Windows Media Player������
     if(meidaplay){
   		 isMeidaplay=true;			//�Ѿ���װWindows Media Player������
    }else{
   		 isMeidaplay=false;			//δ��װWindows Media player������
    }   
/********************************************************************************/
//��ʼ������
function init(){
	if(isMeidaplay){	//����Ƿ�װWindows Media Player������
		document.getElementById("myPlayer").innerHTML="<object classid='clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6' id='wghMediaPlayer' name='wghMediaPlayer' width='360' height='64'><param name='volume' value='100'><param name='playcount' value='100'><param name='enableerrordialogs' value='0'><param name='ShowStatusBar' value='-1'></object> ";
		document.getElementById("wghMediaPlayer").AutoRewind=false;
		document.getElementById("wghMediaPlayer").SendPlayStateChangeEvents=true;
		document.getElementById("wghMediaPlayer").attachEvent("PlayStateChange",checkPlayStatus);
		if(form1.playList.options.length>0){
			form1.playList.options[0].selected=true;
			document.getElementById("wghMediaPlayer").url=form1.playList.value;
			document.getElementById("wghMediaPlayer").controls.play();		//��ʼ����
		}
				document.getElementById("wghMediaPlayer").AutoStart=true;	//�����Զ�����
	}else if(checkRealPlayer){		//����Ƿ�װRealPlayer������
			document.getElementById("myPlayer").innerHTML="<object classid='clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' id='wghMediaPlayer' name='wghMediaPlayer' width='360' height='64'><param name='volume' value='100'><param name='playcount' value='100'><param name='enableerrordialogs' value='0'><param name='ShowStatusBar' value='-1'><param name='SendPlayStateChangeEvents' value='1'></object> ";
		document.getElementById("wghMediaPlayer").AutoRewind=false;
		document.getElementById("wghMediaPlayer").AutoStart=true;			//�����Զ�����
		if(form1.playList.options.length>0){
			realPlayerPlay();	//��������
		}
	}else{
		alert("�밲װWindows Media Player��Real Player��������");
		window.close();
	}
}
//Real Player���������������ŵķ���
function realPlayerPlay(){
	if(document.getElementById('wghMediaPlayer').getPlayState()==0){
		document.getElementById("wghMediaPlayer").doStop();
		
		if(form1.playType.value==0){			//��ʾ˳�򲥷�
			if(form1.playList.options.selectedIndex<form1.playList.options.length-1){
				form1.playList.options[form1.playList.options.selectedIndex+1].selected=true;
			}else{
				form1.playList.options[0].selected=true;
			}
		}else{									//�������
			var randomValue=Math.round(Math.random() * (form1.playList.options.length - 1)) ;	//����һ��0����������-1���������
			form1.playList.options[randomValue].selected=true;
		}

		document.getElementById("wghMediaPlayer").Source=form1.playList.value;
		document.getElementById("wghMediaPlayer").doPlay();
	}
	var timer=setTimeout("realPlayerPlay()",1000);	
}
//˫���б����ָ������ʱִ�еķ���
function list_dblClick(){
	if(isMeidaplay){				//�Ƿ�װWindows Media Player������
		document.getElementById("wghMediaPlayer").detachEvent("PlayStateChange",checkPlayStatus);
		document.getElementById("wghMediaPlayer").url=form1.playList.value;	//���б���ֵָ����Media Player������
		document.getElementById("wghMediaPlayer").controls.play();							//��ʼ����
		setTimeout('document.getElementById("wghMediaPlayer").controls.play();document.getElementById("wghMediaPlayer").attachEvent("PlayStateChange",checkPlayStatus);',1000);
	}else if(checkRealPlayer){		//����Ƿ�װRealPlayer������
		document.getElementById("wghMediaPlayer").Source=form1.playList.value;	//���б���ֵָ����Real Player������
		document.getElementById("wghMediaPlayer").doPlay();						//��ʼ����
	}
}
//ʹ��Media Player������ʱ��������״̬�ı�ʱִ�еķ���
function checkPlayStatus(){
	try{
		if(document.getElementById("wghMediaPlayer").playState==10){
			if(form1.playType.value==0){			//��ʾ˳�򲥷�
				if(form1.playList.options.selectedIndex<form1.playList.options.length-1){
					form1.playList.options[form1.playList.options.selectedIndex+1].selected=true;
				}else{
					form1.playList.options[0].selected=true;
				}
			}else{									//�������
				var randomValue=Math.round(Math.random() * (form1.playList.options.length - 1)) ;	//����һ��0����������-1���������
				form1.playList.options[randomValue].selected=true;
			}
				document.getElementById("wghMediaPlayer").url=form1.playList.value;
				document.getElementById("wghMediaPlayer").controls.play();
			
		}else{
			if(document.getElementById("wghMediaPlayer").playState==8){
				document.getElementById("wghMediaPlayer").detachEvent("PlayStateChange",checkPlayStatus);
				document.getElementById("wghMediaPlayer").controls.stop();
				if(form1.playType.value==0){			//��ʾ˳�򲥷�
					if(form1.playList.options.selectedIndex<form1.playList.options.length-1){
						form1.playList.options[form1.playList.options.selectedIndex+1].selected=true;
					}else{
						form1.playList.options[0].selected=true;
					}
				}else{									//�������
					var randomValue=Math.round(Math.random() * (form1.playList.options.length - 1)) ;	//����һ��0����������-1���������
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
    <td colspan="2" id="myPlayer">���ڼ��ز���������
    </td>
    </tr>
  <tr>
    <td width="60" height="35">�����б�</td>
    <td width="303" align="right"><select name="playType" id="playType">
      <option value="0" selected>˳�򲥷�</option>
      <option value="1">�������</option>
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

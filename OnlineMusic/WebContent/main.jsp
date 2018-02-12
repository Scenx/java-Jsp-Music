<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<html>
  <head>
    <title>在线音乐 - Scen</title>
	<link href="CSS/style.css" rel="stylesheet"/>
<script language="javascript">
//控制复选框的全选或反选操作
function CheckAll(elementsA,elementsB){
	for(i=0;i<elementsA.length;i++){
		elementsA[i].checked = true;
	}
	if(elementsB.checked ==false){
		for(j=0;j<elementsA.length;j++){
			elementsA[j].checked = false;
		}
	}
}
//判断用户是否选择了要播放的歌曲，如果没有选择，则提示“请选择要播放的歌曲”；否则提交表单进行播放
function continuePlay(playId,formname){
	var flag = false;
	for(i=0;i<playId.length;i++){
		if(playId[i].checked){
			flag = true;
			break;
		}
	}
	if(!flag){
		alert("请选择要播放的记录！");
		return false;
	}else{
		formname.submit();
	}
}
</script> 


  </head>
  
  <body >
<jsp:include page="top.jsp"/>

<!--包含导航栏-->
<jsp:include page="song.do"  flush="true">
	  <jsp:param name="action" value="navigation"/>
 </jsp:include>
<!-------------->
<div id="main">
<div id="index_main"><img src="images/ad.jpg" width="649" height="67"><table width="100%"border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="5" bgcolor="#E2F1EE"></td>
    </tr>
    <tr>
      <td height="5" bgcolor="#FFFFFF"></td>
    </tr>	
  </table>
<%
String requestPara="";
String[][] typeArray=(String[][])request.getAttribute("typeArray");
for(int i=0;i<6;i++){
	requestPara="newSongList"+i;
	if(i%2==0){
%>
  <table width="98%" height="96" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><%@ include file="newSongList.jsp"%></td>
	  <%}else{%>
      <td valign="top"><%@ include file="newSongList.jsp"%></td>
    </tr>
  </table>
  	<hr size="1" width="98%" align="center"> 
  <br> 
  
  <%}
  }%>

  </div>
<div id="index_right" style="float:left;width:220px; margin-left:5px;">
  <table width="100%" height="56" border="0" cellpadding="0" cellspacing="0" style="padding-left:5px" class="tableBorder">
    <tr>
      <td width="4%" height="27" valign="middle" bgcolor="#CFED0A" class="word_darkGreen"><img src="images/title_ico.gif"></td>
      <td width="96%" valign="middle" bgcolor="#CFED0A" class="word_darkGreen">试听排行榜</td>
    </tr>
    <tr>
      <td colspan="2"><jsp:include page="song.do" flush="true">
	  <jsp:param name="action" value="songSort"/>
	  <jsp:param name="sortType" value="hits"/>
	  </jsp:include>	  </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="5"></td>
    </tr>
  </table> 
  <table width="100%" height="56" border="0" cellpadding="0" cellspacing="0" style="padding-left:5px" class="tableBorder">
    <tr>
      <td width="4%" height="27" valign="middle" bgcolor="#CFED0A" class="word_darkGreen"><img src="images/title_ico.gif"></td>
      <td width="96%" valign="middle" bgcolor="#CFED0A" class="word_darkGreen">下载排行榜</td>
    </tr>
    <tr>
      <td colspan="2"><jsp:include page="song.do" flush="true">
	  <jsp:param name="action" value="songSort"/>
	  <jsp:param name="sortType" value="download"/>
	  </jsp:include>	  </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>  
</div>
</div>

<jsp:include page="copyright.jsp"/>
  </body>
</html>

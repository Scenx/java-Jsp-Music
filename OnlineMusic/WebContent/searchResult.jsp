<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<jsp:useBean id="pagination" class="com.tools.MyPagination" scope="session"/>
<html>
  <head>
    <title>在线音乐</title>
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
  
  <body>
<jsp:include page="top.jsp"/>
<!--包含导航栏-->
<jsp:include page="song.do" flush="true">
	  <jsp:param name="action" value="navigation"/>
</jsp:include>
<!-------------->
<div id="main" style="padding:0px; margin:0px; margin-bottom:5px;" class="tableBorder_blue">
<div id="title" style="height:30px; text-align:left; margin:0px; padding-bottom:0px; padding-left:10px; padding-top:10px; background-color:#E2F1EE;">
查询条件：${queryKey}
</div>
<form name="form1" method="post" action="song.do?action=continuePlay" target="_blank" style="padding-top:5px;">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td align="center" bgcolor="#FFFFFF">选择</td>	  
        <td height="27" align="center" bgcolor="#FFFFFF">歌曲名称</td>
        <td align="center" bgcolor="#FFFFFF">演唱者</td>
        <td align="center" bgcolor="#FFFFFF">专辑名</td>
        <td align="center" bgcolor="#FFFFFF">文件大小</td>
        <td align="center" bgcolor="#FFFFFF">文件格式</td>
		<td align="center" bgcolor="#FFFFFF">歌曲类别</td>
        <td align="center" bgcolor="#FFFFFF">试听次数</td>
        <td align="center" bgcolor="#FFFFFF">下载次数</td>
        <td align="center" bgcolor="#FFFFFF">试听</td>
        <td align="center" bgcolor="#FFFFFF">下载</td>
      </tr>
	<logic:iterate id="song" name="songList" type="com.model.SongForm" scope="request" indexId="ind">
      <tr>
	    <td align="center" bgcolor="#FFFFFF">
	      <input type="checkbox" class="noborder" id="playId" name="playId" value="<bean:write name="song" property="id" filter="true"/>" >
	    </td>
        <td height="27" bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="songName" filter="true"/></td>
        <td bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="singer" filter="true"/></td>
        <td bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="specialName" filter="true"/></td>
        <td bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="fileSize" filter="true"/></td>
        <td bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="format" filter="true"/></td>
		<td bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="songType" filter="true"/></td>
        <td bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="hits" filter="true"/></td>
        <td bgcolor="#FFFFFF">&nbsp;
        <bean:write name="song" property="download" filter="true"/></td>
        <td align="center" bgcolor="#FFFFFF"><a href="#" onClick="window.open('song.do?action=tryListen&id=<bean:write name="song" property="id" filter="true"/>','','width=500,height=360');">试听</a></td>
        <td align="center" bgcolor="#FFFFFF"><a  href="song.do?action=download&id=<bean:write name="song" property="id" filter="true"/>">下载</a></td>
      </tr>
	</logic:iterate>
  </table>
  <table width="100%"  border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
	
	<td width="27%" style="padding-left:10px;color:#505050;"><input name="checkbox" type="checkbox" class="noborder" onClick="CheckAll(form1.playId,form1.checkbox)"> 
	  [<span class="word_green">全选/反选</span>] [<a style="color:FA6E00;cursor:hand;" onClick="continuePlay(form1.playId,form1)">歌曲连播</a>] 
	  <div id="ch" style="display:none"> 
		<input name="playId" type="checkbox" class="noborder" value="0"> 
	  </div></td> 
	<!--层ch用于放置隐藏的checkbox控件，因为当表单中只是一个checkbox控件时，应用javascript获得其length属性值为undefine-->
	<td width="73%" height="24"><%=pagination.printCtrl(Integer.parseInt(request.getAttribute("Page").toString()),"song.do?action=songQuery","&songType_more="+request.getAttribute("typeID"))%></td> 
  </tr> 
</table>
  </form>
</div>
<jsp:include page="copyright.jsp"/>
  </body>
</html>

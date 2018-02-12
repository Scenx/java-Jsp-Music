<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<jsp:useBean id="pagination" class="com.tools.MyPagination" scope="session"/>
<html>
  <head>
    <title>��������</title>
	<link href="CSS/style.css" rel="stylesheet"/>
<script language="javascript"> 
//���Ƹ�ѡ���ȫѡ��ѡ����
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
//�ж��û��Ƿ�ѡ����Ҫ���ŵĸ��������û��ѡ������ʾ����ѡ��Ҫ���ŵĸ������������ύ�����в���
function continuePlay(playId,formname){
	var flag = false;
	for(i=0;i<playId.length;i++){
		if(playId[i].checked){
			flag = true;
			break;
		}
	}
	if(!flag){
		alert("��ѡ��Ҫ���ŵļ�¼��");
		return false;
	}else{
		formname.submit();
	}
}
</script> 


  </head>
  
  <body>
<jsp:include page="top.jsp"/>
<!--����������-->
<jsp:include page="song.do" flush="true">
	  <jsp:param name="action" value="navigation"/>
</jsp:include>
<!-------------->
<div id="main" style="padding:0px; margin:0px; margin-bottom:5px;" class="tableBorder_blue">
<div id="title" style="height:30px; text-align:left; margin:0px; padding-bottom:0px; padding-left:10px; padding-top:10px; background-color:#E2F1EE;">
��ѯ������${queryKey}
</div>
<form name="form1" method="post" action="song.do?action=continuePlay" target="_blank" style="padding-top:5px;">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td align="center" bgcolor="#FFFFFF">ѡ��</td>	  
        <td height="27" align="center" bgcolor="#FFFFFF">��������</td>
        <td align="center" bgcolor="#FFFFFF">�ݳ���</td>
        <td align="center" bgcolor="#FFFFFF">ר����</td>
        <td align="center" bgcolor="#FFFFFF">�ļ���С</td>
        <td align="center" bgcolor="#FFFFFF">�ļ���ʽ</td>
		<td align="center" bgcolor="#FFFFFF">�������</td>
        <td align="center" bgcolor="#FFFFFF">��������</td>
        <td align="center" bgcolor="#FFFFFF">���ش���</td>
        <td align="center" bgcolor="#FFFFFF">����</td>
        <td align="center" bgcolor="#FFFFFF">����</td>
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
        <td align="center" bgcolor="#FFFFFF"><a href="#" onClick="window.open('song.do?action=tryListen&id=<bean:write name="song" property="id" filter="true"/>','','width=500,height=360');">����</a></td>
        <td align="center" bgcolor="#FFFFFF"><a  href="song.do?action=download&id=<bean:write name="song" property="id" filter="true"/>">����</a></td>
      </tr>
	</logic:iterate>
  </table>
  <table width="100%"  border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
	
	<td width="27%" style="padding-left:10px;color:#505050;"><input name="checkbox" type="checkbox" class="noborder" onClick="CheckAll(form1.playId,form1.checkbox)"> 
	  [<span class="word_green">ȫѡ/��ѡ</span>] [<a style="color:FA6E00;cursor:hand;" onClick="continuePlay(form1.playId,form1)">��������</a>] 
	  <div id="ch" style="display:none"> 
		<input name="playId" type="checkbox" class="noborder" value="0"> 
	  </div></td> 
	<!--��ch���ڷ������ص�checkbox�ؼ�����Ϊ������ֻ��һ��checkbox�ؼ�ʱ��Ӧ��javascript�����length����ֵΪundefine-->
	<td width="73%" height="24"><%=pagination.printCtrl(Integer.parseInt(request.getAttribute("Page").toString()),"song.do?action=songQuery","&songType_more="+request.getAttribute("typeID"))%></td> 
  </tr> 
</table>
  </form>
</div>
<jsp:include page="copyright.jsp"/>
  </body>
</html>

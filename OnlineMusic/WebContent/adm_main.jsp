<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%
String typeID="0";
String fieldName="";
String key="";
if(request.getAttribute("songType_more")!=null){
	typeID=request.getAttribute("songType_more").toString();
	fieldName=(String)request.getAttribute("fieldName");
	key=(String)request.getAttribute("key");
}
%>
<jsp:useBean id="pagination" class="com.tools.MyPagination" scope="session"/>
<html>
  <head>
    <title>�������ֺ�̨��ҳ</title>
	<link href="CSS/style.css" rel="stylesheet"/>
	<script language="javascript">
	function del(para){
		if(confirm("ȷ��Ҫɾ���ø�����")){
			window.location.href="song.do?action=del&id="+para;
		}
	}
	</script>
  </head>
  
  <body>
<div id="header"><!--������������-->
<div id="search">
<jsp:include page="song.do" flush="true">
	  <jsp:param name="action" value="songType"/>
 </jsp:include>
 </div>
 
</div>
<div id="title" style=" width:899px;height:25px; text-align:left; padding-left:10px; padding-top:5px; background-image:url(images/navigation_bg.gif);">
��ѯ������${queryKey}
</div>
<!-------------->
<div id="main" style="padding:0px; margin:0px; margin-bottom:5px;" class="tableBorder_blue">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" align="right"><a href="adm_add.jsp" class="word_orange">��Ӹ���</a>&nbsp;&nbsp; </td>
  </tr>
</table>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
      <tr>
        <td height="27" align="center" bgcolor="#FFFFFF">��������</td>
        <td align="center" bgcolor="#FFFFFF">�ݳ���</td>
        <td align="center" bgcolor="#FFFFFF">ר����</td>
        <td align="center" bgcolor="#FFFFFF">�ļ���С</td>
        <td align="center" bgcolor="#FFFFFF">�ļ���ʽ</td>
		<td align="center" bgcolor="#FFFFFF">�������</td>
        <td align="center" bgcolor="#FFFFFF">��������</td>
        <td align="center" bgcolor="#FFFFFF">���ش���</td>
        <td align="center" bgcolor="#FFFFFF">ɾ��</td>
      </tr>
	<logic:iterate id="song" name="songList" type="com.model.SongForm" scope="request" indexId="ind">
      <tr>
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
        <td align="center" bgcolor="#FFFFFF"><a  href="#" onClick="del('<bean:write name="song" property="id" filter="true"/><%="&songType_more="+typeID+"&fieldName="+fieldName+"&key="+key%>')">ɾ��</a></td>
      </tr>
	</logic:iterate>
  </table>
  <table width="100%"  border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
	
	<td width="27%" style="padding-left:10px"></td> 
		<td width="73%" height="24"><%=pagination.printCtrl(Integer.parseInt(request.getAttribute("Page").toString()),"song.do?action=adm_search","&songType_more="+typeID+"&fieldName="+fieldName+"&key="+key)%></td> 
  </tr> 
</table>
</div>
<jsp:include page="adm_copyright.jsp"/>
  </body>
</html>

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*" errorPage="" %>
<%@ page import="com.model.SongTypeForm" %>
<jsp:useBean class="com.dao.SongDAO" id="songDAO" scope="request"/>
<%List<SongTypeForm> list=songDAO.queryType();%>
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

<html>
  <head>
    <title>在线音乐后台首页</title>
	<link href="CSS/style.css" rel="stylesheet"/>
<script language="javascript">
function checkform(myform){
	for(i=0;i<myform.length;i++){
		if(myform.elements[i].value=="" &&myform.elements[i].name!="lrcFileURL"){
			alert(myform.elements[i].title+"不能为空！");
			myform.elements[i].focus();
			return false;
		}
	}
}
function opendialog(){
	if(form1.songName.value=="" || form1.singer.value==""){
		alert("请输入歌曲名和演唱者！");
	}else{
		var rtn=window.showModalDialog("song.do?action=checkMusic&songName="+form1.songName.value+"&singer="+form1.singer.value,"","dialogWidth=260px;dialogHeight=150px;status=no;help=no;scrollbars=no");
		if(rtn==1){
			form1.upMusic.disabled='';
		}
	}
}
</script>
  </head>
  
  <body>
<div id="header"><!--包含搜索条件-->
<div id="search">
<jsp:include page="song.do" flush="true">
	  <jsp:param name="action" value="songType"/>
 </jsp:include>
 </div>
 
</div>
<div id="title" style=" width:899px;height:25px; text-align:left; padding-left:10px; padding-top:5px; background-image:url(images/navigation_bg.gif);">当前位置：添加歌曲 &gt;&gt;

</div>
<div  id="main" style="padding:0px; margin:0px; margin-bottom:5px;" class="tableBorder_blue">
<form name="form1" method="post" action="song.do?action=add" onSubmit="return checkform(form1)">
  <table width="500" height="241" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="131" align="center">歌曲类别：</td>
      <td width="369">
	 <select name="songTypeId">
	  <%for(int i=0;i<list.size();i++){
	  %>
      <option value="<%=list.get(i).getId()%>"><%=list.get(i).getTypeName()%></option>
	  <%}%>  
    </select></td>
    </tr>
    <tr>
      <td align="center">歌 曲 名：</td>
      <td><input name="songName" type="text" id="songName" size="50" title="歌曲名"></td>
    </tr>
    <tr>
      <td align="center">演 唱 者：</td>
      <td><input name="singer" type="text" id="singer" size="30" title="演唱者">
        <input name="Submit5" type="button" class="btn_grey" value="检测该歌曲是否上传" onClick="opendialog()"></td>
    </tr>
    <tr>
      <td align="center">专 辑 名：</td>
      <td><input name="specialName" type="text" id="specialName" size="30" title="专辑名"></td>
    </tr>
    <tr>
      <td align="center">歌曲文件：</td>
      <td><input name="fileURL" type="text" id="fileURL" size="30" readonly="yes" title="歌曲文件">
        <input name="upMusic" type="button" class="btn_grey" value="上传文件" disabled="disabled" onClick="window.open('upFile.jsp','','width=350,height=150');"></td>
    </tr>
    <tr>
      <td align="center">歌词文件：</td>
      <td><input name="lrcFileURL" type="text" id="lrcFileURL" size="30" readonly="yes" title="歌词文件">
        <input name="lrcUp" type="button" class="btn_grey" value="上传文件" disabled="none" onClick="if(this.form.fileURL.value!=''){window.open('upLrcFile.jsp?fileName='+this.form.fileURL.value,'','width=350,height=150');}">
        <input name="fileSize" type="hidden" id="fileSize">
        <input name="format" type="hidden" id="format"></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <input name="Submit" type="submit" class="btn_grey" value="保存">
&nbsp;
<input name="Submit2" type="button" class="btn_grey" value="重置" onClick="window.location.reload();">
&nbsp;
<input type="button" name="Submit3" class="btn_grey" value="返回" onClick="history.back(-1)"></td>
    </tr>
  </table>
</form>
</div>
<jsp:include page="adm_copyright.jsp"/>
  </body>
</html>

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*" errorPage="" %>
<%@ page import="com.model.SongTypeForm"%>
<%List<SongTypeForm> list=(List<SongTypeForm>)request.getAttribute("songTypeList");%>
  <form name="form_search" method="post" action="song.do?action=adm_search" style=" margin:0px;">
  ������
    <select name="songType_more">
      <option value="0" selected="selected">ȫ��</option>
	  <%for(int i=0;i<list.size();i++){
	  %>
      <option value="<%=list.get(i).getId()%>"><%=list.get(i).getTypeName()%></option>
	  <%}%>  
    </select>
    <input type="text" name="key" id="key">
<input name="fieldName" type="radio" class="noborder" value="songName" checked>
  ������
  &nbsp;
  <input name="fieldName" type="radio" class="noborder" value="specialName">
  ר�� &nbsp;
  <input name="fieldName" type="radio" class="noborder" value="singer">
  ����&nbsp;
  <input name="Submit" type="submit" class="btn_bg" value="����">
  </form>

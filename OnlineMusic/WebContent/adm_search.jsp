<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*" errorPage="" %>
<%@ page import="com.model.SongTypeForm"%>
<%List<SongTypeForm> list=(List<SongTypeForm>)request.getAttribute("songTypeList");%>
  <form name="form_search" method="post" action="song.do?action=adm_search" style=" margin:0px;">
  搜索：
    <select name="songType_more">
      <option value="0" selected="selected">全部</option>
	  <%for(int i=0;i<list.size();i++){
	  %>
      <option value="<%=list.get(i).getId()%>"><%=list.get(i).getTypeName()%></option>
	  <%}%>  
    </select>
    <input type="text" name="key" id="key">
<input name="fieldName" type="radio" class="noborder" value="songName" checked>
  歌曲名
  &nbsp;
  <input name="fieldName" type="radio" class="noborder" value="specialName">
  专辑 &nbsp;
  <input name="fieldName" type="radio" class="noborder" value="singer">
  歌手&nbsp;
  <input name="Submit" type="submit" class="btn_bg" value="搜索">
  </form>

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
  <form name="form_search" method="post" action="song.do?action=search" style=" margin:0px;">
  ������<input type="text" name="key" id="key">
<input name="fieldName" type="radio" class="noborder" value="songName" checked>
  ������
  &nbsp;
  <input name="fieldName" type="radio" class="noborder" value="specialName">
  ר�� &nbsp;
  <input name="fieldName" type="radio" class="noborder" value="singer">
  ����&nbsp;
    <input name="songType_more" type="hidden" id="songType_more" value="<%=request.getAttribute("typeID")==null?0:request.getAttribute("typeID")%>">
  <input name="Submit" type="submit" class="btn_bg" value="�� ��">
  </form>

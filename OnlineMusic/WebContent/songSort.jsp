<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<table width="220" height="60" border="0" cellpadding="0" cellspacing="0" style="padding:4px;">
  <tr>
    <td><form name="form${sortTypeName}" method="post" action="song.do?action=continuePlay" target="_blank">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr bgcolor="#E7EAE2"><td height="24">&nbsp;</td><td class="word_gray">&nbsp;歌曲名</td><td class="word_gray">演唱者</td><td class="word_gray">次数</td></tr>
	<logic:iterate id="song" name="sortType" type="com.model.SongForm" scope="request" indexId="ind">
      <tr>
	    <td align="center">
	      <input type="checkbox" class="noborder" id="playId" name="playId" value="<bean:write name="song" property="id" filter="true"/>">	    </td>
        <td height="27" title=" <bean:write name="song" property="songName" filter="true"/>" class="word_gray1">&nbsp;
        <bean:write name="song" property="songName_short" filter="true"/></td>
        <td title=" <bean:write name="song" property="singer" filter="true"/>" class="word_gray1">&nbsp;
        <bean:write name="song" property="singer" filter="true"/></td>
		<td class="word_gray1"><bean:write name="song" property="${sortTypeName}" filter="true"/></td>
		</tr>
		
 	</logic:iterate>
  </table>
  <table width="100%"  border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
	
	<td height="24" align="right" style="padding-left:10px" class="word_gray1"><input name="checkbox" type="checkbox" class="noborder" onClick="CheckAll(this.form.playId,this.form.checkbox)"> 
	  [<span class="word_green">全选/反选</span>] [<a style="color:FA6E00;cursor:hand;" onClick="continuePlay(form${sortTypeName}.playId,form${sortTypeName})">歌曲连播</a>] 
	  <div id="ch" style="display:none"> 
		<input name="playId" type="checkbox" class="noborder" value="0"> 
	  </div></td> 
	<!--层ch用于放置隐藏的checkbox控件，因为当表单中只是一个checkbox控件时，应用javascript获得其length属性值为undefine-->
	</tr> 
</table>
  </form></td>
        </tr>
      </table>
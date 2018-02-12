<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<table width="323" height="60" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="27" background="images/main_title.jpg">&nbsp;&nbsp;<span style="font-weight:bold; color:#DD6400"><%=typeArray[i][1]%></span><a style="color:#FA6E00;" href="song.do?action=songQuery&songType_more=<%=typeArray[i][0]%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更多>></a>&nbsp;</td>
  </tr>
 <tr><td height="5px"></td></tr> 
  <tr>
          <td><form name="form<%=i%>" method="post" action="song.do?action=continuePlay" target="_blank">
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr><td height="24" bgcolor="#E7EAE2" class="word_gray">&nbsp;选择</td>
		<td bgcolor="#E7EAE2" class="word_gray">歌曲名称</td>
		<td bgcolor="#E7EAE2" class="word_gray">演唱者</td>
		<td bgcolor="#E7EAE2" class="word_gray">试听</td>
		<td width="5px" bgcolor="#FFFFFF"></td>
		</tr>
	<logic:iterate id="song" name="<%=requestPara%>" type="com.model.SongForm" scope="request" indexId="ind">
      <tr>
	    <td align="center">
	      <input type="checkbox" class="noborder" id="playId" name="playId" value="<bean:write name="song" property="id" filter="true"/>">	    </td>
        <td height="27" class="word_gray1">&nbsp;
        <bean:write name="song" property="songName" filter="true"/></td>
        <td class="word_gray1">&nbsp;
        <bean:write name="song" property="singer" filter="true"/></td>
        <td colspan="2" align="center" class="word_gray1"><a href="#" onClick="window.open('song.do?action=tryListen&id=<bean:write name="song" property="id" filter="true"/>','','width=500,height=360');"><img src="images/tryListen.gif" width="16" height="16" class="noborder"></td>
        </tr>
	</logic:iterate>
  </table>
  <table width="100%"  border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
	
	<td height="24" align="right" style="padding-left:10px;padding-right:5px;color:#505050;"><input name="checkbox" type="checkbox" class="noborder" onClick="CheckAll(this.form.playId,this.form.checkbox)"> 
	  [<span class="word_green">全选/反选</span>] [<a style="color:#FA6E00;cursor:hand;" onClick="continuePlay(form<%=i%>.playId,form<%=i%>)">歌曲连播</a>]&nbsp; 
	  <div id="ch" style="display:none"> 
		<input name="playId" type="checkbox" class="noborder" value="0"> 
	  </div></td> 
	<!--层ch用于放置隐藏的checkbox控件，因为当表单中只是一个checkbox控件时，应用javascript获得其length属性值为undefine-->
	</tr> 
</table>
  </form></td>
        </tr>
</table>

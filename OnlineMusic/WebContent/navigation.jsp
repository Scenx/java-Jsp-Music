<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<div id="navigation">
    <ul style="text-align:center"><li style="float:left;padding:0px 0px 0px 0px"><a href="song.do?action=main" class="navigation">Ê×Ò³</a> |</li> 
<logic:iterate id="song" name="navigation" type="com.model.SongTypeForm" scope="request" indexId="ind">
      <li style="float:left;padding:0px 5px 0px 5px"><a  class="navigation" href="song.do?action=songQuery&songType_more=<bean:write name="song" property="id" filter="true"/>"><bean:write name="song" property="typeName" filter="true"/></a> |</li>
 	</logic:iterate>
	<li style="float:left;padding:5px 15px 0px 15px"><img src="images/navigateion_oa.gif" /></li>	
	</ul>
</div>
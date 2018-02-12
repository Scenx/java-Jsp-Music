<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*" errorPage=""%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<html>
	<head>
		<title>在线音乐_管理员登录_Scen</title>
		<link href="CSS/style.css" rel="stylesheet" />
		<script language="javascript"> 
function check(){
   if(form1.manager.value==""){
     alert("请输入管理员名！");form1.manager.focus();return false;
   }
   if(form1.pwd.value==""){
     alert("请输入密码！");form1.pwd.focus();return false;
   }
}
</script>

	</head>

	<body>
		<jsp:include page="top.jsp" />
		<div id="navigation" style="font-size: 12px; color: #000000">
			→ 欢迎您进入想飞音乐网后台登录页面，请您填写正确的用户名与密码进行后台登录！ 祝您天天有份好心情！
		</div>
		<div id="main" style="padding-top: 5px; margin-bottom: 5px;"
			class="tableBorder_blue">
			<form name="form1" method="post" action="manager.do?action=login"
				onSubmit="return check()">
				<table width="255" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="69" colspan="2" align="center">
							&nbsp;
						</td>
					</tr>
<tr>
	<td width="74" height="30" class="word_gray1">
		管理员名：
	</td>
	<td width="181">
		<input name="manager" type="text" id="manager"
			onFocus="this.style.backgroundColor='#FBFFD9'"
			onBlur="this.style.backgroundColor='#FFFFFF'">
	</td>
</tr>
<tr>
	<td height="30" class="word_gray1">
		密&nbsp;&nbsp;&nbsp;&nbsp;码：
	</td>
	<td>
		<input name="pwd" type="password" id="pwd"
			onFocus="this.style.backgroundColor='#FBFFD9'"
			onBlur="this.style.backgroundColor='#FFFFFF'">
	</td>
</tr>
					<tr>
						<td height="30" colspan="2" align="center">
							<input name="Submit2" type="submit" class="btn_green" value="确定">
							&nbsp;
							<input name="Submit3" type="reset" class="btn_green" value="重置">
						</td>
					</tr>
				</table>

			</form>
		</div>
		<jsp:include page="adm_copyright.jsp" />
	</body>
</html>

<%@ page contentType="text/html; charset=gb2312" language="java"
	import="java.sql.*" errorPage=""%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<html>
	<head>
		<title>��������_����Ա��¼_Scen</title>
		<link href="CSS/style.css" rel="stylesheet" />
		<script language="javascript"> 
function check(){
   if(form1.manager.value==""){
     alert("���������Ա����");form1.manager.focus();return false;
   }
   if(form1.pwd.value==""){
     alert("���������룡");form1.pwd.focus();return false;
   }
}
</script>

	</head>

	<body>
		<jsp:include page="top.jsp" />
		<div id="navigation" style="font-size: 12px; color: #000000">
			�� ��ӭ�����������������̨��¼ҳ�棬������д��ȷ���û�����������к�̨��¼�� ף�������зݺ����飡
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
		����Ա����
	</td>
	<td width="181">
		<input name="manager" type="text" id="manager"
			onFocus="this.style.backgroundColor='#FBFFD9'"
			onBlur="this.style.backgroundColor='#FFFFFF'">
	</td>
</tr>
<tr>
	<td height="30" class="word_gray1">
		��&nbsp;&nbsp;&nbsp;&nbsp;�룺
	</td>
	<td>
		<input name="pwd" type="password" id="pwd"
			onFocus="this.style.backgroundColor='#FBFFD9'"
			onBlur="this.style.backgroundColor='#FFFFFF'">
	</td>
</tr>
					<tr>
						<td height="30" colspan="2" align="center">
							<input name="Submit2" type="submit" class="btn_green" value="ȷ��">
							&nbsp;
							<input name="Submit3" type="reset" class="btn_green" value="����">
						</td>
					</tr>
				</table>

			</form>
		</div>
		<jsp:include page="adm_copyright.jsp" />
	</body>
</html>

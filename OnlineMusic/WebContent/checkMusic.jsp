<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ϵͳ��ʾ</title>
<link href="CSS/style.css" rel="stylesheet">
<script language="javascript">
function action(){
	parent.window.returnValue=${value};
	window.close();
}
</script>
</head>

<body>
<table width="200" height="100" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">&nbsp;${info}</td>
  </tr>
  <tr>
    <td align="center"><input name="Submit2" type="button" class="btn_grey" value="ȷ��" onclick="action()" /></td>
  </tr>
</table>
</body>
</html>
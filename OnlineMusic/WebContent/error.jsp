<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>错误提示</title>
<link href="CSS/style.css" rel="stylesheet">
</head>

<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><table width="419" height="226" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center">&nbsp;&nbsp;错误提示信息： ${error}<br>
              <br>
              <input name="Submit" type="submit" class="btn_grey" value="返回" onClick="history.back(-1)"></td>
      </tr>
    </table></td>
  </tr>
</table>
<center>
</center>
</body>
</html>

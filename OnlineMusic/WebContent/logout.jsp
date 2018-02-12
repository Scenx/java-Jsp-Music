<%@ page contentType="text/html; charset=gbk" language="java"%>
<html>
<head>
<title>Scen</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>

<body>
<%
session.invalidate();
out.println("<script language='javascript'>");
out.println("window.location.href='index.jsp'");
out.println("</script>");
%>	


</body>
</html>

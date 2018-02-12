<%@ page contentType="text/html; charset=gb2312" language="java" %>
<html>
<head>
<title>文件上传</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="CSS/style.css" rel="stylesheet">
</head>
<body>
<form name="form1" enctype="multipart/form-data" method="post" action="upFile_deal.jsp">
  <table width="350" height="150"  border="0" cellpadding="0" cellspacing="0" background="images/upFile_bg.gif">
    <tr>
      <td valign="top"><table width="100%" height="145"  border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="49" colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td width="9%" height="53">&nbsp;</td>
          <td width="91%">请选择上传的歌曲文件：<br>
            <input name="file" type="file" size="35">
            <br>
            注：文件大小请控制在5M以内，格式为MP3和WMA。</td>
        </tr>
        <tr>
          <td colspan="2" align="center"><input name="Submit" type="submit" class="btn_grey" value="提交">
            &nbsp;
            <input name="Submit2" type="button" class="btn_grey" onClick="window.close()" value="关闭"></td>
        </tr>
      </table></td>
    </tr>
  </table>
</form>
</body>
</html>

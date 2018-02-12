<%@ page contentType="text/html; charset=gb2312" language="java"%>
<jsp:useBean id="upFile" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
String fileName_s=request.getParameter("hFileName");
System.out.println("获取的歌曲文件名："+fileName_s);
 upFile.initialize(pageContext);
upFile.upload();
String format=upFile.getFiles().getFile(0).getFileExt();			//获取文件的扩展名，但不包括.号
String fileName=fileName_s.substring(0,fileName_s.lastIndexOf("."))+".lrc";		//重新生成LRC文件名，该名称必须与歌曲文件名相同		
if("lrc".equals(format)){	//判断格式是否合法
	out.println("<script>opener.form1.lrcFileURL.value='"+fileName+"';window.close();</script>");
	try{
		upFile.getFiles().getFile(0).saveAs("/music/"+fileName);
	}catch(Exception e){
		System.out.println("上传文件出现错误："+e.getMessage());
	}
}else{
	out.println("<script>alert('该文件格式不符合要求，不能完成上传！');history.back(-1);</script>");
}
%>
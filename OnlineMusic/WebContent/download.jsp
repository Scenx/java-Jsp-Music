<%@ page contentType="text/html; charset=gb2312" language="java"%>
<jsp:useBean id="upFile" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
try{
	response.reset();
	upFile.initialize(pageContext);						//初始化文件上传下载组件
	upFile.setContentDisposition(null);
	String file=(String)request.getAttribute("fileURL");
	String path=application.getRealPath("/music/"+file);		//获取文件的实际路径
	file=new String(file.getBytes("GBK"), "ISO-8859-1");	//对文件名进行转码
	upFile.downloadFile(path,null,file);//第一个参数为文件路径；第二个参数为类型；第3个参数为在下载对话框中显示的提示文件名
	out.clear();
	out=pageContext.pushBody();
}catch(Exception e){
	request.setAttribute("error","文件下载失败！");%>
	<jsp:forward page="error.jsp"/>
<%}%>

<%@ page contentType="text/html; charset=gb2312" language="java" import="java.text.*,java.util.*"%>
<jsp:useBean id="upFile" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
upFile.initialize(pageContext);			//初始化文件上传下载组件
upFile.upload();
String fileSize=new DecimalFormat("#.##").format(upFile.getFiles().getSize()/1024.00/1024.00)+"M";	//格式化文件大小为两位小数
System.out.println("文件大小"+fileSize);
if(upFile.getFiles().getSize()>5000000){
	out.println("<script>alert('您上传的文件太大，不能完成上传！');history.back(-1);</script>");
}else{
	String format=upFile.getFiles().getFile(0).getFileExt();			//获取文件的扩展名，但不包括.号
	Calendar ca=Calendar.getInstance();
	String fileName=String.valueOf(ca.getTimeInMillis())+"."+format;		//重新生成文件名
	if("mp3".equals(format) || "wma".equals(format)){	//判断格式是否合法
		out.println("<script>opener.form1.fileURL.value='"+fileName+"';opener.form1.fileSize.value='"+fileSize+"';opener.form1.format.value='"+format+"';opener.form1.lrcUp.disabled='';window.close();</script>");		//将上传后的文件名、文件大小和文件类型设置到添加歌曲页面的相应表单元素中，并设置上传歌词的按钮可用
	try{
		upFile.getFiles().getFile(0).saveAs("/music/"+fileName);		//保存文件到服务器
	}catch(Exception e){
		System.out.println("上传文件出现错误："+e.getMessage());
	}
	}else{
		out.println("<script>alert('该文件格式不符合要求，不能完成上传！');history.back(-1);</script>");
	}
}
%>
<%@ page contentType="text/html; charset=gb2312" language="java"%>
<jsp:useBean id="upFile" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
try{
	response.reset();
	upFile.initialize(pageContext);						//��ʼ���ļ��ϴ��������
	upFile.setContentDisposition(null);
	String file=(String)request.getAttribute("fileURL");
	String path=application.getRealPath("/music/"+file);		//��ȡ�ļ���ʵ��·��
	file=new String(file.getBytes("GBK"), "ISO-8859-1");	//���ļ�������ת��
	upFile.downloadFile(path,null,file);//��һ������Ϊ�ļ�·�����ڶ�������Ϊ���ͣ���3������Ϊ�����ضԻ�������ʾ����ʾ�ļ���
	out.clear();
	out=pageContext.pushBody();
}catch(Exception e){
	request.setAttribute("error","�ļ�����ʧ�ܣ�");%>
	<jsp:forward page="error.jsp"/>
<%}%>

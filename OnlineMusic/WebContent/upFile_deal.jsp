<%@ page contentType="text/html; charset=gb2312" language="java" import="java.text.*,java.util.*"%>
<jsp:useBean id="upFile" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
upFile.initialize(pageContext);			//��ʼ���ļ��ϴ��������
upFile.upload();
String fileSize=new DecimalFormat("#.##").format(upFile.getFiles().getSize()/1024.00/1024.00)+"M";	//��ʽ���ļ���СΪ��λС��
System.out.println("�ļ���С"+fileSize);
if(upFile.getFiles().getSize()>5000000){
	out.println("<script>alert('���ϴ����ļ�̫�󣬲�������ϴ���');history.back(-1);</script>");
}else{
	String format=upFile.getFiles().getFile(0).getFileExt();			//��ȡ�ļ�����չ������������.��
	Calendar ca=Calendar.getInstance();
	String fileName=String.valueOf(ca.getTimeInMillis())+"."+format;		//���������ļ���
	if("mp3".equals(format) || "wma".equals(format)){	//�жϸ�ʽ�Ƿ�Ϸ�
		out.println("<script>opener.form1.fileURL.value='"+fileName+"';opener.form1.fileSize.value='"+fileSize+"';opener.form1.format.value='"+format+"';opener.form1.lrcUp.disabled='';window.close();</script>");		//���ϴ�����ļ������ļ���С���ļ��������õ���Ӹ���ҳ�����Ӧ��Ԫ���У��������ϴ���ʵİ�ť����
	try{
		upFile.getFiles().getFile(0).saveAs("/music/"+fileName);		//�����ļ���������
	}catch(Exception e){
		System.out.println("�ϴ��ļ����ִ���"+e.getMessage());
	}
	}else{
		out.println("<script>alert('���ļ���ʽ������Ҫ�󣬲�������ϴ���');history.back(-1);</script>");
	}
}
%>
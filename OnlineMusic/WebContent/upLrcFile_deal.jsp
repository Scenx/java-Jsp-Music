<%@ page contentType="text/html; charset=gb2312" language="java"%>
<jsp:useBean id="upFile" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
String fileName_s=request.getParameter("hFileName");
System.out.println("��ȡ�ĸ����ļ�����"+fileName_s);
 upFile.initialize(pageContext);
upFile.upload();
String format=upFile.getFiles().getFile(0).getFileExt();			//��ȡ�ļ�����չ������������.��
String fileName=fileName_s.substring(0,fileName_s.lastIndexOf("."))+".lrc";		//��������LRC�ļ����������Ʊ���������ļ�����ͬ		
if("lrc".equals(format)){	//�жϸ�ʽ�Ƿ�Ϸ�
	out.println("<script>opener.form1.lrcFileURL.value='"+fileName+"';window.close();</script>");
	try{
		upFile.getFiles().getFile(0).saveAs("/music/"+fileName);
	}catch(Exception e){
		System.out.println("�ϴ��ļ����ִ���"+e.getMessage());
	}
}else{
	out.println("<script>alert('���ļ���ʽ������Ҫ�󣬲�������ϴ���');history.back(-1);</script>");
}
%>
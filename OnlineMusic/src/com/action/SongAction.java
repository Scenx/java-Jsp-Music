package com.action;

import java.io.*;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.struts.action.*;

import com.dao.SongDAO;
import com.model.SongForm;
import com.model.SongTypeForm;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.tools.MyPagination;
import com.tools.StringUtils;

public class SongAction extends Action {
	private SongDAO songDAO = null;
	MyPagination pagination = null;
	StringUtils su=new StringUtils();
	public SongAction() {
		this.songDAO = new SongDAO();

	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String action = request.getParameter("action");
		// System.out.println("\nscrip*********************action="+action);
		if ("main".equals(action)) {
			return main(mapping, form, request, response);				// ǰ̨��ҳ
		} else if ("songQuery".equals(action)) {
			return songQuery(mapping, form, request, response); 		// ��ѯ������Ϣ
		} else if ("tryListen".equals(action)) {
			return tryListen(mapping, form, request, response);			// ��ѯ����������Ϣ
		} else if ("continuePlay".equals(action)) {
			return continuePlay(mapping, form, request, response);		// ���и�������
		} else if ("songSort".equals(action)) {
			return songSort(mapping, form, request, response); 			// �������У����������أ�
		} else if ("navigation".equals(action)) {
			return navigation(mapping, form, request, response); 		// ��ѯ��������Ϣ
		} else if ("search".equals(action)) {
			return search(mapping, form, request, response); 			// ��������ѯ����
		} else if ("download".equals(action)) {
			return download(mapping, form, request, response); 			// �ļ�����
		} else if ("songType".equals(action)) {
			return songType(mapping, form, request, response); 			// ��ѯ�������
		} else if ("adm_search".equals(action)) {
			return adm_search(mapping, form, request, response); 		// ��̨��ѯ������Ϣ
		} else if ("add".equals(action)){
			return adm_add(mapping,form,request,response);				//��Ӹ�����Ϣ
		} else if ("checkMusic".equals(action)){
			return checkMusic(mapping,form,request,response);			//�������Ƿ��Ѿ����
		} else if ("del".equals(action)) {
			return del(mapping, form, request, response); 				// ɾ��������Ϣ
		} else {
			request.setAttribute("error", "����ʧ�ܣ�");
			return mapping.findForward("error");
		}
	}

	// ��ҳ�е��¸��ٵ�
	public ActionForward main(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		List<SongTypeForm> list = songDAO.queryType(); // ��ȡ�������
		int songTypeId = 0;
		String[][] typeName = new String[6][2];
		for (int i = 0; i < list.size(); i++) {
			songTypeId = list.get(i).getId();
			typeName[i][0] = String.valueOf(list.get(i).getId());
			typeName[i][1] = list.get(i).getTypeName();
			request.setAttribute("newSongList" + i, songDAO
					.query("WHERE songType=" + songTypeId
							+ " ORDER BY upTime DESC",5)); // ��ȡ�����ϴ���5�׸���
		}
		request.setAttribute("typeArray", typeName); // ���������Ϣ���鵽Request��
		return mapping.findForward("main");
	}

	// ��������
	public ActionForward songSort(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String type = request.getParameter("sortType");		//��ȡ��ʾ���������л����������еĲ���ֵ
		if ("hits".equals(type)) {
			request.setAttribute("sortType", songDAO
					.query(" ORDER BY hits DESC",8)); // ��ȡ����������Ϣ
		} else if ("download".equals(type)) {
			request.setAttribute("sortType", songDAO
					.query(" ORDER BY download DESC",8)); // ��ȡ����������Ϣ
		}
		request.setAttribute("sortTypeName", type);
		RequestDispatcher requestDispatcher = request
				.getRequestDispatcher("/songSort.jsp");		//��ҳ���ض��򵽸������а�ҳ��
		try {
			requestDispatcher.include(request, response); // �˴�����ʹ��forward()����
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// ��ȡ��������Ϣ
	public ActionForward navigation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("navigation", songDAO.queryType()); // ��ȡ���������Ϣ
		RequestDispatcher requestDispatcher = request
				.getRequestDispatcher("/navigation.jsp");
		try {
			requestDispatcher.include(request, response); // �˴�����ʹ��forward()����
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// ���Ҹ����б�
	public ActionForward songQuery(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String strPage = (String) request.getParameter("Page");
		int songType = Integer.parseInt(request.getParameter("songType_more")); // Ҫ�鿴�ĸ������
		int Page = 1;
		List<SongForm> list = null;
		if (strPage == null) {
			pagination = new MyPagination();
			list = songDAO.query(" WHERE s.songType=" + songType
					+ " ORDER BY s.upTime DESC"); // ��ȡ������Ϣ
			int pagesize = 2; // ָ��ÿҳ��ʾ�ļ�¼��
			list = pagination.getInitPage(list, Page, pagesize); // ��ʼ����ҳ��Ϣ
			request.getSession().setAttribute("pagination", pagination);
		} else {
			pagination = (MyPagination) request.getSession().getAttribute(
					"pagination");
			Page = pagination.getPage(strPage);
			list = pagination.getAppointPage(Page); // ��ȡָ��ҳ����
		}
		if (list.size() > 0) {
			request.setAttribute("typeName", list.get(0).getSongType()); // ��ȡ�������
			request.setAttribute("typeID", list.get(0).getSongTypeId()); // ��ȡ�������ID
		}
		request.setAttribute("songList", list); // ���浱ǰҳ�ĸ�����Ϣ
		request.setAttribute("Page", Page); // ����ĵ�ǰҳ��
		return mapping.findForward("songQuery");
	}

	// ��������ѯ����
	public ActionForward search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String strPage = (String) request.getParameter("Page");
		int songType = Integer.parseInt(request.getParameter("songType_more")); // Ҫ�鿴�ĸ������
		String fieldName = request.getParameter("fieldName"); // ��ȡ��ѯ����
		String key = request.getParameter("key"); // ��ȡ��ѯ�ؼ���
		System.out.println("��ȡ�Ĳ�ѯ������" + key + fieldName + songType);
		String condition = "";
		String fieldName_cn = "";
		if (songType > 0 && fieldName != null) {
			condition = " WHERE s.songType=" + songType + " AND s." + fieldName
					+ " LIKE '%" + key + "%' ORDER BY s.upTime DESC";
		} else if (songType > 0) {
			condition = " WHERE s.songType=" + songType
					+ " ORDER BY s.upTime DESC";
		} else if (fieldName != null) {
			condition = " WHERE s." + fieldName + " LIKE '%" + key
					+ "%' ORDER BY s.upTime DESC";
		} else {
			condition = " ORDER BY s.upTime DESC";
		}
		if ("songName".equals(fieldName)) {
			fieldName_cn = "������";
		} else if ("specialName".equals(fieldName)) {
			fieldName_cn = "ר��";
		} else if ("singer".equals(fieldName)) {
			fieldName_cn = "����";
		}
		int Page = 1;
		List<SongForm> list = null;
		if (strPage == null) {
			pagination = new MyPagination();
			list = songDAO.query(condition); // ��ȡ������Ϣ
			int pagesize = 2; // ָ��ÿҳ��ʾ�ļ�¼��
			list = pagination.getInitPage(list, Page, pagesize); // ��ʼ����ҳ��Ϣ
			request.getSession().setAttribute("pagination", pagination);
		} else {
			pagination = (MyPagination) request.getSession().getAttribute(
					"pagination");
			Page = pagination.getPage(strPage);
			list = pagination.getAppointPage(Page); // ��ȡָ��ҳ����
		}
		if (list.size() > 0) {
			if (songType > 0) {
				// request.setAttribute("queryKey",list.get(0).getSongType());
				// //��ȡ�������
				request.setAttribute("queryKey", "��ѯ���Ϊ["
						+ list.get(0).getSongType() + "] ��ѯ����Ϊ[" + fieldName_cn
						+ "]����ѯ�ؼ���Ϊ[" + key + "]");
			} else {
				request.setAttribute("queryKey", "��ѯ���Ϊ[ȫ��] ��ѯ����Ϊ["
						+ fieldName_cn + "]����ѯ�ؼ���Ϊ[" + key + "]");
			}
			request.setAttribute("typeID", list.get(0).getSongTypeId()); // ��ȡ�������ID
		}
		request.setAttribute("songList", list); // ���浱ǰҳ�ĸ�����Ϣ
		request.setAttribute("Page", Page); // ����ĵ�ǰҳ��
		return mapping.findForward("search");
	}

	// ����
	public ActionForward tryListen(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
			int id = Integer.parseInt(request.getParameter("id"));
		String[] urlAndName = songDAO.tryListen(id); // ������ĵ�һ��Ԫ��Ϊ�������ƣ��ڶ���Ԫ��Ϊ�������ļ���
		/** **************��ȡ���************************* */
		String lrcRealPath = request.getRealPath("/");
		String mp3RealPath = lrcRealPath.substring(0, lrcRealPath.lastIndexOf("/") + 1)+ "music/" + urlAndName[1];
		request.setAttribute("realPath", mp3RealPath);
		lrcRealPath = lrcRealPath+ "music/"+ urlAndName[1].substring(0, urlAndName[1].lastIndexOf(".") + 1)+ "lrc"; // lrc�ļ�·��
		File lrcFile = new File(lrcRealPath);
		songDAO.holdoutAdd(id); // ������������1
		String content = "";
		int lineNumber = 0;
		if (lrcFile.exists()) {
			FileInputStream lrcf;
			try {
				lrcf = new FileInputStream(lrcRealPath);
				int rs = 0;
				byte[] data = new byte[lrcf.available()]; // available()�������Բ��������شӴ��������ж�ȡ�����������Ĺ���ʣ���ֽ���
				while ((rs = lrcf.read(data)) > 0) {
					content += new String(data, 0, rs);
				}
				StringTokenizer st = new StringTokenizer(content, "\\[*\\]"); // �����ַ����й��������ٸ������Ŷԡ�[]��
				lineNumber = st.countTokens(); // ���ط����Ľ��
				// lineNumber=content.split("\\[*\\]").length;
				System.out.println("SSSSSSSSSSS:" + lineNumber);
				// System.out.println("������ݣ�"+content);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/** ********************************************* */

		request.setAttribute("lineNumber", lineNumber); // �����ʵ�����
		request.setAttribute("lrcContent", content); // ����������
		request.setAttribute("fileURL", urlAndName[1]); // ���浱ǰҳ�ĸ�����Ϣ
		request.setAttribute("songName", urlAndName[0]); // ���浱ǰ�����ĸ�������
		return mapping.findForward("tryListen");
	}

	// ��������
	public ActionForward continuePlay(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		// String ID[]=request.getParameterValues("playid"); //��ȡҪ���ŵĸ���ID
		SongForm songForm = (SongForm) form;
		String playID = "";
		//��Ҫ���ŵĸ���ID����Ϊһ���Զ��ŷָ����ַ���
		for (int i = 0; i < songForm.getPlayId().length; i++) {
			playID = playID + songForm.getPlayId()[i] + ",";
		}
		playID = playID.substring(0, playID.length() - 1);		//ȥ��β���Ķ���
		String realPath = request.getRealPath("/");
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.lastIndexOf("/") + 1) + "music/";
		System.out.println("Ҫ���Ӳ��ŵĸ���ID��" + playID);
		request.setAttribute("songNameList", songDAO.continuePlay(playID, url,
				"ORDER BY upTime DESC")); // ��������
		return mapping.findForward("continuePlay");
	}

	// ����
	public ActionForward download(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		/*******************************��ֹ������***********************/
		String from=request.getHeader("referer");
	/*	if((from==null) || (from.indexOf("localhost:8080/01/")<0)){
			request.setAttribute("error","�벻Ҫ��������վ����Դ�������http://www.mrbccd.com�������أ�");
			return mapping.findForward("error");
		}else{*/
		/**************************************************************/
			int id = Integer.parseInt(request.getParameter("id"));
			String fileURL = songDAO.getFileURL(id);
	//		System.out.println("�ļ����Ե�ַ��" + request.getRealPath("/music/" + fileURL));
			File file = new File(request.getRealPath("/music/" + fileURL));
			if (file.exists()) {
				request.setAttribute("fileURL", fileURL); // ����������ļ���
				songDAO.downloadAdd(id); // ������ش���
			} else {
				request.setAttribute("error", "�ܱ�Ǹ���ø����ļ������ڣ�");
				return mapping.findForward("error");
			}
			return mapping.findForward("download");
		//}
	}

	/** ***********************************��������Ϊ��̨������****************************************** */
	// ��ѯ�������
	public ActionForward songType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		List<SongTypeForm> list = songDAO.queryType();
		request.setAttribute("songTypeList", list); // ������������Ϣ
		RequestDispatcher requestDispatcher = request
				.getRequestDispatcher("/adm_search.jsp");
		try {
			requestDispatcher.include(request, response); // �˴�����ʹ��forward()����
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// ��̨��ѯ����
	public ActionForward adm_search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String strPage = (String) request.getParameter("Page");
		String condition = "";
		int songType = 0;
		String fieldName_cn = "";
		String typeName = "";
		String key = "";
		String fieldName = "";
		if (request.getParameter("songType_more") != null) {
			songType = Integer.parseInt(request.getParameter("songType_more")); // Ҫ�鿴�ĸ������
			fieldName = request.getParameter("fieldName"); // ��ȡ��ѯ����
			key = request.getParameter("key"); // ��ȡ��ѯ�ؼ���
			System.out.println("��ȡ�Ĳ�ѯ������" + key + fieldName + songType);
			if (songType > 0 && fieldName != null) {
				condition = " WHERE s.songType=" + songType + " AND s."
						+ fieldName + " LIKE '%" + key
						+ "%' ORDER BY s.upTime DESC";
			} else if (songType > 0) {
				condition = " WHERE s.songType=" + songType
						+ " ORDER BY s.upTime DESC";
			} else if (fieldName != null && !"".equals(fieldName)) {
				condition = " WHERE s." + fieldName + " LIKE '%" + key
						+ "%' ORDER BY s.upTime DESC";
			} else {
				condition = " ORDER BY s.upTime DESC";
			}
			System.out.println("������" + condition);
			if ("songName".equals(fieldName)) {
				fieldName_cn = "������";
			} else if ("specialName".equals(fieldName)) {
				fieldName_cn = "ר��";
			} else if ("singer".equals(fieldName)) {
				fieldName_cn = "����";
			}
			typeName = songDAO.queryType(songType); // ��ȡ�������
		} else {
			condition = " ORDER BY s.upTime DESC";
		}
		int Page = 1;
		List<SongForm> list = null;
		if (strPage == null) {
			pagination = new MyPagination();
			list = songDAO.query(condition); // ��ȡ������Ϣ
			int pagesize = 2; // ָ��ÿҳ��ʾ�ļ�¼��
			list = pagination.getInitPage(list, Page, pagesize); // ��ʼ����ҳ��Ϣ
			request.getSession().setAttribute("pagination", pagination);
		} else {
			pagination = (MyPagination) request.getSession().getAttribute(
					"pagination");
			Page = pagination.getPage(strPage);
			list = pagination.getAppointPage(Page); // ��ȡָ��ҳ����
		}
		if (list.size() > 0) {
			if (songType > 0) {
				request.setAttribute("queryKey", "��ѯ���Ϊ[" + typeName
						+ "] ��ѯ����Ϊ[" + fieldName_cn + "]����ѯ�ؼ���Ϊ[" + key + "]");
			} else {
				request.setAttribute("queryKey", "��ѯ���Ϊ[ȫ��] ��ѯ����Ϊ["
						+ fieldName_cn + "]����ѯ�ؼ���Ϊ[" + key + "]");
			}
		}
		request.setAttribute("songList", list); // ���浱ǰҳ�ĸ�����Ϣ
		request.setAttribute("songType_more", songType);
		request.setAttribute("key", key);
		request.setAttribute("fieldName", fieldName);
		request.setAttribute("Page", Page); // ����ĵ�ǰҳ��
		return mapping.findForward("adm_search");
	}
	//��Ӹ���
	public ActionForward adm_add(ActionMapping mapping, ActionForm form,
	HttpServletRequest request, HttpServletResponse response) {
		SongForm songForm = (SongForm) form;
		songForm.setSongName(su.StringtoSql(songForm.getSongName()));		//��������
		songForm.setSinger(su.StringtoSql(songForm.getSinger()));			//�ݳ���
		songForm.setSpecialName(su.StringtoSql(songForm.getSpecialName()));	//ר����
		int rtn=songDAO.insert(songForm);		//���������Ϣ�����ݿ�
		if(rtn>0){
			request.setAttribute("info", "������ӳɹ���");
		}else{
			request.setAttribute("error","�������ʧ�ܣ�");
		}
		return mapping.findForward("addok");		//��ҳ����ת����Ӹ������ҳ��
	}
	//���Ը����Ƿ��Ѿ����
	public ActionForward checkMusic(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String songName=su.toGBK(request.getParameter("songName"));
		String singer=su.toGBK(request.getParameter("singer"));
		int rtn=songDAO.checkMusic(songName,singer);
		if(rtn==1){
			request.setAttribute("info", "�ø���û�б���ӣ�");
		}else{
			request.setAttribute("info","�ø����Ѿ�����ӣ�");
		}
		request.setAttribute("value", rtn);
		return mapping.findForward("checkMusic");
	}	
	//ɾ������
	public ActionForward del(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt((String) request.getParameter("id"));
		int songType = 0;
		String fieldName = "";
		String key = "";
		if (request.getParameter("songType_more") != null) {
			songType = Integer.parseInt(request.getParameter("songType_more")); // Ҫ�鿴�ĸ������
			fieldName = request.getParameter("fieldName");		// ��ȡ��ѯ����
			key = request.getParameter("key");		// ��ȡ��ѯ�ؼ���
		}
		request.setAttribute("para", "&songType_more=" + songType
				+ "&fieldName=" + fieldName + "&key=" + key);
		String fileURL = songDAO.getFileURL(id);				//��ȡ�ļ�·��
		String lrcFileURL=fileURL.substring(0,fileURL.lastIndexOf("."))+".lrc";		//��ɸ���ļ�������
		// ɾ������
		int rtn=songDAO.del(id); //�����ݿ���ɾ��������Ϣ
		if (rtn == 0) {
			request.setAttribute("error", "����ɾ��ʧ�ܣ�");
			return mapping.findForward("error");
		} else {
			request.setAttribute("info", "����ɾ���ɹ���");
			// ɾ���ļ�
			File file = new File(request.getRealPath("/music/" + fileURL));
			File lrcFile=new File(request.getRealPath("/music/"+lrcFileURL));
			if(lrcFile.exists()){
				lrcFile.delete();	//ɾ������ļ�
			}
			if (file.exists()) {
				file.delete(); // ɾ�������ļ�
			} else {
				request.setAttribute("info", "����ɾ���ɹ�������Ӧ�ļ�û�ҵ���");
			}
		}
		return mapping.findForward("delok");
	}
}

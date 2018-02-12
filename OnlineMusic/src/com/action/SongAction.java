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
			return main(mapping, form, request, response);				// 前台首页
		} else if ("songQuery".equals(action)) {
			return songQuery(mapping, form, request, response); 		// 查询歌曲信息
		} else if ("tryListen".equals(action)) {
			return tryListen(mapping, form, request, response);			// 查询试听歌曲信息
		} else if ("continuePlay".equals(action)) {
			return continuePlay(mapping, form, request, response);		// 进行歌曲连播
		} else if ("songSort".equals(action)) {
			return songSort(mapping, form, request, response); 			// 歌曲排行（试听和下载）
		} else if ("navigation".equals(action)) {
			return navigation(mapping, form, request, response); 		// 查询导航栏信息
		} else if ("search".equals(action)) {
			return search(mapping, form, request, response); 			// 按条件查询歌曲
		} else if ("download".equals(action)) {
			return download(mapping, form, request, response); 			// 文件下载
		} else if ("songType".equals(action)) {
			return songType(mapping, form, request, response); 			// 查询歌曲类别
		} else if ("adm_search".equals(action)) {
			return adm_search(mapping, form, request, response); 		// 后台查询歌曲信息
		} else if ("add".equals(action)){
			return adm_add(mapping,form,request,response);				//添加歌曲信息
		} else if ("checkMusic".equals(action)){
			return checkMusic(mapping,form,request,response);			//检测歌曲是否已经添加
		} else if ("del".equals(action)) {
			return del(mapping, form, request, response); 				// 删除歌曲信息
		} else {
			request.setAttribute("error", "操作失败！");
			return mapping.findForward("error");
		}
	}

	// 主页中的新歌速递
	public ActionForward main(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		List<SongTypeForm> list = songDAO.queryType(); // 获取歌曲类别
		int songTypeId = 0;
		String[][] typeName = new String[6][2];
		for (int i = 0; i < list.size(); i++) {
			songTypeId = list.get(i).getId();
			typeName[i][0] = String.valueOf(list.get(i).getId());
			typeName[i][1] = list.get(i).getTypeName();
			request.setAttribute("newSongList" + i, songDAO
					.query("WHERE songType=" + songTypeId
							+ " ORDER BY upTime DESC",5)); // 获取最新上传的5首歌曲
		}
		request.setAttribute("typeArray", typeName); // 保存类别信息数组到Request中
		return mapping.findForward("main");
	}

	// 歌曲排行
	public ActionForward songSort(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String type = request.getParameter("sortType");		//获取表示是试听排行还是下载排行的参数值
		if ("hits".equals(type)) {
			request.setAttribute("sortType", songDAO
					.query(" ORDER BY hits DESC",8)); // 获取试听排行信息
		} else if ("download".equals(type)) {
			request.setAttribute("sortType", songDAO
					.query(" ORDER BY download DESC",8)); // 获取下载排行信息
		}
		request.setAttribute("sortTypeName", type);
		RequestDispatcher requestDispatcher = request
				.getRequestDispatcher("/songSort.jsp");		//将页面重定向到歌曲排行榜页面
		try {
			requestDispatcher.include(request, response); // 此处不能使用forward()方法
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// 获取导航栏信息
	public ActionForward navigation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("navigation", songDAO.queryType()); // 获取歌曲类别信息
		RequestDispatcher requestDispatcher = request
				.getRequestDispatcher("/navigation.jsp");
		try {
			requestDispatcher.include(request, response); // 此处不能使用forward()方法
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// 查找歌曲列表
	public ActionForward songQuery(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String strPage = (String) request.getParameter("Page");
		int songType = Integer.parseInt(request.getParameter("songType_more")); // 要查看的歌曲类别
		int Page = 1;
		List<SongForm> list = null;
		if (strPage == null) {
			pagination = new MyPagination();
			list = songDAO.query(" WHERE s.songType=" + songType
					+ " ORDER BY s.upTime DESC"); // 获取歌曲信息
			int pagesize = 2; // 指定每页显示的记录数
			list = pagination.getInitPage(list, Page, pagesize); // 初始化分页信息
			request.getSession().setAttribute("pagination", pagination);
		} else {
			pagination = (MyPagination) request.getSession().getAttribute(
					"pagination");
			Page = pagination.getPage(strPage);
			list = pagination.getAppointPage(Page); // 获取指定页数据
		}
		if (list.size() > 0) {
			request.setAttribute("typeName", list.get(0).getSongType()); // 获取歌曲类别
			request.setAttribute("typeID", list.get(0).getSongTypeId()); // 获取歌曲类别ID
		}
		request.setAttribute("songList", list); // 保存当前页的歌曲信息
		request.setAttribute("Page", Page); // 保存的当前页码
		return mapping.findForward("songQuery");
	}

	// 按条件查询歌曲
	public ActionForward search(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String strPage = (String) request.getParameter("Page");
		int songType = Integer.parseInt(request.getParameter("songType_more")); // 要查看的歌曲类别
		String fieldName = request.getParameter("fieldName"); // 获取查询依据
		String key = request.getParameter("key"); // 获取查询关键字
		System.out.println("获取的查询条件：" + key + fieldName + songType);
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
			fieldName_cn = "歌曲名";
		} else if ("specialName".equals(fieldName)) {
			fieldName_cn = "专辑";
		} else if ("singer".equals(fieldName)) {
			fieldName_cn = "歌手";
		}
		int Page = 1;
		List<SongForm> list = null;
		if (strPage == null) {
			pagination = new MyPagination();
			list = songDAO.query(condition); // 获取歌曲信息
			int pagesize = 2; // 指定每页显示的记录数
			list = pagination.getInitPage(list, Page, pagesize); // 初始化分页信息
			request.getSession().setAttribute("pagination", pagination);
		} else {
			pagination = (MyPagination) request.getSession().getAttribute(
					"pagination");
			Page = pagination.getPage(strPage);
			list = pagination.getAppointPage(Page); // 获取指定页数据
		}
		if (list.size() > 0) {
			if (songType > 0) {
				// request.setAttribute("queryKey",list.get(0).getSongType());
				// //获取歌曲类别
				request.setAttribute("queryKey", "查询类别为["
						+ list.get(0).getSongType() + "] 查询依据为[" + fieldName_cn
						+ "]，查询关键字为[" + key + "]");
			} else {
				request.setAttribute("queryKey", "查询类别为[全部] 查询依据为["
						+ fieldName_cn + "]，查询关键字为[" + key + "]");
			}
			request.setAttribute("typeID", list.get(0).getSongTypeId()); // 获取歌曲类别ID
		}
		request.setAttribute("songList", list); // 保存当前页的歌曲信息
		request.setAttribute("Page", Page); // 保存的当前页码
		return mapping.findForward("search");
	}

	// 试听
	public ActionForward tryListen(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
			int id = Integer.parseInt(request.getParameter("id"));
		String[] urlAndName = songDAO.tryListen(id); // 该数组的第一个元素为歌曲名称，第二个元素为歌曲的文件名
		/** **************获取歌词************************* */
		String lrcRealPath = request.getRealPath("/");
		String mp3RealPath = lrcRealPath.substring(0, lrcRealPath.lastIndexOf("/") + 1)+ "music/" + urlAndName[1];
		request.setAttribute("realPath", mp3RealPath);
		lrcRealPath = lrcRealPath+ "music/"+ urlAndName[1].substring(0, urlAndName[1].lastIndexOf(".") + 1)+ "lrc"; // lrc文件路径
		File lrcFile = new File(lrcRealPath);
		songDAO.holdoutAdd(id); // 将试听次数加1
		String content = "";
		int lineNumber = 0;
		if (lrcFile.exists()) {
			FileInputStream lrcf;
			try {
				lrcf = new FileInputStream(lrcRealPath);
				int rs = 0;
				byte[] data = new byte[lrcf.available()]; // available()方法可以不受阻塞地从此输入流中读取（或跳过）的估计剩余字节数
				while ((rs = lrcf.read(data)) > 0) {
					content += new String(data, 0, rs);
				}
				StringTokenizer st = new StringTokenizer(content, "\\[*\\]"); // 分析字符串中共包括多少个中括号对“[]”
				lineNumber = st.countTokens(); // 返回分析的结果
				// lineNumber=content.split("\\[*\\]").length;
				System.out.println("SSSSSSSSSSS:" + lineNumber);
				// System.out.println("歌词内容："+content);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		/** ********************************************* */

		request.setAttribute("lineNumber", lineNumber); // 保存歌词的行数
		request.setAttribute("lrcContent", content); // 保存歌词内容
		request.setAttribute("fileURL", urlAndName[1]); // 保存当前页的歌曲信息
		request.setAttribute("songName", urlAndName[0]); // 保存当前试听的歌曲名称
		return mapping.findForward("tryListen");
	}

	// 连续播放
	public ActionForward continuePlay(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		// String ID[]=request.getParameterValues("playid"); //获取要播放的歌曲ID
		SongForm songForm = (SongForm) form;
		String playID = "";
		//将要播放的歌曲ID连接为一个以逗号分隔的字符串
		for (int i = 0; i < songForm.getPlayId().length; i++) {
			playID = playID + songForm.getPlayId()[i] + ",";
		}
		playID = playID.substring(0, playID.length() - 1);		//去除尾部的逗号
		String realPath = request.getRealPath("/");
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.lastIndexOf("/") + 1) + "music/";
		System.out.println("要连接播放的歌曲ID：" + playID);
		request.setAttribute("songNameList", songDAO.continuePlay(playID, url,
				"ORDER BY upTime DESC")); // 连续播放
		return mapping.findForward("continuePlay");
	}

	// 下载
	public ActionForward download(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		/*******************************防止被盗链***********************/
		String from=request.getHeader("referer");
	/*	if((from==null) || (from.indexOf("localhost:8080/01/")<0)){
			request.setAttribute("error","请不要盗链本网站的资源，请访问http://www.mrbccd.com进行下载！");
			return mapping.findForward("error");
		}else{*/
		/**************************************************************/
			int id = Integer.parseInt(request.getParameter("id"));
			String fileURL = songDAO.getFileURL(id);
	//		System.out.println("文件绝对地址：" + request.getRealPath("/music/" + fileURL));
			File file = new File(request.getRealPath("/music/" + fileURL));
			if (file.exists()) {
				request.setAttribute("fileURL", fileURL); // 保存歌曲的文件名
				songDAO.downloadAdd(id); // 添加下载次数
			} else {
				request.setAttribute("error", "很抱歉，该歌曲文件不存在！");
				return mapping.findForward("error");
			}
			return mapping.findForward("download");
		//}
	}

	/** ***********************************以下内容为后台处理方法****************************************** */
	// 查询歌曲类别
	public ActionForward songType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		List<SongTypeForm> list = songDAO.queryType();
		request.setAttribute("songTypeList", list); // 保存歌曲类别信息
		RequestDispatcher requestDispatcher = request
				.getRequestDispatcher("/adm_search.jsp");
		try {
			requestDispatcher.include(request, response); // 此处不能使用forward()方法
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// 后台查询歌曲
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
			songType = Integer.parseInt(request.getParameter("songType_more")); // 要查看的歌曲类别
			fieldName = request.getParameter("fieldName"); // 获取查询依据
			key = request.getParameter("key"); // 获取查询关键字
			System.out.println("获取的查询条件：" + key + fieldName + songType);
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
			System.out.println("条件：" + condition);
			if ("songName".equals(fieldName)) {
				fieldName_cn = "歌曲名";
			} else if ("specialName".equals(fieldName)) {
				fieldName_cn = "专辑";
			} else if ("singer".equals(fieldName)) {
				fieldName_cn = "歌手";
			}
			typeName = songDAO.queryType(songType); // 获取类别名称
		} else {
			condition = " ORDER BY s.upTime DESC";
		}
		int Page = 1;
		List<SongForm> list = null;
		if (strPage == null) {
			pagination = new MyPagination();
			list = songDAO.query(condition); // 获取歌曲信息
			int pagesize = 2; // 指定每页显示的记录数
			list = pagination.getInitPage(list, Page, pagesize); // 初始化分页信息
			request.getSession().setAttribute("pagination", pagination);
		} else {
			pagination = (MyPagination) request.getSession().getAttribute(
					"pagination");
			Page = pagination.getPage(strPage);
			list = pagination.getAppointPage(Page); // 获取指定页数据
		}
		if (list.size() > 0) {
			if (songType > 0) {
				request.setAttribute("queryKey", "查询类别为[" + typeName
						+ "] 查询依据为[" + fieldName_cn + "]，查询关键字为[" + key + "]");
			} else {
				request.setAttribute("queryKey", "查询类别为[全部] 查询依据为["
						+ fieldName_cn + "]，查询关键字为[" + key + "]");
			}
		}
		request.setAttribute("songList", list); // 保存当前页的歌曲信息
		request.setAttribute("songType_more", songType);
		request.setAttribute("key", key);
		request.setAttribute("fieldName", fieldName);
		request.setAttribute("Page", Page); // 保存的当前页码
		return mapping.findForward("adm_search");
	}
	//添加歌曲
	public ActionForward adm_add(ActionMapping mapping, ActionForm form,
	HttpServletRequest request, HttpServletResponse response) {
		SongForm songForm = (SongForm) form;
		songForm.setSongName(su.StringtoSql(songForm.getSongName()));		//歌曲名称
		songForm.setSinger(su.StringtoSql(songForm.getSinger()));			//演唱者
		songForm.setSpecialName(su.StringtoSql(songForm.getSpecialName()));	//专辑名
		int rtn=songDAO.insert(songForm);		//保存歌曲信息到数据库
		if(rtn>0){
			request.setAttribute("info", "歌曲添加成功！");
		}else{
			request.setAttribute("error","歌曲添加失败！");
		}
		return mapping.findForward("addok");		//将页面跳转到添加歌曲完成页面
	}
	//测试歌曲是否已经添加
	public ActionForward checkMusic(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String songName=su.toGBK(request.getParameter("songName"));
		String singer=su.toGBK(request.getParameter("singer"));
		int rtn=songDAO.checkMusic(songName,singer);
		if(rtn==1){
			request.setAttribute("info", "该歌曲没有被添加！");
		}else{
			request.setAttribute("info","该歌曲已经被添加！");
		}
		request.setAttribute("value", rtn);
		return mapping.findForward("checkMusic");
	}	
	//删除歌曲
	public ActionForward del(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt((String) request.getParameter("id"));
		int songType = 0;
		String fieldName = "";
		String key = "";
		if (request.getParameter("songType_more") != null) {
			songType = Integer.parseInt(request.getParameter("songType_more")); // 要查看的歌曲类别
			fieldName = request.getParameter("fieldName");		// 获取查询依据
			key = request.getParameter("key");		// 获取查询关键字
		}
		request.setAttribute("para", "&songType_more=" + songType
				+ "&fieldName=" + fieldName + "&key=" + key);
		String fileURL = songDAO.getFileURL(id);				//获取文件路径
		String lrcFileURL=fileURL.substring(0,fileURL.lastIndexOf("."))+".lrc";		//组成歌词文件的名称
		// 删除数据
		int rtn=songDAO.del(id); //从数据库中删除歌曲信息
		if (rtn == 0) {
			request.setAttribute("error", "歌曲删除失败！");
			return mapping.findForward("error");
		} else {
			request.setAttribute("info", "数据删除成功！");
			// 删除文件
			File file = new File(request.getRealPath("/music/" + fileURL));
			File lrcFile=new File(request.getRealPath("/music/"+lrcFileURL));
			if(lrcFile.exists()){
				lrcFile.delete();	//删除歌词文件
			}
			if (file.exists()) {
				file.delete(); // 删除歌曲文件
			} else {
				request.setAttribute("info", "数据删除成功，但对应文件没找到！");
			}
		}
		return mapping.findForward("delok");
	}
}

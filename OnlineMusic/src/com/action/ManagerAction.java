package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.model.ManagerForm;
import com.dao.ManagerDAO;
import com.tools.MyPagination;

public class ManagerAction extends Action {
	private ManagerDAO managerDAO = null;

	public ManagerAction() {
		this.managerDAO = new ManagerDAO();

	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String action = request.getParameter("action");
		if ("login".equals(action)) {
			return login(mapping, form, request, response); // 管理员登录
		} else {
			request.setAttribute("error", "操作失败！");
			return mapping.findForward("error");
		}
	}
public ActionForward login(ActionMapping mapping, ActionForm form,
		HttpServletRequest request, HttpServletResponse response){
       ManagerForm managerForm = (ManagerForm) form;
        int ret = managerDAO.login(managerForm);
        System.out.print("验证结果ret的值:" + ret);
        if (ret == 1) {
            HttpSession session=request.getSession();
            session.setAttribute("manager",managerForm.getManager());
            return mapping.findForward("managerLoginok");
        } else {
            request.setAttribute("error","您输入的管理员名称或密码错误！");
            return mapping.findForward("error");
	        }
	}
}

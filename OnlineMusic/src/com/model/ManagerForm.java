package com.model;

import org.apache.struts.action.ActionForm;

public class ManagerForm extends ActionForm {
	public int id = 0;						// 编号
	public String manager = "";				// 管理员名
	public String pwd = ""; 				// 密码
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}	
}

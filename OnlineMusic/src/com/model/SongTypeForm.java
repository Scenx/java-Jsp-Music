package com.model;

import org.apache.struts.action.ActionForm;

public class SongTypeForm extends ActionForm {
	public int id = 0;						// ���ͱ��
	public String typeName = "";			// ��������


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
}


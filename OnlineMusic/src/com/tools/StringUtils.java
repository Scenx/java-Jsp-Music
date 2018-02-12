package com.tools;

public class StringUtils {
	
	public String toGBK(String strvalue) {
		try {
			if (strvalue == null) {			//������strvalueΪnullʱ
				return "";					//���ؿյ��ַ���
			} else {
				strvalue = new String(strvalue.getBytes("ISO-8859-1"), "GBK");//���ַ���ת��ΪGBK����
				return strvalue;			//����ת������������strvalue
			}
		} catch (Exception e) {
			return "";
		}
	}

	// ��������ַ�������һ�α���ת������ֹSQLע��
	public String StringtoSql(String str) {
		if (str == null) {				//������strΪnullʱ
			return "";					//���ؿյ��ַ���
		} else {
			try {
				str = str.trim().replace('\'', (char) 32);	//��'��ת����Ϊ�ո�
			} catch (Exception e) {
				return "";
			}
		}
		return str;
	}
}


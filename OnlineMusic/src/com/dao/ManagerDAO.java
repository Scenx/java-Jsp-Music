package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.ManagerForm;
import com.tools.ConnDB;

public class ManagerDAO {
	private ConnDB conn;

	public ManagerDAO() {
		conn = new ConnDB();
	}
	//��֤����Ա��ݵķ���������Ϊ1��ʾ��¼�ɹ��������ʾ��¼ʧ��
	public int login(ManagerForm m){
        int flag = 0;
        String sql = "SELECT * FROM tb_manager where manager='" +
                     m.getManager() + "'";
        ResultSet rs = conn.executeQuery(sql);
        try {
            if (rs.next()) {
                String pwd = m.getPwd();
                if (pwd.equals(rs.getString(3))) {
                    flag = 1;
                    rs.last();
                    int rowSum = rs.getRow();
                    rs.first();
                    if (rowSum != 1) {
                        flag = 0;
                        System.out.print("��ȡ��row��ֵ��" + sql + rowSum);
                    }
                } else {
                    flag = 0;
                }
            }else{
                flag = 0;
            }
        } catch (SQLException ex) {
            flag = 0;
        }
        return flag;
	}
}

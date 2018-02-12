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
	//验证管理员身份的方法，返回为1表示登录成功，否则表示登录失败
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
                        System.out.print("获取的row的值：" + sql + rowSum);
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

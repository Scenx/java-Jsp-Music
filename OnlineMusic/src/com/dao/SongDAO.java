package com.dao;

import com.model.SongForm;
import com.model.SongTypeForm;
import com.tools.ConnDB;
import java.util.*;
import java.sql.*;

public class SongDAO {
	private ConnDB conn;

	public SongDAO() {
		conn = new ConnDB();
	}
	// ��ѯ�����Ϣ������ֵΪList���ϣ����ڱ����ѯ���������Ϣ
	public List<SongTypeForm> queryType() {
		List<SongTypeForm> list = new ArrayList<SongTypeForm>();
		String sql = "SELECT * FROM tb_songType limit 0,6";
		ResultSet rs = conn.executeQuery(sql);
		try {
			while (rs.next()) {
				SongTypeForm stF = new SongTypeForm();
				stF.setId(rs.getInt(1));
				stF.setTypeName(rs.getString(2));
				list.add(stF);		 // �������Ϣ���浽List������
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();
		return list;
	}
	// �������ID��ѯ�������
	public String queryType(int id) {
		String sql = "SELECT * FROM tb_songType WHERE id="+id+"";
		ResultSet rs = conn.executeQuery(sql);
		String typeName="";
		try {
			while (rs.next()) {
				typeName=rs.getString(2);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();
		return typeName;
	}
	// ��ѯ������Ϣ������ֵΪList���ϣ����ڱ����ѯ���ĸ�����Ϣ
	public List<SongForm> query(String condition) {
		List<SongForm> list = new ArrayList<SongForm>();
		String sql = "";
		if (condition == null) {
			sql = "SELECT * FROM tb_song s INNER JOIN tb_songType t ON s.songType=t.id";
		} else {
			sql = "SELECT s.*,t.typeName FROM tb_song s INNER JOIN tb_songType t ON s.songType=t.id " + condition;
		}
		ResultSet rs = conn.executeQuery(sql);
		try {
			while (rs.next()) {
				SongForm songF = new SongForm();
				songF.setId(rs.getInt(1));
				songF.setSongName(rs.getString(2));
				songF.setSinger(rs.getString(3));
				songF.setSpecialName(rs.getString(4));
				songF.setFileSize(rs.getString(5));
				songF.setFileURL(rs.getString(6));
				songF.setFormat(rs.getString(7));
				songF.setHits(rs.getInt(8));
				songF.setDownload(rs.getInt(9));
				songF.setUpTime(rs.getDate(10));
				songF.setSongTypeId(rs.getInt(11));
				songF.setSongType(rs.getString(12));
				songF.setSongName_short(songF.getSongName());
				list.add(songF);		 // ��������Ϣ���浽List������
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();
		return list;
	}
	// ��ѯ������Ϣ������ֵΪList���ϣ����ڱ����ѯ���ĸ�����Ϣ
	public List<SongForm> query(String condition,int top) {
		List<SongForm> list = new ArrayList<SongForm>();
		String sql = "SELECT  * from tb_song " + condition +" limit 0,"+top;
		ResultSet rs = conn.executeQuery(sql);			//ִ�в�ѯ���
		try {
			while (rs.next()) {
				SongForm songF = new SongForm();
				songF.setId(rs.getInt(1));				//����ID
				songF.setSongName(rs.getString(2));		//��������
				songF.setSinger(rs.getString(3));		//�ݳ���
				songF.setHits(rs.getInt(8));			//��������
				songF.setDownload(rs.getInt(9));		//���ش���
				songF.setSongName_short(songF.getSongName());	//��ȡ��ĸ�������
				list.add(songF);		 // ��������Ϣ���浽List������
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();				//�ر����ݿ�����
		return list;
	}
	//��ȡ����������Ϣ
	public String[] tryListen(int id) {
		String sql = "SELECT * FROM tb_song WHERE id="+id+"";
		ResultSet rs = conn.executeQuery(sql);
		String[] urlAndName=new String[2];
		String fileURL="";
		String songName="";
		try {
			if (rs.next()) {
				songName = rs.getString(2);
				fileURL=rs.getString(6);
				urlAndName[0]=songName;
				urlAndName[1]=fileURL;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("��ȡ������Ϣ��ʾ�ĳ�����Ϣ��" + e.getMessage());
		}
		conn.close();
		return urlAndName;
	}

	// ��Ӹ���
	public int insert(SongForm sf) {
		int flag=0;
		String sql="";
		try {
			sql = "INSERT INTO tb_song (id,songName,singer,specialname,fileSize,fileURL,format,upTime,songType) VALUES(null,'"+sf.getSongName()+"','"+sf.getSinger()+"','"+sf.getSpecialName()+"','"+sf.getFileSize()+"','"+sf.getFileURL()+"','"+sf.getFormat()+"',now(),"+sf.getSongTypeId()+")";
			flag = conn.executeUpdate(sql);
		} catch (RuntimeException e) {
			e.printStackTrace();
			System.out.println("�����SQL��䣺"+sql);
		}
		conn.close();		//�ر����ݿ�����
		return flag;
	}
	//���Ը����Ƿ��Ѿ����
	public int checkMusic(String songName,String singer){
		int rtn=1;
		String sql="SELECT * FROM tb_song WHERE songName='"+songName+"' AND singer='"+singer+"'";
		System.out.println(sql);
		ResultSet rs=conn.executeQuery(sql);
		try {
			if(rs.next()){
				rtn=0;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtn=0;
		}
		return rtn;
	}
	// �����������
	public int holdoutAdd(int id) {
		String sql = "UPDATE tb_song SET hits=hits+1 WHERE id=" + id + "";
		int rtn=conn.executeUpdate(sql);
		conn.close();
		return rtn;
	}
	// ������ش���
	public int downloadAdd(int id) {
		String sql1 = "UPDATE tb_song SET download=download+1 WHERE id=" + id + "";
		int rtn=conn.executeUpdate(sql1);
		conn.close();
		return rtn;
	}
	public String getFileURL(int id){
		String sql = "SELECT * FROM tb_song WHERE id="+id+"";
		ResultSet rs = conn.executeQuery(sql);
		String fileURL="";
		try {
			if (rs.next()) {
				fileURL=rs.getString(6);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("��ȡ������Ϣ��ʾ�ĳ�����Ϣ��" + e.getMessage());
		}
		conn.close();
		return fileURL;
	}
	//��������
	public  List<SongForm>  continuePlay(String playId,String url,String condition){
		List<SongForm> list = new ArrayList<SongForm>();
		String sql="SELECT * FROM tb_song WHERE id IN ("+playId+") "+condition;
		System.out.println("����SQL��䣺"+sql);
		ResultSet rs = conn.executeQuery(sql);
		try {
			while (rs.next()) {
				SongForm songF = new SongForm();
				songF.setId(rs.getInt(1));
				songF.setSongName(rs.getString(2));
				songF.setSinger(rs.getString(3));
				songF.setSpecialName(rs.getString(4));
				songF.setFileSize(rs.getString(5));
				songF.setFileURL(url+rs.getString(6));
				songF.setFormat(rs.getString(7));
				songF.setHits(rs.getInt(8));
				songF.setDownload(rs.getInt(9));
				songF.setUpTime(rs.getDate(10));
				list.add(songF);		 // ��ѡ��ĸ�����Ϣ���浽List������
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();
		return list;
	}
	// ɾ������
	public int del(int id) {
		int rtn=0;
		try{
			String sql = "DELETE FROM tb_song WHERE id=" + id + "";
			rtn=conn.executeUpdate(sql);
		}catch(Exception e){
			System.out.println("ɾ��������Ϣ�Ĵ�����ʾ��Ϣ��"+e.getMessage());
			rtn=0;
		}
		conn.close();
		return rtn;
	}
}

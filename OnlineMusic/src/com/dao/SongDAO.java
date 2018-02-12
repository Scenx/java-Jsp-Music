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
	// 查询类别信息，返回值为List集合，用于保存查询到的类别信息
	public List<SongTypeForm> queryType() {
		List<SongTypeForm> list = new ArrayList<SongTypeForm>();
		String sql = "SELECT * FROM tb_songType limit 0,6";
		ResultSet rs = conn.executeQuery(sql);
		try {
			while (rs.next()) {
				SongTypeForm stF = new SongTypeForm();
				stF.setId(rs.getInt(1));
				stF.setTypeName(rs.getString(2));
				list.add(stF);		 // 将类别信息保存到List集合中
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();
		return list;
	}
	// 根据类别ID查询类别名称
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
	// 查询歌曲信息，返回值为List集合，用于保存查询到的歌曲信息
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
				list.add(songF);		 // 将歌曲信息保存到List集合中
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();
		return list;
	}
	// 查询歌曲信息，返回值为List集合，用于保存查询到的歌曲信息
	public List<SongForm> query(String condition,int top) {
		List<SongForm> list = new ArrayList<SongForm>();
		String sql = "SELECT  * from tb_song " + condition +" limit 0,"+top;
		ResultSet rs = conn.executeQuery(sql);			//执行查询语句
		try {
			while (rs.next()) {
				SongForm songF = new SongForm();
				songF.setId(rs.getInt(1));				//歌曲ID
				songF.setSongName(rs.getString(2));		//歌曲名称
				songF.setSinger(rs.getString(3));		//演唱者
				songF.setHits(rs.getInt(8));			//试听次数
				songF.setDownload(rs.getInt(9));		//下载次数
				songF.setSongName_short(songF.getSongName());	//截取后的歌曲名称
				list.add(songF);		 // 将歌曲信息保存到List集合中
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();				//关闭数据库连接
		return list;
	}
	//获取试听歌曲信息
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
			System.out.println("获取试听信息显示的出错信息：" + e.getMessage());
		}
		conn.close();
		return urlAndName;
	}

	// 添加歌曲
	public int insert(SongForm sf) {
		int flag=0;
		String sql="";
		try {
			sql = "INSERT INTO tb_song (id,songName,singer,specialname,fileSize,fileURL,format,upTime,songType) VALUES(null,'"+sf.getSongName()+"','"+sf.getSinger()+"','"+sf.getSpecialName()+"','"+sf.getFileSize()+"','"+sf.getFileURL()+"','"+sf.getFormat()+"',now(),"+sf.getSongTypeId()+")";
			flag = conn.executeUpdate(sql);
		} catch (RuntimeException e) {
			e.printStackTrace();
			System.out.println("出错的SQL语句："+sql);
		}
		conn.close();		//关闭数据库连接
		return flag;
	}
	//测试歌曲是否已经添加
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
	// 添加试听次数
	public int holdoutAdd(int id) {
		String sql = "UPDATE tb_song SET hits=hits+1 WHERE id=" + id + "";
		int rtn=conn.executeUpdate(sql);
		conn.close();
		return rtn;
	}
	// 添加下载次数
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
			System.out.println("获取试听信息显示的出错信息：" + e.getMessage());
		}
		conn.close();
		return fileURL;
	}
	//连续播放
	public  List<SongForm>  continuePlay(String playId,String url,String condition){
		List<SongForm> list = new ArrayList<SongForm>();
		String sql="SELECT * FROM tb_song WHERE id IN ("+playId+") "+condition;
		System.out.println("生成SQL语句："+sql);
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
				list.add(songF);		 // 将选择的歌曲信息保存到List集合中
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		conn.close();
		return list;
	}
	// 删除歌曲
	public int del(int id) {
		int rtn=0;
		try{
			String sql = "DELETE FROM tb_song WHERE id=" + id + "";
			rtn=conn.executeUpdate(sql);
		}catch(Exception e){
			System.out.println("删除歌曲信息的错误提示信息："+e.getMessage());
			rtn=0;
		}
		conn.close();
		return rtn;
	}
}

package com.model;

import org.apache.struts.action.ActionForm;
import java.util.*;

public class SongForm extends ActionForm {
	public int id = 0;						// 歌曲编号
	public String songName = "";			// 歌曲名称
	public String singer = ""; 				// 演唱者
	public String specialName = "";			// 专辑名称
	public String fileSize = ""; 			// 文件大小
	public String fileURL = ""; 			// 文件路径
	public String format = ""; 				// 文件格式
	public int hits = 0;					// 试听次数
	public int download = 0;				// 下载次数
	public Date upTime=null;				// 上传时间
	public String playId[]=new String[0];	//要播放歌曲的ID
	public int songTypeId=0;				//歌曲类别ID
	public String songType ="";				//歌曲类别
	public String songName_short="";		//截取后的歌曲名

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSongName() {
		return songName;
	}

	public void setSongName(String songName) {
		this.songName = songName;
	}

	public String getSinger() {
		return singer;
	}

	public void setSinger(String singer) {
		this.singer = singer;
	}

	public String getSpecialName() {
		return specialName;
	}

	public void setSpecialName(String specialName) {
		this.specialName = specialName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileURL() {
		return fileURL;
	}

	public void setFileURL(String fileURL) {
		this.fileURL = fileURL;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public int getDownload() {
		return download;
	}

	public void setDownload(int download) {
		this.download = download;
	}
	
	public Date getUpTime(){
		return upTime;
	}
	
	public void setUpTime(Date upTime){
		this.upTime=upTime;
	}
	
	public String[] getPlayId(){
		return playId;
	}
	public void setPlayId(String[] playId){
		this.playId=playId;
	}

	public int getSongTypeId() {
		return songTypeId;
	}

	public void setSongTypeId(int songTypeId) {
		this.songTypeId = songTypeId;
	}

	public String getSongType() {
		return songType;
	}

	public void setSongType(String songType) {
		this.songType = songType;
	}
	
	public String getSongName_short() {
		return songName_short;
	}

	public void setSongName_short(String songName_short) {
		this.songName_short = StringSubStr(songName_short,12);
	}
	
	public String StringSubStr(String str,int len){
		if(str==null){
			return "";
		}else{		//获取字符串的实际长度，并进行截取
			byte temp[];
			int reallen=0;
			for(int i=0;i<str.length();i++){
				temp=(str.substring(i,i+1)).getBytes();
				reallen+=temp.length;		//累加字符串的长度
				if(reallen>len){
					str=str.substring(0,i);	//截取指定长度的字符串
					break;					//跳出for循环
				}
			}
		}
		return str;
	}
}

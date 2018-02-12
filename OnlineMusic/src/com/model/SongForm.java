package com.model;

import org.apache.struts.action.ActionForm;
import java.util.*;

public class SongForm extends ActionForm {
	public int id = 0;						// �������
	public String songName = "";			// ��������
	public String singer = ""; 				// �ݳ���
	public String specialName = "";			// ר������
	public String fileSize = ""; 			// �ļ���С
	public String fileURL = ""; 			// �ļ�·��
	public String format = ""; 				// �ļ���ʽ
	public int hits = 0;					// ��������
	public int download = 0;				// ���ش���
	public Date upTime=null;				// �ϴ�ʱ��
	public String playId[]=new String[0];	//Ҫ���Ÿ�����ID
	public int songTypeId=0;				//�������ID
	public String songType ="";				//�������
	public String songName_short="";		//��ȡ��ĸ�����

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
		}else{		//��ȡ�ַ�����ʵ�ʳ��ȣ������н�ȡ
			byte temp[];
			int reallen=0;
			for(int i=0;i<str.length();i++){
				temp=(str.substring(i,i+1)).getBytes();
				reallen+=temp.length;		//�ۼ��ַ����ĳ���
				if(reallen>len){
					str=str.substring(0,i);	//��ȡָ�����ȵ��ַ���
					break;					//����forѭ��
				}
			}
		}
		return str;
	}
}

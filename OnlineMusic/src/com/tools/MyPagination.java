package com.tools;

import java.util.ArrayList;
import java.util.List;

import com.model.SongForm;


public class MyPagination {
	public List<SongForm> list=null;
	private int recordCount=0;
	private int pagesize=0;
	private int maxPage=0;

	//��ʼ����ҳ��Ϣ
	public List<SongForm> getInitPage(List<SongForm> list,int Page,int pagesize){
		List<SongForm> newList=new ArrayList<SongForm>();
		this.list=list;
		recordCount=list.size();
		this.pagesize=pagesize;
		this.maxPage=getMaxPage();
		try{
		for(int i=(Page-1)*pagesize;i<=Page*pagesize-1;i++){
			try{
				if(i>=recordCount){break;}
			}catch(Exception e){}
			newList.add((SongForm)list.get(i));
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		return newList;
	}
	//��ȡָ��ҳ������
	public List<SongForm> getAppointPage(int Page){
		List<SongForm> newList=new ArrayList<SongForm>();
		try{
			for(int i=(Page-1)*pagesize;i<=Page*pagesize-1;i++){
				try{
					if(i>=recordCount){break;}
				}catch(Exception e){}
				newList.add((SongForm)list.get(i));
			}
			}catch(Exception e){
				e.printStackTrace();
			}
			return newList;
	}
	//��ȡ����¼��
	public int getMaxPage(){
		int maxPage=(recordCount%pagesize==0)?(recordCount/pagesize):(recordCount/pagesize+1);
		return maxPage;
	}
	//��ȡ�ܼ�¼��
	public int getRecordSize(){
		return recordCount;
	}
	
	//��ȡ��ǰҳ��
	public int getPage(String str){
		System.out.println("STR:"+str+"&&&&"+recordCount);
		if(str==null){
			str="0";
		}
		int Page=Integer.parseInt(str);
		if(Page<1){
			Page=1;
		}else{
			if(((Page-1)*pagesize+1)>recordCount){
				Page=maxPage;
			}
		}
		return Page;
	}

	public String printCtrl(int Page,String url,String para){
		String strHtml="<table width='100%'  border='0' cellspacing='0' cellpadding='0'><tr> <td height='24' align='right'>��ǰҳ����["+Page+"/"+maxPage+"]&nbsp;";
		try{
		if(Page>1){
			strHtml=strHtml+"<a href='"+url+"&Page=1"+para+"'>��һҳ</a>��";
			strHtml=strHtml+"<a href='"+url+"&Page="+(Page-1)+para+"'>��һҳ</a>";
		}
		if(Page<maxPage){
			strHtml=strHtml+"<a href='"+url+"&Page="+(Page+1)+para+"'>��һҳ</a>��<a href='"+url+"&Page="+maxPage+para+"'>���һҳ&nbsp;</a>";
		}
		strHtml=strHtml+"</td> </tr>	</table>";
		}catch(Exception e){
			e.printStackTrace();
		}
		return strHtml;
	}	
}

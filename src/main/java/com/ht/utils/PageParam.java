package com.ht.utils;

public class PageParam {
	 
	private transient Integer page;      //页码
	
	private transient Integer limit;		// 查询记录数
	
	private transient Integer start;		//	起始页

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public Integer getStart() {
		return page!=null&&limit!=null?(page-1)*limit:null;
	}

	public void setStart(Integer start) {
		this.start = start;
	}
	
	
	

}

package com.kaika.model;

public class CardVO extends Card{

	private int page;
	
	private int rows;
	
	private int start;
	
	private String startTime;
	
	private String endTime;
	
	
	@Override
	public String toString() {
		return "CardVO [page=" + page + ", rows=" + rows + ", start=" + start + ", startTime=" + startTime
				+ ", endTime=" + endTime + "]";
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getStart() {
		return (page-1) * rows;
	}
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}
	

}

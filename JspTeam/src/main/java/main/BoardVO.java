package main;

import java.sql.Date;

public class BoardVO {
	private String title;
	private String name;
	private String contents;
	
	public BoardVO() {
		System.out.println("BoardVO 생성자호출");
	}
	
	

	public BoardVO(String title, String name, String contents) {
		super();
		this.title = title;
		this.name = name;
		this.contents = contents;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getContents() {
		return contents;
	}



	public void setContents(String contents) {
		this.contents = contents;
	}



}
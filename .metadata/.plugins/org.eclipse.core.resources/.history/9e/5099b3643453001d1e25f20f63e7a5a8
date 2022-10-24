package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	protected DataSource dataFactory;
	protected Connection conn;
	protected PreparedStatement pstmt;
	
	private final String BOARD_UPDATE_QUERY = "UPDATE board_t (category, title, contents, goods_name)"
			+ " VALUES (?, ?, ?, ?)";
	
	
	public BoardDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected PreparedStatement dbQuery(String query) {
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pstmt;
	}
	
	protected ResultSet dbRead (PreparedStatement pstmt)  {
		ResultSet rs;
		try {
			rs = pstmt.executeQuery();
			return rs ;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
	protected void dbUpdate()  {
		try {
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		 
		 
	protected void dbClose()  {
		
		try {
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	

	
	
	
	
	public void updateArticle (BoardVO boardVO) {
		System.out.println("updateArticle() 수행합니다");
		int num_aticle = boardVO.getNum_aticle();		//auto_inc
		String nickname = boardVO.getNickname(); 		//not null
		String category = boardVO.getCategory(); 		//not null
		String title = boardVO.getTitle();    			//not null
		String contents = boardVO.getContents(); 		//not null
		String deal_status = boardVO.getDeal_status();	//not null
		Date upload = boardVO.getUpload(); 				//default
		String goods_name = boardVO.getGoods_name(); 	//not null
		int num_cmnt = boardVO.getNum_cmnt(); 		 	//null ok
		// 추가 작업요망 String goods_img = boardVO.getGoods_img();
		try {
			conn = dataFactory.getConnection();
			//이미지 추가 수정부분 1미만 업데이트 금지(이미지는 최소 1장이상 등록해주세요)
			System.out.println("==================================");
			System.out.println("BOARD_INSERT 쿼리문 = [ " + BOARD_UPDATE_QUERY + " ]");
			pstmt = conn.prepareStatement(BOARD_UPDATE_QUERY);
			//"UPDATE board_t (category, title, contents, goods_name) VALUES (?, ?, ?, ?)";
			pstmt.setString(1, category);
			pstmt.setString(2, title);
			pstmt.setString(3, contents);
			pstmt.setString(4, goods_name);
			System.out.println("board_t 들어가는 내용 = [ 카테고리: " + category + ", 제목: " + title
					+ ", 내용: " + contents + ", 상품명: " + goods_name + " ]");
			System.out.println("==================================");
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			String err = "!!! updateArticle() 에러 !!!";
			System.out.println(err);
			e.printStackTrace();
		}
	}
	

	
	

}

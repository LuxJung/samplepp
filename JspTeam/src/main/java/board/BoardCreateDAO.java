package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardCreateDAO {
	
	private final String BOARD_INSERT_QUERY = "INSERT INTO board_t (nickname, category, title, contents, goods_name)"
			+ " VALUES (?, ?, ?, ?, ?); ";
	private final String BOARD_NUMBERUNG_QUERY = "SELECT num_aticle FROM board_t ORDER BY num_aticle DESC LIMIT 1;";
	private final String BOARD_INSERT_IMG_QUERY = "INSERT INTO goods_T (num_aticle, price, goods_img) "
			+"VALUES (?, ?, ?);";

	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;
	
	public BoardCreateDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int createArticle(BoardVO bd) {
		try {
			System.out.println("BOARD_INSERT 쿼리문 = [ " + BOARD_INSERT_QUERY + " ]");
			String nickname = bd.getNickname();
			String category = bd.getCategory();
			String title = bd.getTitle();
			String contents = bd.getContents();
			String goods_name = bd.getGoods_name();
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(BOARD_INSERT_QUERY);
			
			pstmt.setString(1, nickname);
			pstmt.setString(2, category);
			pstmt.setString(3, title);
			pstmt.setString(4, contents);
			pstmt.setString(5, goods_name);
			
			System.out.println("board_t 들어가는 내용 = [ 닉네임: " + nickname + ", 카테고리: " + category + ", 제목: " + title
					+ ", 내용: " + contents + ", 상품명: " + goods_name + " ]");
			System.out.println("==================================");
			
			pstmt = conn.prepareStatement(BOARD_NUMBERUNG_QUERY);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			int setnum = rs.getInt("num_aticle");
			System.out.println(setnum);
			rs.close();
			bd.setNum_aticle(setnum);
			System.out.println("goods_T 마지막 번호 = [ 새로운 글번호: " + bd.getNum_aticle() + " ]");
			System.out.println("==================================");
			
			
			System.out.println("BOARD_INSERT_IMG_QUERY 쿼리문 = [ " + BOARD_INSERT_IMG_QUERY + " ]");
			int num = bd.getNum_aticle();
			int price = bd.getPrice();
			String goods_img = bd.getGoods_img();
			pstmt = conn.prepareStatement(BOARD_INSERT_IMG_QUERY);
			pstmt.setInt(1, num);
			pstmt.setInt(2, price);
			pstmt.setString(3, goods_img);
			System.out.println("goods_T 들어가는 내용 = [ 글번호: " + num + ", 가격: " + price 
					+ ", 이미지경로: " + goods_img + " ]");
			System.out.println("==================================");
			
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			return setnum;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bd.getNum_aticle();
		
	}
	
	public int createArticleNum(BoardVO bd) {
		try {
			System.out.println("BOARD_NUMBERUNG_QUERY 쿼리문 = [ " + BOARD_NUMBERUNG_QUERY + " ]");	
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(BOARD_INSERT_QUERY);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			int setnum = rs.getInt("num_aticle");
			System.out.println(setnum);
			
			rs.close();
			bd.setNum_aticle(setnum);
			pstmt.close();
			conn.close();
			System.out.println("goods_T 마지막 번호 = [ 새로운 글번호: " + bd.getNum_aticle() + " ]");
			System.out.println("==================================");
			return setnum;			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bd.getNum_aticle();
		
	}
	
	public void createArticleImg(BoardVO bd) {
		try {
			System.out.println("BOARD_INSERT_IMG_QUERY 쿼리문 = [ " + BOARD_INSERT_IMG_QUERY + " ]");
			int num = bd.getNum_aticle();
			int price = bd.getPrice();
			String goods_img = bd.getGoods_img();
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(BOARD_INSERT_IMG_QUERY);
			pstmt.setInt(1, num);
			pstmt.setInt(2, price);
			pstmt.setString(3, goods_img);
			System.out.println("goods_T 들어가는 내용 = [ 글번호: " + num + ", 가격: " + price 
					+ ", 이미지경로: " + goods_img + " ]");
			System.out.println("==================================");
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
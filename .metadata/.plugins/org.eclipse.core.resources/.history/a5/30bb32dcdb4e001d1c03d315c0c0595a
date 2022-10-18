package main;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;

	public BoardDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//게시판 리스트 뿌려주기
	public List<BoardVO> listBoard() {
		List<BoardVO> boardList = new ArrayList<>();
		try {
			conn = dataFactory.getConnection();
			String query = "select * from  board_t";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int num_aticle = rs.getInt("num_aticle");
				String nickname = rs.getString("nickname");
				String category = rs.getString("category");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				int intdeal_status = rs.getInt("deal_status");
				Date upload = rs.getDate("upload");
				String goods_name = rs.getString("goods_name");
				int num_cmnt = rs.getInt("num_cmnt");
				String deal_status = null;
				if(intdeal_status ==0) {
					deal_status = "판매중";
				}else if(intdeal_status ==1) {
					deal_status = "예약중";
				}else {
					deal_status = "판매완료";
				}
				BoardVO BoardVO = new BoardVO(num_aticle, nickname, category, title, 
									contents, deal_status, upload, goods_name, num_cmnt);
				boardList.add(BoardVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return boardList;
	}
	
	public List<BoardVO> selectAllArticles(){
		List<BoardVO> atriclesList = new ArrayList<>();
		try {
			conn = dataFactory.getConnection();
			String query = "SELECT num_aticle, nickname, title, deal_status, upload FROM board_t";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int num_aticle = rs.getInt("num_aticle");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				int intdeal_status = rs.getInt("deal_status");
				String deal_status = null;
				if(intdeal_status ==0) {
					deal_status = "판매중";
				}else if(intdeal_status ==1) {
					deal_status = "예약중";
				}else {
					deal_status = "판매완료";
				}
				Date upload = rs.getDate("upload");
				BoardVO BoardVO = new BoardVO(num_aticle, nickname,  
										title, deal_status, upload);
				atriclesList.add(BoardVO);
			}
			for (BoardVO boardVO : atriclesList) {
				System.out.print("boardList 확인 - 닉네임 : "+boardVO.getNickname()+" | ");
		        System.out.println("글제목 : "+boardVO.getTitle());
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return atriclesList;	
	}

	public void insertNewArticle(BoardVO board) {
		System.out.println("insertNewArticle 시작하냐?");
		try {
			conn = dataFactory.getConnection();
			System.out.println("insertNewArticle 시작하는데~?");
			int num_aticle = board.getNum_aticle();
			String nickname = board.getNickname();
			String category = board.getCategory();
			String title = board.getTitle();
			String contents = board.getContents();
			String deal_status = board.getDeal_status();
			Date upload = board.getUpload();
			String goods_name = board.getGoods_name();
			String imageFileName = board.getGoods_img();
			int num_cmnt = board.getNum_cmnt();
			String query = "INSERT INTO board_t (num_aticle, nickname, category, "
					+ "title, contents, deal_status, upload, goods_name, num_cmnt)"
					+ " VALUES (?, ? , ?, ?, ?, ?, ?, ?, ?)";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, num_aticle);
			pstmt.setString(2, nickname);
			pstmt.setString(3, category);
			pstmt.setString(4, title);
			pstmt.setString(5, contents);
			pstmt.setInt(6, Integer.parseInt(deal_status));
			pstmt.setDate(7, upload); // 날짜 반환 실패!!!!!!!!!!!!!!!!!!!!!!
			pstmt.setString(8, goods_name);
			pstmt.setInt(9, num_cmnt);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
}

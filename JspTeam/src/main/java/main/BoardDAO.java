package main;

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

	
}

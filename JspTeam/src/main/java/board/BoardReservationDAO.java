package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardReservationDAO {
	private final String BOARD_DEALUPDATE_QUERY = "UPDATE board_t SET deal_status=? "
			+ " WHERE nickname=? AND num_aticle=?;";
	private DataSource dataFactory;
	private Connection conn;
	private PreparedStatement pstmt;

	public BoardReservationDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public BoardVO reservate (BoardVO boardVO) {
		int num_aticle = boardVO.getNum_aticle();
		String nickname = boardVO.getNickname(); 
		int int_deal_status = 0;
		String String_deal_status = boardVO.getDeal_status();
		if ( String_deal_status.equals("판매중")) {
			int_deal_status = 0;
		} else if (String_deal_status.equals("예약중")) {
			int_deal_status = 1;
		} else {
			int_deal_status = 2;
		}
		try {
			conn = dataFactory.getConnection();
			System.out.println("==================================");
			System.out.println("BOARD_DEALUPDATE_QUERY 쿼리문 = [ " + BOARD_DEALUPDATE_QUERY + " ]");
			pstmt = conn.prepareStatement(BOARD_DEALUPDATE_QUERY);
			pstmt.setInt(1, int_deal_status);
			pstmt.setString(2, nickname);
			pstmt.setInt(3, num_aticle);
			
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return boardVO;
	}
}

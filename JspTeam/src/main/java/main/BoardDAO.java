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

	public List<BoardVO> listBoard() {
		List<BoardVO> boardsList = new ArrayList<>();
		try {
			conn = dataFactory.getConnection();
			String query = "select * from  board";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String name = rs.getString("name");
				String contents = rs.getString("contents");
				BoardVO BoardVO = new BoardVO(title, name, contents);
				boardsList.add(BoardVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return boardsList;
	}

	public void addMember(BoardVO bd) {
		try {
			conn = dataFactory.getConnection();
			String title = bd.getTitle();
			String name = bd.getName();
			String contents = bd.getContents();
			String query = "INSERT INTO t_member(title, name, contents)" + " VALUES(?, ? ,?)";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, name);
			pstmt.setString(3, contents);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

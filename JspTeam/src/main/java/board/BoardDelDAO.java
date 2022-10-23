package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDelDAO extends BoardDAO{
	private static String ARTICLE_IMAGE_REPO =  "D:\\JSP\\JSP_Workspace\\DbTest\\JspTeam\\src\\main\\webapp\\WEB-INF\\imgs";
	private final String BOARD_DELETE_VIEW_QUERY =  "DELETE FROM bt, gt "
			+ "USING board_t bt LEFT JOIN goods_t gt "
			+ "ON gt.num_aticle = bt.num_aticle "
			+ "WHERE gt.num_aticle=?";
	
	public BoardDelDAO() {
		super();
	}
	
	public List<Integer> delBoard(int num_aticle) {
		List<Integer> atriclesList = new ArrayList<>();

		try {
			System.out.println("==================================");
			System.out.println("BOARD_DELETE_VIEW_QUERY 쿼리문 = [ " + BOARD_DELETE_VIEW_QUERY + " ]");
			pstmt=dbQuery(BOARD_DELETE_VIEW_QUERY);
			pstmt.setInt(1, num_aticle);
			ResultSet rs = dbRead(pstmt);
			while(rs.next()) {
				num_aticle = rs.getInt("num_aticle");
				atriclesList.add(num_aticle);
			}
			dbUpdate();
			dbClose();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return atriclesList;
	}
}

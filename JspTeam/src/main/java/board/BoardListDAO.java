package board;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardListDAO {
	private final String BOARD_LIST_VIEW_QUERY = "SELECT num_aticle, nickname, title, deal_status, upload FROM board_t";

	public BoardListDAO() {
		super();

	}
	
	public List<BoardVO> boardListArticles() {
		List<BoardVO> atriclesList = new ArrayList<>();
		try {
			System.out.println("BOARD_LIST_VIEW_QUERY 쿼리문 = [ " + BOARD_LIST_VIEW_QUERY + " ]");
			
			ResultSet rs = BoardConnectDB.dbRead(BoardConnectDB.dbQuery(BOARD_LIST_VIEW_QUERY));
			while (rs.next()) {
				int num_aticle = rs.getInt("num_aticle");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				int intdeal_status = rs.getInt("deal_status");
				String deal_status = null; //거래상태 문자형 반환해주기 위함
				if (intdeal_status == 0) {
					deal_status = "판매중";
				} else if (intdeal_status == 1) {
					deal_status = "예약중";
				} else {
					deal_status = "판매완료";
				}
				Date upload = rs.getDate("upload");
				BoardVO BoardVO = new BoardVO(num_aticle, nickname, title, deal_status, upload);
				atriclesList.add(BoardVO);
			}
			for (BoardVO boardVO : atriclesList) {
				System.out.print(
						"boardList 확인 = [ 넘버링 :"+boardVO.getNum_aticle()+" | 닉네임 : " + boardVO.getNickname() + " | 글제목 : " + boardVO.getTitle() + " ]");
				System.out.println();
			}
			System.out.println("==================================");
			rs.close();
			BoardConnectDB.dbClose();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return atriclesList;
	}
}
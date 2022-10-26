package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardListDAO {
	private final String BOARD_LIST_VIEW_QUERY = "SELECT num_aticle, nickname, title, deal_status, upload FROM board_t";
	private final String BOARD_LIST_PAGERVIEW_QUERY = "select * from ("
			+ "	select row_number() over(order by num_aticle desc) as 'recNum',"
			+ "	num_aticle, nickname, title, deal_status, contents, upload, goods_name"
			+ "	from board_t"
			+ "	where num_aticle) as cnt"
			+ " where cnt.recNum between(?-1)*100+(?-1)*10+1 and (?-1)*100+?*10";
	Connection conn;
	PreparedStatement pstmt;
	private DataSource dataFactory;
	public BoardListDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}

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
	
	public List<BoardVO> selectAllArticles(Map<?, ?> pagingMap){
		List<BoardVO> articlesList = new ArrayList<BoardVO>();
		int section = (Integer)pagingMap.get("section");
		int pageNum=(Integer)pagingMap.get("pageNum");
		try{
		                  
			System.out.println("BOARD_LIST_PAGERVIEW_QUERY 쿼리문 = [ " + BOARD_LIST_PAGERVIEW_QUERY + " ]");
			
			conn = dataFactory.getConnection();
			pstmt= conn.prepareStatement(BOARD_LIST_PAGERVIEW_QUERY);
			pstmt.setInt(1, section);
			pstmt.setInt(2, pageNum);
			pstmt.setInt(3, section);
			pstmt.setInt(4, pageNum);
			ResultSet rs =pstmt.executeQuery();
		   while(rs.next()){
		      int articleNO = rs.getInt("num_aticle");
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
		      Date upload= rs.getDate("upload");
		      
		      BoardVO article = new BoardVO();
		      
		      article.setNum_aticle(articleNO);
		      article.setNickname(nickname);
		      article.setTitle(title);
		      article.setDeal_status(deal_status);
		      article.setUpload(upload);
		      articlesList.add(article);	
		      System.out.println("페이징부분 저장된 vo"+ article.getNum_aticle()+" / "+article.getNickname());
		   } //end while
		   rs.close();
		   pstmt.close();
		   conn.close();
	  }catch(Exception e){
	     e.printStackTrace();	
	  }
	  return articlesList;
    } 
	public int selectTotArticles() {
		try {
			conn = dataFactory.getConnection();
			String query = "select count(num_aticle) from board_t ";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				System.out.println("rs.next() 있음");
				System.out.println(rs.getInt(1));
				return (rs.getInt(1));
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}
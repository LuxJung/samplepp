package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardUpdateDAO extends BoardConnectDB{
	private  String ARTICLE_IMAGE_REPO =  "D:\\JSP\\JSP_Workspace\\DbTest\\JspTeam\\src\\main\\webapp\\WEB-INF\\imgs";
	private final String BOARD_UPDATE_QUERY = "UPDATE board_t (category, title, contents, goods_name)"
			+ " VALUES (?, ?, ?, ?)";
	
	private DataSource dataFactory;
	 Connection conn;
	 PreparedStatement pstmt;
	
	
	public BoardUpdateDAO () {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
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
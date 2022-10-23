package board;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

public class BoardService {
	BoardDAO boardDAO;
	BoardListDAO boardListDAO;
	BoardCreateDAO boardCreateDAO;
	BoardReadDAO boardReadDAO;
	BoardUpdateDAO boardUpdateDAO;
	BoardDelDAO boardDelDAO;
	public BoardService() {
		boardDAO = new BoardDAO();
		boardListDAO = new BoardListDAO();
		boardCreateDAO = new BoardCreateDAO();
		boardReadDAO = new BoardReadDAO();
		boardUpdateDAO = new BoardUpdateDAO();
		boardDelDAO = new BoardDelDAO();
	}
	
	//전체 글 목록
	public List<BoardVO> showArticles() {
		List <BoardVO> atriclesList = boardListDAO.boardListArticles();
		return atriclesList;
	}
	
	public int addArticle (BoardVO board) {
		System.out.println("create 수행합니다");
		boardCreateDAO.createArticle(board);
		boardCreateDAO.createArticleNum(board);
		boardCreateDAO.createArticleImg(board);
		return boardCreateDAO.createArticleNum(board);
	}
	
	public BoardVO viewArticle (int num_article) {
		System.out.println("viewArticle() 수행합니다");
		BoardVO article = null;
		article = boardReadDAO.readArticle(num_article);
		return article;
	}
	
	public void modifyArticle (BoardVO board) {
		System.out.println("modifyArticle() 수행합니다");
		boardUpdateDAO.updateArticle(board);
	}
	
	public List<Integer> removeArticle (int num_aticle) {
		System.out.println("removeArticle() 수행합니다");
		List<Integer> atriclesList =boardDelDAO.delBoard(num_aticle);
		return atriclesList;
	}
}

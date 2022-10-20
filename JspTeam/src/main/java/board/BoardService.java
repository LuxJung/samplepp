package board;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

public class BoardService {
	BoardDAO boardDAO;
	BoardListDAO boardListDAO;
	BoardCreateDAO boardCreateDAO;
	BoardReadDAO boardReadDAO;
	public BoardService() {
		boardDAO = new BoardDAO();
		boardListDAO = new BoardListDAO();
		boardCreateDAO = new BoardCreateDAO();
		boardReadDAO = new BoardReadDAO();
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
		boardDAO.updateArticle(board);
	}
}

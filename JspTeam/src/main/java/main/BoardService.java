package main;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

public class BoardService {
	BoardDAO boardDAO;
	public BoardService() {
		boardDAO = new BoardDAO();
	}
	
	public List<BoardVO> listArticles() {
		List <BoardVO> atriclesList = boardDAO.selectAllArticles();
		return atriclesList;
	}
	
	public void addArticle (BoardVO board) {
		System.out.println("addArticle() 수행합니다");
		boardDAO.insertNewArticle(board);
	}
	
	public BoardVO viewArticle (int num_article) {
		System.out.println("viewArticle() 수행합니다");
		BoardVO article = null;
		article = boardDAO.selectArticle(num_article);
		return article;
	}
	
	public void modifyArticle (BoardVO board) {
		System.out.println("modifyArticle() 수행합니다");
		boardDAO.updateArticle(board);
	}
}

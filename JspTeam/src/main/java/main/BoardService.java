package main;

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
		System.out.println("addArticle 왔냐?");
		boardDAO.insertNewArticle(board);
	}
	
	public BoardVO viewArticle (int num_article) {
		BoardVO article = null;
		article = boardDAO.selectArticle(num_article);
		return article;
		
	}
}

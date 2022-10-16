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

}

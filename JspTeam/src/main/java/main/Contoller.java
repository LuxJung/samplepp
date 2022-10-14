package main;

import java.util.List;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/contoller")
public class Contoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BoardDAO boardDAO;
	public void init() throws ServletException {
		boardDAO = new BoardDAO();
		System.out.println("초기화");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");		
		List<BoardVO> boardList = boardDAO.listBoard();
		HttpSession sessoin = request.getSession();
		for (int i=0; i<boardList.size(); i++) {
			
	        System.out.print(boardList.get(i).getName()+": ");
	        System.out.print(boardList.get(i).getTitle());
	        System.out.println(boardList.get(i).getContents());
	    }
		sessoin.setAttribute("boardList", boardList);
		RequestDispatcher dispatch = request.getRequestDispatcher("/listboard.jsp");
		dispatch.forward(request, response);
		//response.sendRedirect("/listboard.jsp");
		
	}
}

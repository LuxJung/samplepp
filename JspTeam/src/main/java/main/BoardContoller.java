package main;

import java.util.ArrayList;
import java.util.List;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/*")
public class BoardContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BoardService boardService;
	BoardVO boardVO;

	// BoardDAO boardDAO;
	public void init() throws ServletException {
		// boardDAO = new BoardDAO();
		boardService = new BoardService();
		System.out.println("초기화");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String nextPage = "";
		String action = request.getPathInfo();
		System.out.println("action: " + action);
		try {
			List<BoardVO> articlesList = new ArrayList<>();
			if (action == null || action.equals("/listArticles.do")) {
				articlesList = boardService.listArticles();
				request.setAttribute("articlesList", articlesList);
				nextPage = "/listboard.jsp";
				RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
				dispatch.forward(request, response);
			} else if (action.equals("/articleForm.do")) {
				// page702 여기부터 바로 ㄱㄱ
				nextPage = "/newgoods.jsp";
				RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
				dispatch.forward(request, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		/*
		 * List<BoardVO> boardList = boardDAO.listBoard(); for (BoardVO boardVO :
		 * boardList) { System.out.print("닉네임 : "+boardVO.getNickname()+" | ");
		 * System.out.print("글제목 : "+boardVO.getTitle()+" | ");
		 * System.out.println("글내용 : "+boardVO.getContents()); }
		 * request.setAttribute("boardList", boardList);
		 */

		// response.sendRedirect("/JspTeam/listboard.jsp");

		// response.sendRedirect("/listboard.jsp");

	}
}

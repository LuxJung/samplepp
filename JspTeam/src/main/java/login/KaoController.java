package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardService;


@WebServlet("/KaoController/*")
public class KaoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO userDAO;
	KakaouserVO kakaouserVO;
	BoardService boardService;
	int loginResult;
       
   
	public void init() throws ServletException{
    	userDAO = new UserDAO();
    	boardService = new BoardService();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String nextPage=null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String action = request.getPathInfo();
		System.out.println("action:" + action);
		
		String _section=request.getParameter("section");
		String _pageNum=request.getParameter("pageNum");
		int section = Integer.parseInt(((_section==null)? "1":_section) );
		int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
		Map<String, Integer> pagingMap=new HashMap<String, Integer>();
		pagingMap.put("section", section);
		pagingMap.put("pageNum", pageNum);
		Map<String, Object> articlesMap=boardService.listArticles(pagingMap);
		articlesMap.put("section", section);
		articlesMap.put("pageNum", pageNum);
		request.setAttribute("articlesMap", articlesMap);
		
		if(action.equals("/addkaouser.do")) {
			String id=request.getParameter("email");
			String nickname=request.getParameter("nickname");
			String profile_img="userProfile.jpg";
			String loginChk=request.getParameter("loginChk");
			System.out.println(id);
			System.out.println(nickname);
			System.out.println(loginChk);
			
			if(loginChk.equals("1")) {
				try {
					
					System.out.println("로그인 성공");
					request.setAttribute("loginResult", loginResult);
					HttpSession session = request.getSession();
					session.setAttribute("kakaosessionID", id);
					session.setMaxInactiveInterval(20*60);
					KakaouserVO userInfo=userDAO.readkakaoUser(id);
					session.setAttribute("userInfo", userInfo);
					 String picname=userInfo.getProfile_img();
					 System.out.println(userInfo.getProfile_img());
					 System.out.println(session.getAttribute("kakaosessionID"));
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				
			}else {
			
			KakaouserVO kaouserVO = new KakaouserVO(id,nickname,profile_img);
			userDAO.addKakaoMember(kaouserVO);
			loginResult=userDAO.kakaologin(id);
			System.out.println("loginResult=" + loginResult);
			
			if(loginResult==1) {
				System.out.println("로그인 성공");
				request.setAttribute("loginResult", loginResult);
				HttpSession session = request.getSession();
				session.setAttribute("kakaosessionID", id);
				session.setMaxInactiveInterval(20*60);
				KakaouserVO userInfo=userDAO.readkakaoUser(id);
				session.setAttribute("userInfo", userInfo);
				 System.out.println(userInfo.getProfile_img());
				 System.out.println(session.getAttribute("kakaosessionID"));
					nextPage="../index.jsp";
			}else {
				System.out.println("로그인실패");
				request.setAttribute("loginResult", loginResult);
				nextPage="../login/loginForm_.jsp";
			}
			}
			
			
			
			nextPage="../index.jsp";
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
			
		}else if(action.equals("/kaocheck.do")) {
			System.out.println("카카오체크 진입");
			String id=request.getParameter("email");
			System.out.println("카카오체크 email=" + id);
			int loginResult=userDAO.kakaologin(id);
			System.out.println("loginResult=" + loginResult);
			
			PrintWriter out = response.getWriter();
			out.write(loginResult+"");
		}
	}

}

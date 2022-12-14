package login;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import board.BoardService;


@WebServlet("/logintest.do")
public class JoinController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	UserDAO userDAO;
	UserVO userVO;
	String nextPage="";
	BoardService boardService;
	
	  public void init() throws ServletException{
			userDAO=new UserDAO();
			userVO=new UserVO();
			boardService = new BoardService();
	    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
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
		//response.sendRedirect("../index/index.jsp");
		nextPage = "../index.jsp";
		
		Map<String,String> articleMap2=upload(request,response);
		System.out.println("???????????????");
		String id=articleMap2.get("id");
		String password=articleMap2.get("password");
		String nickname=articleMap2.get("nickname");
		String phone_number=articleMap2.get("phone_number");
		String profile_img=(!(articleMap2.get("profile_img")==null))?articleMap2.get("profile_img"):"userProfile.jpg";
		String addr=articleMap2.get("addr");
		String detail_addr=articleMap2.get("detail_addr");
		
		
		System.out.println("??????????"+id);
		System.out.println(password);
		System.out.println(nickname);
		System.out.println(phone_number);
		System.out.println(profile_img);
		System.out.println(addr);
		System.out.println(detail_addr);
		
		
		userVO.setId(id);
		userVO.setPwd(password);
		userVO.setNickname(nickname);
		userVO.setPhone_number(phone_number);
		userVO.setProfile_img(profile_img);
		userVO.setAddr(addr);
		userVO.setDetail_addr(detail_addr);
		
		UserVO userVO = new UserVO(id, password, nickname, phone_number,profile_img,addr,detail_addr);
		userDAO.addMember(userVO);
		//nextPage="../index/index.jsp";
		response.sendRedirect("../board/listArticles.do");
		
		//RequestDispatcher dispatch = request.getRequestDispatcher("../index/index.jsp");
		//dispatch.forward(request, response);
		
	}
	
	private Map<String,String> upload(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String encoding = "utf-8";
		Map<String, String> articleMap = new HashMap<String, String>();
		
		//?????? ????????? ????????? ?????? ?????? test
		String realPath = "D:\\JSP\\JSP_Workspace\\DbTest\\JspTeam\\src\\main\\webapp\\resource\\users";
		String appPath = System.getProperty("catalina.home") + realPath;
		File currentDirPath = new File(realPath);
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);
		
		String fileName="";

		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List<FileItem> items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);

				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("???????????????:" + fileItem.getFieldName());
					System.out.println("?????????:" + fileItem.getName());
					System.out.println("????????????:" + fileItem.getSize() + "bytes");

					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						fileName = fileItem.getName().substring(idx + 1);
						System.out.println("?????????:" + fileName);
						articleMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\" + fileName);
						fileItem.write(uploadFile);
					} // end if
				} // end if
			} // end for
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//result=currentDirPath + "\\" + fileName;
		
		//System.out.println(result);
		return articleMap;
		
	}

}

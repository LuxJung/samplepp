package board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;


@WebServlet("/board/*")
public class BoardContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String BOARD_IMG_REPOSITORY = "D:\\JSP\\JSP_Workspace\\DbTest\\JspTeam\\src\\main\\webapp\\WEB-INF\\imgs";
	BoardService boardService;
	BoardVO boardVO;

	// BoardDAO boardDAO;
	public void init() throws ServletException {
		// boardDAO = new BoardDAO();
		boardService = new BoardService();
		boardVO= new BoardVO();
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
				articlesList = boardService.showArticles(); //전체 글 목록
				request.setAttribute("articlesList", articlesList);
				nextPage = "/listboard.jsp";
			} else if (action.equals("/addArticleForm.do")) {
				//글쓰기 페이지로 이동
				nextPage = "/addboard.jsp";
			} else if(action.equals("/createArticle.do")) {
				//C-작업수행
				Map<String, String> articleMap = upload(request,response);
				String title = articleMap.get("title");
				String content = articleMap.get("content");
				String price = articleMap.get("price");
				String imgFileName = articleMap.get("goods_img");
				System.out.println("articleMap 에서 가져오는 title" + title);
				System.out.println("articleMap 에서 가져오는 content" + content);
				System.out.println("articleMap 에서 가져오는 price" + price);

				boardVO.setNickname("테스트");
				boardVO.setCategory("디폴트");
				boardVO.setTitle(title); // addboard input을 map으로 줘서 받아옴
				boardVO.setContents(content);
				boardVO.setGoods_name("디폴트");
				boardVO.setPrice(Integer.parseInt(price));
				boardVO.setGoods_img(imgFileName);
				int num_aticle = boardService.addArticle(boardVO);
				
				if(imgFileName!=null && imgFileName.length()!=0) {
				    File srcFile = new 	File(BOARD_IMG_REPOSITORY +"\\"+"temp"+"\\"+imgFileName);
					File destDir = new File(BOARD_IMG_REPOSITORY +"\\"+num_aticle);
					destDir.mkdirs();
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
				PrintWriter pw = response.getWriter();
				pw.print("<script>" 
				         +"  alert('새글을 추가했습니다.');" 
						 +" location.href='"+request.getContextPath()+"/board/listArticles.do';"
				         +"</script>");

				return;
				
			} else if(action.equals("/readArticle.do")) {
			//R
				String num_aticle = request.getParameter("num_aticle");
				System.out.println("readArticle.do 서블렛 왔어요" + num_aticle);
				boardVO = boardService.viewArticle(Integer.parseInt(num_aticle));
				/*더미 데이터 name 보냈습니다. 앞으로는 세션값과 비교를 해야합니다.*/
				request.setAttribute("name", "디폴트");
				
				request.setAttribute("article", boardVO);
				nextPage = "/detailboard.jsp";
			
			} else if(action.equals("/modifyArticles.do")) {
			//U
				Map<String, String> articleMap = upload(request,response);
				String title = articleMap.get("title");
				String content = articleMap.get("content");
				String imgFileName = articleMap.get("goods_img");
				System.out.println("오냐?");
				System.out.println("1");
				System.out.println("2"+boardVO.getNum_aticle());
				boardVO.setNickname("디폴트");
				System.out.println("3");
				boardVO.setCategory("디폴트");
				boardVO.setTitle(title); // addboard input에서 받아옴
				boardVO.setContents(content);
				boardVO.setGoods_name("디폴트");
				boardVO.setGoods_img(imgFileName);
				
				boardService.modifyArticle(boardVO);
				nextPage = "/addboard.jsp";
			} else if(action.equals("/deleteArticles.do")) {
			//D
				System.out.println("deleteArticles");
				String num_aticle = request.getParameter("num_aticle");
				System.out.println("num_aticle = "+num_aticle);
				List<Integer> removeArticleNo = boardService.removeArticle(Integer.parseInt(num_aticle));
				File imgDir = new File(BOARD_IMG_REPOSITORY+"//"+num_aticle);
				if(imgDir.exists()) {
					FileUtils.deleteDirectory(imgDir);
					System.out.println(num_aticle+"번 폹더 삭제 완료");
				}
				PrintWriter pw = response.getWriter();
				pw.print("<script>" 
				         +"  alert('글을 삭제했습니다.');" 
						 +" location.href='"+request.getContextPath()+"/board/listArticles.do';"
				         +"</script>");
				return;
			}		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	private Map <String, String> upload(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
	String encoding = "utf-8";
	Map<String, String> articleMap = new HashMap<String, String>();
	File currentDirPath = new File(BOARD_IMG_REPOSITORY);
	if (!currentDirPath.exists()) {
		try{
			currentDirPath.mkdir(); //폴더 생성합니다.
		    System.out.println("폴더가 생성되었습니다.");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
    }
	DiskFileItemFactory factory = new DiskFileItemFactory();
	factory.setRepository(currentDirPath);
	factory.setSizeThreshold(1024 * 1024);
	ServletFileUpload upload = new ServletFileUpload(factory);
	try {
		List items = upload.parseRequest(request);
		System.out.println("items.size()????"+items.size());
		for (int i = 0; i < items.size(); i++) {
			FileItem fileItem = (FileItem) items.get(i);
			System.out.println("폼에서 넘어오니?"+fileItem.getFieldName()); 
			if (fileItem.isFormField()) {
				System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
				articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
			} else {
				System.out.println("파라미터명:" + fileItem.getFieldName());
				System.out.println("파일명:" + fileItem.getName());
				System.out.println("파일크기:" + fileItem.getSize() + "bytes");
				//articleMap.put(fileItem.getFieldName(), fileItem.getName());
				if (fileItem.getSize() > 0) {
					int idx = fileItem.getName().lastIndexOf("\\");
					if (idx == -1) {
						idx = fileItem.getName().lastIndexOf("/");
					}
					String fileName = fileItem.getName().substring(idx + 1);
					System.out.println("파일명:" + fileName);
					articleMap.put(fileItem.getFieldName(), fileName);  //익스플로러에서 업로드 파일의 경로 제거 후 map에 파일명 저장
					File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
					fileItem.write(uploadFile);
				} // end if
			} // end if
		} // end for
	} catch (Exception e) {
		e.printStackTrace();
	}
	return articleMap;
}

}

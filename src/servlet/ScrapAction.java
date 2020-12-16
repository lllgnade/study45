package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;
import board.BoardVO;
import board.ScrapVO;

/**
 * Servlet implementation class LogoutAction
 */
public class ScrapAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ScrapAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf8");

		// 게시물 번호 받아오기
		int boardNo = -1;
		if (request.getParameter("boardNo") != null) {
			boardNo = Integer.parseInt(request.getParameter("boardNo"));
		}
		if (boardNo == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 요청입니다.')");
			script.println("location.href = '../main.jsp'");
			script.println("</script>");
			return;
		}
		// 게시판명 유효 체크
		if (request.getParameter("boardType") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 요청입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		String boardType = request.getParameter("boardType");

		// 스크랩 명령 받아오기
		String act = request.getParameter("act");
		if (act == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 요청입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
		// 특정 요청 지점이 있으면 받아오기
		String location = "";
		if (request.getParameter("location") != null)
			location = request.getParameter("location");

		// 사용자 ID 받아오기
		String userID = null;
		HttpSession session = request.getSession(true);
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 해야 합니다.')");
			script.println("</script>");
			response.sendRedirect("../login.jsp?location=board_" + boardType);
			return;
		} else {

			// 게시물 정보 받아오기
			BoardVO boardInfo = new BoardDAO().selectThisBoard(boardNo);
			if (boardInfo == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('해당 글이 존재하지 않거나 삭제되었습니다.')");
				script.println("</script>");
				response.sendRedirect("../main.jsp");
				return;
			}

			BoardDAO boardDAO = new BoardDAO();
			String answer = null;
			ScrapVO scrapFilter = new ScrapVO();

			scrapFilter.setBoardNo(Integer.toString(boardNo));
			scrapFilter.setScraperID(userID);

			if (act.equals("delete")) { // 스크랩 삭제

				try {
					answer = boardDAO.deleteScrap(scrapFilter);
				} catch (Exception e) {
					e.printStackTrace();
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('오류가 발생했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					return;
				}
				if ("ok".equals(answer)) { // 게시물 스크랩 성공시 해당 게시물로 이동

					//PrintWriter script = response.getWriter();
					//script.println("<script>");
					//script.println("alert('스크랩을 해제했습니다.')");
					//script.println("location.href = '../board/view.jsp?boardNo='+boardNo");
					//script.println("</script>");
					response.sendRedirect("../board/view.jsp?boardNo=" + boardNo);
					return;
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('스크랩 해제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					return;
				}
			} else { // 스크랩 추가
				try {
					answer = boardDAO.addScrap(scrapFilter);
				} catch (Exception e) {
					e.printStackTrace();
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('오류가 발생했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					return;
				}
				if ("ok".equals(answer)) { // 게시물 스크랩 성공시 해당 게시물로 이동

					//PrintWriter script = response.getWriter();
					//script.println("<script>");
					//script.println("alert('스크랩했습니다.')");
					//script.println("</script>");
					response.sendRedirect("../board/view.jsp?boardNo=" + boardNo);
					return;
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('스크랩에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

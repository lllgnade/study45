<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.ScrapVO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-sale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>study for 4.5</title>
</head>
<body>
<%

	//게시물 번호 받아오기
	int boardNo=-1;
	if(request.getParameter("boardNo")!=null){
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	}
	if (boardNo==-1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 요청입니다.')");
		script.println("location.href = '../main.jsp'");
		script.println("</script>");
		return;
	}	
	//게시판명 받아오기
	String boardType = request.getParameter("boardType");
	if (boardType == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 요청입니다.')");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	//스크랩 명령 받아오기
		String act = request.getParameter("act");
		if (act == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 요청입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return;
		}
	//특정 요청 지점이 있으면 받아오기
	String location = "";
	if(request.getParameter("location")!=null)
		location = request.getParameter("location");
	
	//사용자 ID 받아오기
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
	%>	
		<script>
		alert('로그인 해야 합니다.')
		location.href = '../login.jsp?location=board_<%=boardType%>'
		</script>
	<%
		return;
	}
	else{
		
		//게시물 정보 받아오기
		BoardVO boardInfo = new BoardDAO().selectThisBoard(boardNo);
		if(boardInfo==null){
	%>	
		<script>
		alert('해당 글이 존재하지 않거나 삭제되었습니다.')
		location.href = '../main.jsp'
		</script>
	<%		
		return; }
		
		BoardDAO boardDAO = new BoardDAO();
		String answer = null;
		ScrapVO scrapFilter = new ScrapVO();
		
		scrapFilter.setBoardNo(Integer.toString(boardNo));
		scrapFilter.setScraperID(userID);
		
		if(act.equals("delete")){ //스크랩 삭제
			
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
			if("ok".equals(answer)) { //게시물 스크랩 성공시 해당 게시물로 이동
			%>
					<script>
					alert('스크랩을 해제했습니다.')
					location.href = 'view.jsp?boardNo=<%=boardNo%>'
					</script>
			<%
			return;
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('스크랩 해제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return;
			}

			
		}
		else{ //스크랩 추가
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
			if("ok".equals(answer)) { //게시물 스크랩 성공시 해당 게시물로 이동
			%>
				<script>
				alert('스크랩했습니다.')
				location.href = 'view.jsp?boardNo=<%=boardNo%>'
				</script>
			<%
			return;
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('스크랩에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
	}
	}
	
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		else if(!userID.equals(boardInfo.getUserID())){ //권한 검사
	%>	
		<script>
		alert('글을 수정할 권한이 없습니다.')
		location.href = 'board_<%=boardInfo.getBoardType()%>.jsp'
		</script>
	<%		
		return; }
		
		if(request.getParameter("title") == null || request.getParameter("contents") == null
				|| request.getParameter("title").isEmpty() || request.getParameter("contents").isEmpty()){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			
			BoardDAO boardDAO = new BoardDAO();
			String answer = null;
			
			boardInfo.setBoardNo(boardNo);
			boardInfo.setTitle(request.getParameter("title"));
			boardInfo.setContents(request.getParameter("contents"));
			
			try {
				answer = boardDAO.updateBoard(boardInfo);
			} catch (Exception e) {
				e.printStackTrace();
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return;
			}
			if("ok".equals(answer)){ //게시물 수정 성공시 해당 게시물로 이동
				%>
						<script>
						location.href = 'view.jsp?boardNo=<%=boardNo%>&pageNum=1'
						</script>
				<%
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return;
			}
			
		}
	}
	
	%>
</body>
</html>
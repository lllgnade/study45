<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="boardInfo" class="board.BoardVO" scope="page"/>
<jsp:setProperty property="title" name="boardInfo"/>
<jsp:setProperty property="contents" name="boardInfo"/>

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
	String boardType = request.getParameter("boardType");
	String userID = null;
	if (boardType == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 요청입니다.')");
		script.println("history.back()");
		script.println("</script>");
		return;
	}
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
	%>	
		<script>
		alert('로그인이 필요합니다.')
		location.href = '../login.jsp?location=board_${param.boardType}'
		</script>
	<%
		return;
	}
	else{
		
		if(boardInfo.getTitle() == null || boardInfo.getContents() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			
			BoardDAO boardDAO = new BoardDAO();
			String answer = null;
			int inserted_boardNo =-1;
			boardInfo.setUserID(userID);
			boardInfo.setBoardType(boardType);
			
			try {
				inserted_boardNo = boardDAO.addBoard(boardInfo);
			} catch (Exception e) {
				e.printStackTrace();
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('등록 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return;
			}
			if(inserted_boardNo!=-1){ //게시물 등록 성공시 해당 게시물로 이동
				%>
						<script>
						location.href = 'view.jsp?boardNo=<%=inserted_boardNo%>&pageNum=1'
						</script>
				<%
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 등록에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return;
			}
			
		}
		
		
		
	}
	
	%>
</body>
</html>
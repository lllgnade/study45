<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="../css/bootstrap.css">
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
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = '../main.jsp'");
			script.println("</script>");
			return;
		}
		
		String location = "";
		if(request.getParameter("location")!=null)
			location = request.getParameter("location");
		if (location.isEmpty()){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 접근입니다.')");
			script.println("location.href = '../main.jsp'");
			script.println("</script>");
			return;
		}
		
	
		
		// 로그인을 한 사람이면 userID에 아이디를 저장, 아닐 경우 null값
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String) session.getAttribute("userID");
		}
		
		//로그인하지 않았을 경우 로그인 페이지로 이동하기
		if (userID == null) {
	%>
		<script>
		location.href = '../login.jsp?location=view<%=boardNo%>'
		</script>
	<%
			return;
		}
		
		
		//DB로부터 정보 가져오기
		BoardVO boardInfo = new BoardDAO().readOneBoard(boardNo,userID);
		if(boardInfo==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당 글이 존재하지 않거나 삭제되었습니다.')");
			script.println("location.href = '../main.jsp'");
			script.println("</script>");
			return;
		}
		
		//게시판 종류 받아오기
		String boardType = "free";
		boardType = boardInfo.getBoardType(); 
		
		//요청시의 게시판 페이지번호 받아오기
		int pageNum=1; 
		if(request.getParameter("pageNum")!=null){
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
	%>

	

	
	<%-- 네비게이션  --%>
	<nav class="navbar navbar-default" style="background-color: #CEF6F5">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="../main.jsp">Study for 4.5</a>
	<%	
		//활성화된 게시판 색칠. 조건으로 style 다는 법을 몰라서..
		if(location.contains("scrap")){
	%>
			<a class="navbar-brand" href="board_free.jsp" style="font-size:1.0em;">자유게시판</a>
			<a class="navbar-brand" href="board_tip.jsp" style="font-size:1.0em;;">팁 공유 게시판</a>
			<a class="navbar-brand" href="board_question.jsp" style="font-size:1.0em">질문게시판</a>
			<a class="navbar-brand" href="board_scrap.jsp" style="font-size:1.0em; background-color: #BEE6E5;">스크랩</a>
	<%	}else{
	%>	
			<a class="navbar-brand" href="board_free.jsp" style="font-size:1.0em;">자유게시판</a>
			<a class="navbar-brand" href="board_tip.jsp" style="font-size:1.0em">팁 공유 게시판</a>
			<a class="navbar-brand" href="board_question.jsp" style="font-size:1.0em;">질문게시판</a>
			<a class="navbar-brand" href="board_my.jsp" style="font-size:1.0em; background-color: #BEE6E5;">내 글 보기</a>
	<%	}
	%>	
		</div>
		<%-- 우측 상단 메뉴 --%>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="../myPage.jsp" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><%=userID%> <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="../myPage.jsp">마이페이지</a></li>
						<li><a href="/study45/user/logout_process.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
	<div class="row">
	<table class="table table-striped" style="text-align : center; border:1px solid #dddddd">
		<thead>
		<tr>
			<th colspan="3" scope="col" class="text-center" style="background-color: #eeeeee">글 보기</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td style="width: 20%;">글 제목</td>
			<td colspan="2"><%= boardInfo.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
		</tr>
		
		<tr>
			<td>작성자</td>
			<td colspan="2"><%= boardInfo.getName().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
		</tr>
		<tr>
			<td>작성일자</td>
			<td colspan="2"><%= boardInfo.getRegDate() %></td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="2" style="min-height:200px; text-align:left;"><%= boardInfo.getContents().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
		</tr>
	</tbody>
	</table>
	<a href="board_<%=location%>.jsp?pageNum=<%=pageNum%>" class="btn btn-primary">목록</a>
	<% 
		if(userID!=null && userID.equals(boardInfo.getUserID())){
	%>
	<a href="update.jsp?boardNo=<%=boardNo%>&boardType=<%=boardType%>" class="btn btn-primary">수정</a>
	<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="delete_process.jsp?boardNo=<%=boardNo%>&boardType=<%=boardType%>&location=<%=location%>" class="btn btn-primary">삭제</a>
	<%
		}
	%>
	</div>
	</div>
	
	
	
	
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="../js/bootstrap.js"></script>
</body>
</html>

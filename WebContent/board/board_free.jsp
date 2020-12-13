<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="../css/bootstrap.css">
<title>study for 4.5</title>
<style type="text/css">
	a, a:hover{
	color : #000000;
	text-decoration : none;
	}
</style>
</head>
<body>
	<%
		
		// 로그인을 한 사람이면 userID에 아이디를 저장, 아닐 경우 null값
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String) session.getAttribute("userID");
		}
		
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
			<a class="navbar-brand" href="../board/board_free.jsp" style="font-size:1.0em; background-color: #BEE6E5;">자유게시판</a>
			<a class="navbar-brand" href="#" style="font-size:1.0em">팁 공유 게시판</a>
			<a class="navbar-brand" href="#" style="font-size:1.0em">질문게시판</a>
		</div>
		<%-- 우측 상단 메뉴 --%>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">
			<%
				// 로그인 안된경우
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="../login.jsp?location=board_free">로그인</a></li>
						<li><a href="../user/sign_up.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인 상태인 경우
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="../myPage.jsp" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><%=userID%> <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="../myPage.jsp">마이페이지</a></li>
						<li><a href="../user/logout_process.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
	
	<table class="table table-hover" style="width: 100%">
	
		<colgroup>
       <col span="1" style="width: 58%;">
       <col span="1" style="width: 20%;">
       <col span="1" style="width: 15%;">
       <col span="1" style="width: 7%;">
    </colgroup>
		<thead>
		<tr>
			<th scope="col" class="text-center" style="background-color: #eeeeee">제목</th>
			<th scope="col" class="text-center" style="background-color: #eeeeee">글쓴이</th>
			<th scope="col" class="text-center" style="background-color: #eeeeee">작성일</th>
			<th scope="col" class="text-center" style="background-color: #eeeeee">조회수</th>
		</tr>
	</thead>
	<tbody>
		<%
			BoardDAO boardDAO= new BoardDAO();
			BoardVO boardFilter= new BoardVO();
			boardFilter.setBoardType("free");
			List<BoardVO> boardlist = boardDAO.showBoard(boardFilter,pageNum, 10);
			for(BoardVO board: boardlist){
		%>
		<tr>
			<td scope="col" class="text-center"><a href="view.jsp?boardNo=<%= board.getBoardNo() %>&pageNum=<%=pageNum%>"><%= board.getTitle() %></a></td>
			<td scope="col" class="text-center"><%= board.getName() %></td>
			<td scope="col" class="text-center"><%= board.getRegDate()%></td>
			<td scope="col" class="text-center"><%= board.getReadCount() %></td>
		</tr>
		<%
			}
		%>
	</tbody>
	</table>
	<% 
	if(pageNum!=1){ 
	%>
		<a href="board_free.jsp?pageNum=<%=pageNum-1 %>" class="btn btn-success btn-arrow-left">이전</a>
	<% 
	} if(boardDAO.showBoard(boardFilter,pageNum+1, 10).size()!=0){
	%>
		<a href="board_free.jsp?pageNum=<%=pageNum+1 %>" class="btn btn-success btn-arrow-left">다음</a>
	<% 
	} 
	%>
	<a href="write.jsp?boardType=free" class="btn btn-primary pull-right">글쓰기</a>
	</div>
	
	
	
	
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="../js/bootstrap.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>study for 4.5</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>
	<%  
		//아이디 가져오기
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String) session.getAttribute("userID");
		}else{ //비로그인 시
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 해야 합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			return;
		}
		
		BoardDAO boardDAO = new BoardDAO();
		
		//내 글 최신순 3개 가져오기
		BoardVO boardFilter = new BoardVO();
		boardFilter.setUserID(userID);
		List<BoardVO> mylist = boardDAO.searchBoard(boardFilter, 1, 3);
		//내가 스크랩한 글 최신순 3개 가져오기
		List<BoardVO> myScraplist = boardDAO.myScrapBoard(new BoardVO(),userID, 1, 3);
		
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
			<a class="navbar-brand" href="main.jsp">Study for 4.5</a> <a
				class="navbar-brand" href="board/board_free.jsp"
				style="font-size: 1.0em">자유게시판</a> <a class="navbar-brand"
				href="board/board_tip.jsp" style="font-size: 1.0em">팁 공유 게시판</a> <a
				class="navbar-brand" href="board/board_question.jsp"
				style="font-size: 1.0em">질문게시판</a>
		</div>
		<%-- 우측 상단 메뉴 --%>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">

			<c:choose>
				<%-- 로그인 안 된 경우 --%>
				<c:when test="<%= userID == null %>"> 
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="login.jsp">로그인</a></li>
								<li><a href="join.jsp">회원가입</a></li>
							</ul></li>
					</ul>
				</c:when>
				<%-- 로그인 상태인 경우 --%>
				<c:otherwise>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">${userID} <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="user/logout_process.jsp">로그아웃</a></li>
							</ul></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
	<div class="panel panel-default">
		<div class="panel-heading" style="background-color: #BCF5A9">내 글
			보기</div>
		<div class="panel-body">
			<table class="table table-hover">
				<colgroup>
					<col span="1" style="width: 10%;">
					<col span="1" style="width: 90%;">
				</colgroup>


				<c:choose>
					<c:when test="<%=mylist == null || mylist.size()==0%>">
						<tr>
							<td colspan=2><b>내가 쓴 글이 없습니다.</b></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="board" items="<%=mylist%>">

							<tr>
								<th scope="col" class="text-center">${board.boardType}</th>
								<th scope="col" class="text-left"><a
									href="/study45/board/sub_view.jsp?boardNo=${board.boardNo}&pageNum=1&location=my">
										${board.title}</a></th>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>

				<tr>
					<th scope="col" colspan="2" class="text-right"><a
						href="/study45/board/board_my.jsp"><h6>모든 글 보기</h6></a></th>
				</tr>
			</table>
		</div>
	</div>

	<div class="panel panel-default">
		<div class="panel-heading" style="background-color: #BCF5A9">스크랩</div>
		<div class="panel-body">
			<table class="table table-hover">
				<colgroup>
					<col span="1" style="width: 10%;">
					<col span="1" style="width: 90%;">
				</colgroup>

				<c:choose>
					<c:when test="<%=myScraplist == null || myScraplist.size()==0%>">
						<tr>
							<td colspan=2><b>스크랩한 글이 없습니다.</b></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="board" items="<%=myScraplist%>">

							<tr>
								<th scope="col" class="text-center">${board.boardType}</th>
								<th scope="col" class="text-left"><a
									href="/study45/board/sub_view.jsp?boardNo=${board.boardNo}&pageNum=1&location=scrap">
										${board.title}</a></th>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>

				<tr>
					<th scope="col" colspan="2" class="text-right"><a
						href="/study45/board/board_scrap.jsp"><h6>모든 글 보기</h6></a></th>
				</tr>
			</table>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
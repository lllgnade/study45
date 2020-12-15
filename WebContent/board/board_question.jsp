<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
table {
	width: 100%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
}

td {
	background-color: #EFFBF8;
}

a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>
	<%
		// 로그인을 한 사람이면 userID에 아이디를 저장, 아닐 경우 null값

	request.setCharacterEncoding("utf8");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int pageNum = 1;
	if (request.getParameter("pageNum") != null) {
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}

	boolean ifSearching = false;
	String object = "";
	String query = "";
	//검색 쿼리 받아오기
	if (request.getParameter("object") != null && request.getParameter("query") != null) {
		ifSearching = true;
		object = request.getParameter("object");
		query = request.getParameter("query");
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
			<a class="navbar-brand" href="../main.jsp">Study for 4.5</a> <a
				class="navbar-brand" href="board_free.jsp" style="font-size: 1.0em;">자유게시판</a>
			<a class="navbar-brand" href="board_tip.jsp" style="font-size: 1.0em">팁
				공유 게시판</a> <a class="navbar-brand" href="board_question.jsp"
				style="font-size: 1.0em; background-color: #BEE6E5;">질문게시판</a>
		</div>
		<%-- 우측 상단 메뉴 --%>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">



			<c:choose>
				<%-- 로그인 안 된 경우 --%>
				<c:when test="<%=userID == null%>">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="../login.jsp?location=board_question">로그인</a></li>
								<li><a href="../join.jsp">회원가입</a></li>
							</ul></li>
					</ul>
				</c:when>
				<%-- 로그인 상태인 경우 --%>
				<c:otherwise>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="../myPage.jsp"
							class="dropdown-toggle" data-toggle="dropdown" role="button"
							aria-haspopup="true" aria-expanded="false">${userID} <span
								class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="../myPage.jsp">마이페이지</a></li>
								<li><a href="../user/logout_process.jsp">로그아웃</a></li>
							</ul></li>
					</ul>
				</c:otherwise>
			</c:choose>
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
					<th scope="col" class="text-center"
						style="background-color: #BCF5A9">제목</th>
					<th scope="col" class="text-center"
						style="background-color: #BCF5A9">글쓴이</th>
					<th scope="col" class="text-center"
						style="background-color: #BCF5A9">작성일</th>
					<th scope="col" class="text-center"
						style="background-color: #BCF5A9">조회수</th>
				</tr>
			</thead>
			<tbody>
				<%
					/*데이터 가져오기*/
				BoardDAO boardDAO = new BoardDAO();
				BoardVO boardFilter = new BoardVO();
				boardFilter.setBoardType("question");
				//검색시
				if (ifSearching) {
					if ("title".equals(object)) {
						boardFilter.setTitle(query);
					} else if ("name".equals(object)) {
						boardFilter.setName(query);
					} else if ("contents".equals(object)) {
						boardFilter.setContents(query);
					}
				}
				List<BoardVO> boardlist = boardDAO.searchBoard(boardFilter, pageNum, 10);
				%>

				<c:choose>
					<c:when test="<%=boardlist == null || boardlist.size() == 0%>">
						<tr>
							<td colspan=4><b>등록된 글이 없습니다.</b></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="board" items="<%=boardlist%>">

							<tr>
								<td scope="col" class="text-center"><a
									href="view.jsp?boardNo=${board.boardNo}&pageNum=<%=pageNum%>">
										${board.title}</a></td>
								<td scope="col" class="text-center">${board.name}</td>
								<td scope="col" class="text-center">${board.regDate}</td>
								<td scope="col" class="text-center">${board.readCount}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<center>
		
			<%-- 이전 페이지가 있을 경우 버튼 활성화 --%>
			<c:if test="<%=pageNum != 1%>">

				<c:choose>
					<%-- 검색시 --%>
					<c:when test="<%=ifSearching%>">
						<a
							href="board_question.jsp?pageNum=<%=pageNum - 1%>&object=${param.object}&query=${param.query}"
							class="btn btn-success btn-arrow-left">이전</a>
					</c:when>
					<%-- 검색이 아닐 때 --%>
					<c:otherwise>

						<a href="board_question.jsp?pageNum=<%=pageNum - 1%>"
							class="btn btn-success btn-arrow-left">이전</a>
					</c:otherwise>
				</c:choose>

			</c:if>

			<%-- 다음 페이지가 있을 경우 버튼 활성화 --%>
			<c:if
				test="<%=boardDAO.searchBoard(boardFilter, pageNum + 1, 10).size() != 0%>">

				<c:choose>
					<%-- 검색시 --%>
					<c:when test="<%=ifSearching%>">

						<a
							href="board_question.jsp?pageNum=<%=pageNum + 1%>&object=${param.object}&query=${param.query}"
							class="btn btn-success btn-arrow-left">다음</a>
					</c:when>
					<%-- 검색이 아닐 때 --%>
					<c:otherwise>

						<a href="board_question.jsp?pageNum=<%=pageNum + 1%>"
							class="btn btn-success btn-arrow-left">다음</a>
					</c:otherwise>
				</c:choose>

			</c:if>

		</center>
		<a href="write.jsp?boardType=question"
			class="btn btn-primary pull-left">글쓰기</a>

		<form class="form-inline pull-right" method="post"
			action="board_question.jsp">
			<select class="form-control form-control-sm " name="object">
				<option value="title">제목</option>
				<option value="contents">내용</option>
				<option value="name">작성자</option>
			</select> <input class="form-control form-control-sm mr-3 w-75" type="text"
				placeholder="검색어를 입력하세요." aria-label="Search" name="query">
			<button type="submit" class="btn">검색</button>
		</form>
	</div>


	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="../js/bootstrap.js"></script>
</body>
</html>

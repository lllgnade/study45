<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

	// 로그인을 한 사람이면 userID에 아이디를 저장, 아닐 경우 null값
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	//로그인하지 않았을 경우 로그인 페이지로 이동
	if (userID == null) {
	%>
	<script>
		alert('로그인 해야 합니다.')
		location.href = '../login.jsp?location=view${param.boardNo}'
	</script>
	<%
		return;
	}

	BoardVO boardInfo = new BoardDAO().selectThisBoard(boardNo);
	if (boardInfo == null) {
	%>
	<script>
		alert('해당 글이 존재하지 않거나 삭제되었습니다.')
		location.href = '../main.jsp'
	</script>
	<%
		} else if (!userID.equals(boardInfo.getUserID())) {
	%>
	<script>
		alert('글을 수정할 권한이 없습니다.')
		location.href = 'board_${param.boardType}'
	</script>
	<%
		}
	String boardType = boardInfo.getBoardType();
	%>



	<%-- 네비게이션  --%>
	<c:set var="boardNo" value="<%=boardNo%>" />
	<c:set var="boardType" value="<%=boardType%>" />
	<nav class="navbar navbar-default" style="background-color: #CEF6F5">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="../main.jsp">Study for 4.5</a>
			<%-- 활성화된 게시판 색칠  --%>
			<c:choose>
				<c:when test="${fn:contains(boardType, 'tip')}">

					<a class="navbar-brand" href="board_free.jsp"
						style="font-size: 1.0em;">자유게시판</a>
					<a class="navbar-brand" href="board_tip.jsp"
						style="font-size: 1.0em; background-color: #BEE6E5;">팁 공유 게시판</a>
					<a class="navbar-brand" href="board_question.jsp"
						style="font-size: 1.0em">질문게시판</a>
				</c:when>
				<c:when test="${fn:contains(boardType, 'question')}">

					<a class="navbar-brand" href="board_free.jsp"
						style="font-size: 1.0em;">자유게시판</a>
					<a class="navbar-brand" href="board_tip.jsp"
						style="font-size: 1.0em">팁 공유 게시판</a>
					<a class="navbar-brand" href="board_question.jsp"
						style="font-size: 1.0em; background-color: #BEE6E5;">질문게시판</a>
				</c:when>
				<c:otherwise>
					<a class="navbar-brand" href="board_free.jsp"
						style="font-size: 1.0em; background-color: #BEE6E5;">자유게시판</a>
					<a class="navbar-brand" href="board_tip.jsp"
						style="font-size: 1.0em">팁 공유 게시판</a>
					<a class="navbar-brand" href="board_question.jsp"
						style="font-size: 1.0em">질문게시판</a>
				</c:otherwise>
			</c:choose>
		</div>
		<%-- 우측 상단 메뉴 --%>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="../myPage.jsp"
					class="dropdown-toggle" data-toggle="dropdown" role="button"
					aria-haspopup="true" aria-expanded="false">${userID}<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="../myPage.jsp">마이페이지</a></li>
						<li><a href="/study45/user/logout_process.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post"
				action="update_process.jsp?boardNo=${boardNo}&boardType=${boardType}">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" scope="col" class="text-center"
								style="background-color: #BCF5A9">글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="title" maxlength="100"
								value="<%=boardInfo.getTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="contents" maxlength="4096"
									style="height: 350px; resize: vertical;"><%=boardInfo.getContents()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="수정하기">
			</form>
		</div>
	</div>




	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="../js/bootstrap.js"></script>
</body>
</html>

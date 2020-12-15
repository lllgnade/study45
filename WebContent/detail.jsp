<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.PrintWriter"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>Study for 4.5</title>
<style>
.container {
	width: 100%;
	margin: 10px auto;
}

.container img {
	width: 100%;
	vertical-align: middle;
}

.text_container {
	padding: 5px 10px;
	text-align: center;
}
</style>
</head>
<body>
	<%
		/*
	메인페이지의 '자세히 알아보기' 버튼을 누르면 나오는 사이트 설명 페이지
	*/
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
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
			<a class="navbar-brand" href="main.jsp">Study for 4.5</a>
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
								<li><a href="login.jsp">로그인</a></li>
								<li><a href="join.jsp">회원가입</a></li>
							</ul></li>
					</ul>
				</c:when>
				<%-- 로그인 상태인 경우 --%>
				<c:otherwise>

					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="myPage.jsp"
							class="dropdown-toggle" data-toggle="dropdown" role="button"
							aria-haspopup="true" aria-expanded="false">${userID} <span
								class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="myPage.jsp">마이페이지</a></li>
								<li><a href="user/logout">로그아웃</a></li>
							</ul></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
	<div class="container">
		<div class="text_container" style="position: relative;">
			<img src="image/chalkboard-152414_1280.png" width="400" height="400"
				border="0">
			<div
				style="left: 90px; width: 1000px; bottom: 140px; font-size: 1.4em; font-weight: bold; position: absolute;">
				<h2 style="color: #BCF5A9;">Study for 4.5에 오신 것을 환영합니다.</h2>
				<br>
				<h4 style="color: #BCF5A9;">이 곳은 다른 유저와 공부 팁을 공유해서 더 나은 공부 팁을
					찾아 가는 곳입니다.</h4>
				<h4 style="color: #BCF5A9;">당신의 팁을 공유해주세요!</h4>
				<h4 style="color: #BCF5A9;">그리고 다른 분들의 유용한 팁을 알아가세요!</h4>
			</div>
		</div>
	</div>
	<div class="board table">
		<table class="table table-hover">
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td>
					<h4>자유게시판</h4> <br>
					<h5>자유롭게 다른 유저들과 대화하는 공간입니다.</h5>
					<h5>자유게시판에서는 거리낌없이 대화하며</h5>
					<h5>팀프로젝트에 필요한 팀을 짜는 것도</h5>
					<h5>새로운 친구를 찾는 것도 가능해요!</h5> <br> <a
					class="btn btn-primary btn-pull" href="board/board_free.jsp"
					role="button">바로가기</a>
				</td>
				<td>
					<h4>팁 공유 게시판</h4> <br>
					<h5>여러분들만 아는 공부 팁들을 공유하는 곳입니다.</h5>
					<h5>팁을 공유하면서 이것보다 더 나은 팁이 있는지 확인도 할 수 있고</h5>
					<h5>자신이 몰랐던 방법을 찾을 수도 있어요!</h5> <br> <br> <a
					class="btn btn-primary btn-pull" href="board/board_tip.jsp"
					role="button">바로가기</a>
				</td>
				<td>
					<h4>질문게시판</h4> <br>
					<h5>모르는 게 있다면 무엇이든지 질문해보세요!</h5>
					<h5>능력자분이 어디선가 나타나서 답을 해줄테니까요!</h5>
					<h5>자기가 알고있는 답을 다른 유저에게 공유할 수도 있어요</h5> <br> <br> <a
					class="btn btn-primary btn-pull" href="board/board_question.jsp"
					role="button">바로가기</a>
				</td>
			</tr>
		</table>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
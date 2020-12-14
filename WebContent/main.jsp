<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.io.PrintWriter" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>Study for 4.5</title>
</head>
<body>
	<%
		/*
		
			** index는 main.jsp로 넘어가도록 수정
		
			
			자세히 알아보기 버튼은 일단 임시로 만든 상태이며, 필요가 없다면 삭제
			밑에 td /td 반복한 부분은 테이블 왼쪽에 여백을 만들려고 넣은 것

		*/
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID=(String) session.getAttribute("userID");
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
			<%
				// 로그인 안된경우
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인 상태인 경우
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="myPage.jsp" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><%=userID%> <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="myPage.jsp">마이페이지</a></li>
						<li><a href="user/logout_process.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron" style="background-color: #BCF5A9">
			<div class="container">
				<h2>Study for 4.5</h2>
				<h4>다른 유저와 공부 팁을 공유해서 더 나은 공부 팁을 찾아 가는 곳입니다.</h4>
				<br>
				<a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a>
			</div>
		</div>
	</div>
	<div class="board table">
		<table class="table table-hover">
			<tr>
				<td>
					
				</td>
				<td>
					
				</td>
				<td>
					
				</td>
				<td>
					
				</td>
				<td>
					
				</td>
				<td>
					
				</td>
				<td>
					<h4>자유게시판</h4>
					<h5>자유롭게 다른 유저들과 대화하는 공간입니다.</h5>
					<br>
					<a class="btn btn-primary btn-pull" href="board/board_free.jsp" role="button">바로가기</a>
				</td>
				<td>
					<h4>팁 공유 게시판</h4>
					<h5>여러분들만 아는 공부 팁들을 공유하는 곳입니다.</h5>
					<br>
					<a class="btn btn-primary btn-pull" href="board/board_tip.jsp" role="button">바로가기</a>
				</td>
				<td>
					<h4>질문게시판</h4>
					<h5>모르는게 있다고요?!? 여기다가 질문하는 건 어떤가요?</h5>
					<br>
					<a class="btn btn-primary btn-pull" href="board/board_question.jsp" role="button">바로가기</a>
				</td>
			</tr>
		</table>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>

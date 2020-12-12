<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
	<%
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
			<a class="navbar-brand" href="board/board_free.jsp" style="font-size:1.0em">자유게시판</a>
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
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><%=userID%> <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="user/logout_process.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="panel panel-default">
  		<div class="panel-heading">내 글 보기</div>
  		<div class="panel-body">
    		<table class="table table-hover">
				<tr>
					<th scope="col" class="text-left">글 보이는 곳</th>
				</tr>
				<tr>
					<th scope="col" class="text-left">글 보이는 곳</th>
				</tr>
				<tr>
					<th scope="col" class="text-left">글 보이는 곳</th>
				</tr>
				<tr>
					<th scope="col" class="text-right"><a href="#"><h6>모든 글 보기</h6></a></th>
				</tr>
			</table>
  		</div>
	</div>

	<div class="panel panel-default">
  		<div class="panel-heading">
    		<h3 class="panel-title">스크랩</h3>
  		</div>
  		<div class="panel-body">
    		<table class="table table-hover">
				<tr>
					<th scope="col" class="text-left">글 보이는 곳</th>
				</tr>
				<tr>
					<th scope="col" class="text-left">글 보이는 곳</th>
				</tr>
				<tr>
					<th scope="col" class="text-left">글 보이는 곳</th>
				</tr>
				<tr>
					<th scope="col" class="text-right"><a href="#"><h6>모든 글 보기</h6></a></th>
				</tr>
			</table>
  		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
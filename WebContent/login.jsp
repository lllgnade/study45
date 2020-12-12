<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	/*
		main.jsp에서 이어지는 게시판 소스들 필요
		마이페이지 및 스크랩 페이지 소스 필요
	*/
	String location = request.getParameter("location");
	if(location==null)
		location="main";
	
%>
	<%-- 네비게이션  --%>
	<nav class="navbar navbar-default" style="background-color: #CEF6F5">
 		<div class="navbar-header">   			
    		<a class="navbar-brand" href="main.jsp">Study for 4.5</a>
  		</div>
	</nav>
	<%-- 로그인 폼 --%>
	<div class="container">
 		<div class="login"></div>
 		<div class="login">
   			<div class="jumbotron" style="padding-top: 20px;">
   				<form action="user/login_process.jsp?location=<%=location%>" method="post">
    				<h3 style="text-align: center;"> 게시판에 들어가려면 로그인이 필요합니다. </h3>
    				<div class="form-group">
     					<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
    				</div>      
    				<div class="form-group">
     					<input type="password" class="form-control" placeholder="비밀번호" name="pwd" maxlength="20">
    				</div>
   					<input type="submit" class="btn btn-primary form-control" value="로그인">        
   				</form>   
			</div>
		</div>
		<div class="login"></div>
	</div>
	<%-- 회원가입 --%>
	<div class="container">
		<div class="join"></div>
		<div class="join">
			<div class="jumbotron" style="padding-top: 10px;">
				<a href="join.jsp"><input type="submit" class="btn btn-privary form-control" value="회원가입"></a>
			</div>
		</div>
		<div class="join"></div>
	</div>
</body>
</html>
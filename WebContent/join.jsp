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

	<%-- 네비게이션  --%>
	<nav class="navbar navbar-default">
 		<div class="navbar-header">   			
    		<a class="navbar-brand" href="main.jsp">Study for 4.5</a>
  		</div>
	</nav>
	<%-- 로그인 폼 --%>
	<div class="container">
 		<div class="login"></div>
 		<div class="login">
   			<div class="jumbotron" style="padding-top: 20px;">
   				<form action="join_process.jsp" method="post">
    				<h3 style="text-align: center;">회원가입</h3>
    				<div class="form-group">
     					<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
    				</div>      
    				<div class="form-group">
     					<input type="password" class="form-control" placeholder="비밀번호" name="pwd" maxlength="20">
    				</div>
    				<div class="form-group">
     					<input type="text" class="form-control" placeholder="이름" name="name" maxlength="20">
    				</div>
    				<div class="form-group" style="text-align:center;">
     					<div class="btn-group btn-group-toggle" data-toggle="button" >
     						<label class="btn btn-primary active">
     							<input type="radio" name="gender" value="남자" autocomplete="off" checked>남자
     						</label>
     						<label class="btn btn-primary">
     							<input type="radio" name="gender" value="여자" autocomplete="off">여자
     						</label>
     					</div>
     				</div>
     				<div class="form-group">
     					<input type="email" class="form-control" placeholder="이메일" name="email" maxlength="20">
    				</div>
   					<input type="submit" class="btn btn-primary form-control" value="회원가입">        
   				</form>   
			</div>
		</div>
		<div class="login"></div>
	</div>
</body>
</html>
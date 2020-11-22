<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserVO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="userInfo" class="user.UserVO" scope="page" />
<jsp:setProperty property="userID" name="userInfo" />
<jsp:setProperty property="pwd" name="userInfo" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-sale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>study for 4.5</title>
</head>
<body>
	<% 
	UserDAO userDAO = new UserDAO();
	String answer = null;
	try {
		answer = userDAO.verifyIdPwd(userInfo.getUserID(), userInfo.getPwd());
	} catch (Exception e) {
		session.invalidate();
	}

	if ("ok".equals(answer)) { //로그인 성공시
		session.setAttribute("userID", userInfo.getUserID()); //세션에 로그인 정보 (새로) 바인딩
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} else { //실패시
		session.invalidate(); //세션 날림

		if ("id".equals(answer)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당 아이디가 존재하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if ("pwd".equals(answer)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀렸습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 오류')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
	%>
</body>
</html>
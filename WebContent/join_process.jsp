<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="userInfo" class="user.UserVO" scope="page"/>
<jsp:setProperty property="userID" name="userInfo"/>
<jsp:setProperty property="pwd" name="userInfo"/>
<jsp:setProperty property="name" name="userInfo"/>
<jsp:setProperty property="gender" name="userInfo"/>
<jsp:setProperty property="email" name="userInfo"/>

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
	if(userInfo.getUserID() == null || userInfo.getPwd() == null ||userInfo.getName() == null ||
			userInfo.getGender() == null ||userInfo.getEmail() == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else{
		UserDAO userDAO = new UserDAO();

		//ID, 이메일 중복 여부 체크
		String checkResult = userDAO.checkExistUser(userInfo);
		if(!"ok".equals(checkResult)) {
			if("id".equals(checkResult)){ //id 중복일 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 사용된 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if("email".equals(checkResult)){ //email 중복일 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 사용된 이메일 주소입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}else{
			
			String answer = null;
			try {
				answer = userDAO.addUser(userInfo);
			} catch (Exception e) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			if("ok".equals(answer)){
				session.setAttribute("userID", userInfo.getUserID()); //세션에 로그인 정보 (새로) 바인딩
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
		
	}
%>
</body>
</html>
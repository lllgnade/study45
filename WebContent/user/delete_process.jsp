<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userID");
%>

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
		UserDAO userDAO = new UserDAO();
		String answer = userDAO.deleteUser(userID);
		
		if(!"ok".equals(answer)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('실패하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제 성공')");
			script.println("location.href = 'userlist.jsp'");
			script.println("</script>");
		}
%>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="board.BoardVO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"  />  

<%
	request.setCharacterEncoding("UTF-8");
	BoardDAO boardDAO = new BoardDAO();
	List<BoardVO> boardlist = boardDAO.boardlist();
%>

<html>
<head>
<meta charset="UTF-8">
<title>게시물 정보 출력창</title>
<style>
.cls1 {
	font-size: 40px;
	text-align: center;
}

.cls2 {
	font-size: 20px;
	text-align: center;
}
</style>
</head>
<body>
	<p class="cls1">게시물 정보(관리자용)</p>
	<table align="center" border="1">
		<tr align='center' bgcolor='lightgreen'>
			<td width="7%"><b>글 번호</b></td>
			<td width="7%"><b>게시판명</b></td>
			<td width="7%"><b>작성자 이름</b></td>
			<td width="7%"><b>작성자 아이디</b></td>
			<td width="7%"><b>글 제목</b></td>
			<td width="7%"><b>내용</b></td>
			<td width="7%"><b>작성일자</b></td>
			<td width="7%"><b>조회수</b></td>
			<td width="7%"><b>사용가능여부</b></td>
			<td width="7%"><b>수정하기</b></td>
			<td width="7%"><b>삭제하기</b></td>
		</tr>

		<c:choose>
			<c:when test="<%=boardlist==null%>">
				<tr>
					<td colspan=7><b>등록된 글이 없습니다.</b></td>
				</tr>
			</c:when>
			<c:when test="<%=boardlist!=null%>">
				<c:forEach var="board" items="<%=boardlist%>">
					<tr align='center'>
						<td>${board.boardNo}</td>
						<td>${board.boardType}</td>
						<td>${board.name}</td>
						<td>${board.userID}</td>
						<td>${board.title}</td>
						<td>${board.contents}</td>
						<td>${board.regDate}</td>
						<td>${board.readCount}</td>
						<td>${board.boardAvailable}</td>
						<td><a href="${contextPath}/board/update.jsp?boardNo=${board.boardNo}&boardType=${board.boardType}">수정</a></td>
						<td>
						<form method="post" action="DB_delete_process.jsp">
   						<input type="hidden" name="_method" value="delete"/>
   						<input type="hidden" name="boardNo" value="${board.boardNo}"/>
   						<input type="submit" value="완전삭제(주의)" >
						</form>
						</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	
</body>
</html>


<%-- 
		<%
			for (int i = 0; i < usersList.size(); i++) {
				UserVO userVO = (UserVO) usersList.get(i);
				String id = userVO.getId();
				String pwd = userVO.getPwd();
				String name = userVO.getName();
				String gender = userVO.getGender();
				String age = userVO.getAge();
		%>
		<tr align='center'>
			<td><%=id%></td>
			<td><%=pwd%></td>
			<td><%=name%></td>
			<td><%=gender%></td>
			<td><%=age%></td>
		</tr>
		
		<%
			}
		%>
		
--%>
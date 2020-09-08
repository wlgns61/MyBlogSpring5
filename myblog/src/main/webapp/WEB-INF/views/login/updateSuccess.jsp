<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Success</title>
</head>

<body>
<div class="jumbotron">
  <h1>비밀번호가 변경 되었습니다.</h1>
  <p>다시 로그인 해주세요.</p>
	<p>
		<form action="${pageContext.request.contextPath}/logout" method="POST">
			<input type="hidden" value="Logout" />					
			<a href="#" class="btn btn-primary btn-lg" onclick="this.parentNode.submit()">Login</a>
		</form>
	</p>
</div>
</body>
</html>
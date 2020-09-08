<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script>
	function fn_btnSignupClick(){ 
		location.href ="${pageContext.request.contextPath}/login/signupForm"; 
	}
</script>
</head>
<body>
	<!-- login form -->
	<form:form class="form-signin" modelAttribute="userVO" method="POST" name="form" id="form" action="${pageContext.request.contextPath}/login/doLogin">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
		<div class="text-center mb-4">
			<h1 class="h3 mb-3 font-weight-normal">JIHOON Story</h1>	
		</div>
		<div class="form-label-group">
			<input type="text" id="uid" name="uid" placeholder="UserID" class="form-control" required="" autofocus=""/>
			<label for="uid" class="sr-only">User ID</label>
		</div>
		<div class="form-label-group"> 
			<input type="password" id="pwd" name="pwd" placeholder="User Password" class="form-control" required=""/>
			<label for="pwd" class="sr-only">User Password</label> 
		</div> 
		<c:if test="${not empty param.error}">
			<div id='checkForm' style='color:red; font-size:9.5pt;'>존재하지 않는 아이디 또는 잘못된 비밀번호 입니다.</div>
        </c:if>
		<button type= "submit" class="btn btn-lg btn-primary btn-block" id="login">Log in</button> 
		<span style="font-size:11pt;"> <a href="#" onClick="fn_btnSignupClick()">Sign up</a> </span> 
		<p class="mt-5 mb-3 text-muted text-center">© 2020. J.Hoon All rights reserved.</p> 
	</form:form> 
	<!-- login form {e} -->
</body>
</html>
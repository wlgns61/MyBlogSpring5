<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"   
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="   
	crossorigin="anonymous">
</script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" 
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" 
	crossorigin="anonymous"/>
	
<!-- common CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/common.css" type="text/css"/>

<!-- popper -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" 
		integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" 
		crossorigin="anonymous">
</script>

<script>

	function dropping(item) {
  		document.getElementById(item).classList.toggle("show");
	}
	
	$(document).on('click', '#dropdown02', function(){
		$.ajax({
			url: "${pageContext.request.contextPath}/restMenu/getMenuList"
			, data: {}
			, type: "POST"
			, dataType: "json"
			, beforeSend : function(xhr) {   //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
              }
			, success: function(result){
				var htmls = "";
				if(result.status == "OK"){
					result.menuList.forEach(function(e) { 
						htmls += '<a class="dropdown-item" href="${pageContext.request.contextPath}/board/getBoardList?category=' + e.codename + '">' +e.codename + '</a>';
					});
					$("#showHeaderMenuList").html(htmls);	
				}
			}
			, error: function(error){
				
			}
		});
	});
	
</script>

<!--nav bar-->
<nav class="navbar navbar-expand-sm navbar-dark bg-dark" style="margin-bottom: 2%;">
	<a class="navbar-brand" href="${pageContext.request.contextPath}/board/getBoardList">JIHOON STORY</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample03" aria-controls="navbarsExample03" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	</button>
	
	<div class="collapse navbar-collapse" id="navbarsExample03">
	    <ul class="navbar-nav mr-auto">
	    	
	    	<li class="nav-item dropdown">
	      		<a class="nav-link dropdown-toggle" href="javascript:dropping('menu');" id="dropdown01" data-toggle="dropdown" data-target="#menu" aria-haspopup="true" aria-expanded="false">My Info</a>
	      		<div class="dropdown-menu" aria-labelledby="dropdown01" id="menu">
	      			<form action="${pageContext.request.contextPath}/user/updateUser" method="POST" name="userVO" id="userVO">
	      				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">	
			        	<a class="dropdown-item" onclick="this.parentNode.submit()" href="#">비밀번호 변경</a>
			        </form>
			        <a class="dropdown-item" href="${pageContext.request.contextPath}/board/getBoardList?searchType=reg_id&keyword=${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">내가 올린 글</a>
			    </div>
	    	</li>
	    	
	    	<li class="nav-item dropdown">
	      		<a class="nav-link dropdown-toggle" href="javascript:dropping('category');" id="dropdown02" data-toggle="dropdown" data-target="#menu" aria-haspopup="true" aria-expanded="false">Category</a>
	      		<div class="dropdown-menu" aria-labelledby="dropdown02" id="category">
	      			<div id="showHeaderMenuList"></div>
			    </div>
	    	</li>
	    	<c:if test="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.authority == 'ROLE_ADMIN'}">
		    	<li class="nav-item dropdown">
		      		<a class="nav-link dropdown-toggle" href="javascript:dropping('admin');" id="dropdown03" data-toggle="dropdown" data-target="#admin"  aria-haspopup="true" aria-expanded="true">Admin</a>
		      		<div class="dropdown-menu" aria-labelledby="dropdown03" id="admin">
				        <a class="dropdown-item" href="${pageContext.request.contextPath}/menu/getMenuList">Menu List</a>
				        <a class="dropdown-item" href="${pageContext.request.contextPath}/user/getUserList">User List</a>
				    </div>
		    	</li>
	    	</c:if>
	  	</ul>
	  	<form class="form-inline my-2 my-md-0" action="${pageContext.request.contextPath}/logout" method="POST">
			<input type="hidden" value="Logout" />					
			<a href="#" class="nav-link" onclick="this.parentNode.submit()">Logout</a>
		</form>
	</div>
</nav>
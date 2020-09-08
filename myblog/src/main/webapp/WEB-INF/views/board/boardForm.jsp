<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri = "http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<title>board</title>
		
		<script src="//cdn.ckeditor.com/4.14.1/standard/ckeditor.js"></script>
		
		<script>
			$(document).on('click', '#btnSave', function(e){
				if($("#title").val() == ""){
					alert("제목을 입력해 주세요.");
				}
				else{
					e.preventDefault();
					$("#form").submit();	
				}
			});
			$(document).on('click', '#btnList', function(e){
				e.preventDefault();
				location.href="${pageContext.request.contextPath}/board/getBoardList";
			});
			$(document).ready(function(){
				var mode = '<c:out value="${mode}"/>';
				if ( mode == 'edit'){
					//입력 폼 셋팅
					$("#reg_id").prop('readonly', true);
					$("input:hidden[name='bid']").val(<c:out value="${boardContent.bid}"/>);
					$("input:hidden[name='mode']").val('<c:out value="${mode}"/>');
					$("#title").val('<c:out value="${boardContent.title}"/>');
					$("#cate_cd").val('<c:out value="${boardContent.cate_cd}"/>');
				}
			});
		</script>
	</head>
	<body>
		<article>
			<div class="container" role="main">
				<h2>board Form</h2>
				<form:form name="form" id="form" role="form" modelAttribute = "boardVO" method="post" action="${pageContext.request.contextPath}/board/saveBoard">
					<form:hidden path="bid"/>
					<input type="hidden" name="mode"/>
					
					<div class="mb-3">
						<label for="title">제목</label>
						<form:input path="title" type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요"/>
					</div>
					
					<div class="mb-3">
						<label for="content">내용</label>
						<c:choose>
							<c:when test="${mode == 'edit'}">
								<textarea path="content" class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요">${boardContent.content}</textarea>
							</c:when>
							<c:otherwise>
								<form:textarea path="content" class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" />
							</c:otherwise>
						</c:choose>
					</div>
					<!-- p태그가 문제 원인 -->
					<script src="${pageContext.request.contextPath}/resources/common/js/ckeditor.js"></script>
					
					<div class="mb-3">
						<p>카테고리</p>
						<form:select name="cate_cd" path="cate_cd"  id="cate_cd">
							<c:forEach var="list" items="${menuList}">
								 <option value="${list.codename}">${list.codename}</option>
							</c:forEach>
						</form:select>
					</div>
					
					<form:input type="hidden" name="mode" path="reg_id" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}"/>
				</form:form>
				<div >
					<button type="button" class="btn btn-sm btn-primary" id="btnSave">저장</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
				</div>
			</div>
		</article>
	</body>
</html>

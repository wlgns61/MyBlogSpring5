<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script>
		
			$(document).on('click', '#btnWriteForm', function(e){
				e.preventDefault();
				location.href = "${pageContext.request.contextPath}/board/boardForm";
			});
			
			function getParam(sname) {
			    var params = location.search.substr(location.search.indexOf("?") + 1);
			    var sval = "";
			    params = params.split("&");
			    for (var i = 0; i < params.length; i++) {
			        temp = params[i].split("=");
			        if ([temp[0]] == sname) { sval = temp[1]; }
			    }
			    return sval;
			}
			
			function fn_contentView(bid){
				var url = "${pageContext.request.contextPath}/board/getBoardContent";
				url = url + "?bid="+bid;
				location.href = url;
			}
			
			//이전 버튼 이벤트
			function fn_prev(page, range, rangeSize) {
				var page = ((range - 2) * rangeSize) + 1;
				var range = range - 1;
				
				var url = "${pageContext.request.contextPath}/board/getBoardList";
				url = url + "?page=" + page;
				url = url + "&range=" + range;
				url = url + "&category=" + getParam("category");
				
				location.href = url;
			}

			  //페이지 번호 클릭
			function fn_pagination(page, range, rangeSize, searchType, keyword) {
				var url = "${pageContext.request.contextPath}/board/getBoardList";
				url = url + "?page=" + page;
				url = url + "&range=" + range;
				url = url + "&searchType=" + $('#searchType').val();
				url = url + "&keyword=" + keyword;
				url = url + "&category=" + getParam("category");

				location.href = url;	
			}


			//다음 버튼 이벤트
			function fn_next(page, range, rangeSize) {
				var page = parseInt((range * rangeSize)) + 1;
				var range = parseInt(range) + 1;
				
				var url = "${pageContext.request.contextPath}/board/getBoardList";
				url = url + "?page=" + page;
				url = url + "&range=" + range;
				url = url + "&category=" + getParam("category");
				location.href = url;
			}
			
		    // 생략	
			$(document).on('click', '#btnSearch', function(e){
				e.preventDefault();
				var url = "${pageContext.request.contextPath}/board/getBoardList";
				url = url + "?searchType=" + $('#searchType').val();
				url = url + "&keyword=" + $('#keyword').val();
				url = url + "&category=" + getParam("category");
				location.href = url;
				console.log(url);
			});	
		</script>
	</head>
	
	<body>
		<article>
			<div class="container">
				<div class="table-responsive">
					<p>${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}님 환경합니다.</p>
					<c:choose>
						<c:when test="${searchType=='reg_id'}" >
							<h2>${search.keyword}님의 글</h2>
						</c:when>
						<c:when test="${empty category}" >
							<h2>All Content</h2>
						</c:when>
						<c:when test="${!empty category}" >
							<h2>${category}</h2>
						</c:when>
					</c:choose>
					<table class="table table-striped table-sm">
						<colgroup>
							<col style="width:9%; font-size:7pt;" />
							<col style="width:auto;" />
							<col style="width:15%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>글제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty boardList }" >
									<tr><td colspan="5" align="center">데이터가 없습니다.</td></tr>
								</c:when> 
								<c:when test="${!empty boardList}">
									<c:forEach var="list" items="${boardList}">
										<tr>
											<td style="font-size:9pt;"><c:out value="${list.cate_cd}"/></td>
											<td>
												<a href="#" onClick="fn_contentView(<c:out value="${list.bid}"/>)">
													<c:out value="${list.title}"/>
												</a>
											</td>
											<td><c:out value="${list.reg_id}"/></td>
											<td><c:out value="${list.view_cnt}"/></td>
											<td><c:out value="${list.reg_dt}"/></td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
			<div class="container">
				<div>
					<button type="button" class="btn btn-sm btn-primary" id="btnWriteForm">글쓰기</button>
				</div>
				<!-- pagination{s} -->
				<div id="paginationBox" style="margin-top:1%;">
					<ul class="pagination">
						<c:if test="${pagination.prev}">
							<li class="page-item">
								<a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}' '${pagination.rangeSize}')">Previous</a>
							</li>
						</c:if>
							
						<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
							<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
								<a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}','${search.searchType}', '${search.keyword}')"> ${idx} </a>
							</li>
						</c:forEach>
							
						<c:if test="${pagination.next}">
							<li class="page-item">
								<a class="page-link" href="#" onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" >Next</a>
							</li>
						</c:if>
					</ul>
				</div>
				<!-- pagination{e} -->
				
				<!-- search{s} -->
				<div class="form-group row justify-content-center">
					<div class="w100" style="padding-right:10px">
						<select class="form-control form-control-sm" name="searchType" id="searchType" onChange="{this.onChange.bind(this)}">
							<option value="title" ${searchType eq 'title' ? "selected":""}>제목</option>
							<option value="content" ${searchType eq 'content' ? "selected":""}>본문</option>
							<option value="reg_id" ${searchType eq 'reg_id' ? "selected":""}>작성자</option>
						</select>
					</div>
					<div class="w300" style="padding-right:10px">
						<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
					</div>
					<div>
						<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
					</div>
				</div>
				<!-- search{e} -->
			</div>
		</article>
	</body>
</html>
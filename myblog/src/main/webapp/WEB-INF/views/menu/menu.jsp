<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html> 
<html> 
<head> 
	<meta charset="UTF-8"> 
	<title>Menu List</title> 
	<script>
	
		$(function(){ 
			fn_showList(); 
		});
		
		function fn_showList(){
			var paramData = {};
			var url = "${pageContext.request.contextPath}/restMenu/getMenuList";
			$.ajax({
				url: url
				, type: 'POST'
				, dataType: "json"
				, data: paramData
				,beforeSend : function(xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
              	}
				, success: function(result){
					console.log(result); 
					if (result.status == "OK"){ 
						if ( result.menuList.length > 0 ) { 
							var list = result.menuList; 
							var htmls = ""; 
							result.menuList.forEach(function(e) { 
								htmls += '<tr>'; 
								htmls += '<td>' + e.mid + '</td>'; 
								//htmls += '<td>' + e.code + '</td>';
								htmls += '<td>'; 
								htmls += '<a href="#" onClick="fn_menuInfo(' + e.mid + ',\'' + e.code +'\',\'' + e.codename + '\', ' + e.sort_num + ', \'' + e.comment + '\')" >'; 
								htmls += e.code; 
								htmls += '</a>'; 
								htmls += '</td>';
								
								htmls += '<td>' + e.codename + '</td>'; 
								htmls += '<td>' + e.sort_num + '</td>'; 
								htmls += '<td>' + e.comment + '</td>'; 
								htmls += '</tr>'; 
							}); 
						} 
						else { 
							console.log("조회실패"); 
						}
					}
					$('#menuList').html(htmls);
				}
			});
		}
		
		//메뉴 정보 셋 
		function fn_menuInfo(mid, code, codename, sort_num, comment) {
			$("#mid").val(mid); 
			$("#code").val(code); 
			$("#codename").val(codename); 
			$("#sort_num").val(sort_num); 
			$("#comment").val(comment); 
			//코드 부분 읽기 모드로 전환 
			$("#code").attr("readonly", true); 
		}
		
		$(document).on("click", "#btnSave", function(e){
			e.preventDefault();
			var url = "${pageContext.request.contextPath}/restMenu/saveMenu";
			
			if ($("#mid").val() != 0) { 
				url = "${pageContext.request.contextPath}/restMenu/updateMenu"; 
			}
			var paramData = {"code" : $("#code").val()
							, "codename": $("#codename").val()
							, "sort_num" : $("sort_num").val()
							, "comment" : $("#comment").val()};
			if($("#code").val() == "" || $("#codename").val() == ""){
				alert("다시 입력해 주세요");
				return;
			}
			$.ajax({
				url : url
				, data : paramData
				, type : "POST"
				, dataType : "json"
				,beforeSend : function(xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
              	}
				, success : function(result){
					if(result.status == "OK"){
						alert("저장 완료")
						fn_showList();	
						$("#code").attr("readonly", false);	
						$('#mid').val(''); 
						$('#code').val(''); 
						$('#codename').val(''); 
						$('#sort_num').val(''); 
						$('#comment').val(''); 
					}
					else{
						alert("이미 존재하는 게시판 입니다.");
					}
					 
				}				
			});
		})
		
		//초기화 버튼 이벤트 부분 추가 
		$(document).on('click', '#btnInit', function(e){ 
			//코드 부분 읽기 모드로 전환 
			$("#code").attr("readonly", false);
			$('#mid').val(''); 
			$('#code').val(''); 
			$('#codename').val(''); 
			$('#sort_num').val(''); 
			$('#comment').val(''); 
		});
		
		$(document).on('click', '#btnDelete', function(e){ 
			e.preventDefault(); 
			if ($("#code").val() == "") { 
				alert("삭제할 코드를 선택해 주세요."); 
				return; 
			} 
			var url = "${pageContext.request.contextPath}/restMenu/deleteMenu"; 
			var paramData = { "code" : $("#code").val() }; 
			$.ajax({ 
				url : url 
				, type : "POST" 
				, dataType : "json" 
				, data : paramData 
				, beforeSend : function(xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
              	}
				, success : function(result){ 
					if (confirm("정말 삭제하시겠습니까??") == true){    //확인
						fn_showList(); //삭제 후 셋팅값 초기
						$("#btnInit").trigger("click"); 
						$("#code").attr("readonly", false); 	   
					}else{   //취소
					    return;
					}
				} 
			}); 
		});
		
	</script> 
	<style> 
		#paginationBox{ padding : 10px 0px; } 
	</style> 
</head> 
<body> 
	<article> 
		<div class="container"> 
			<!-- Menu form {s} --> 
			<h4 class="mb-3">Menu Info</h4> 
			<div> 
				<form:form name="form" id="form" role="form" modelAttribute="menuVO" method="post" action="${pageContext.request.contextPath}/menu/saveMenu"> 
					<form:hidden path="mid" id="mid"/> 
					<div class="row"> 
						<div class="col-md-4 mb-3"> 
							<label for="code">게시판 이름</label> 
							<form:input path="code" id="code" class="form-control" placeholder="" value="" required="" /> 
							<div class="invalid-feedback"> Valid Code is required. </div> 
						</div> 
						<div class="col-md-5 mb-3"> 
							<label for="codename">게시판 이름</label> 
							<form:input path="codename" class="form-control" id="codename" placeholder="" value="" required="" /> 
							<div class="invalid-feedback"> Valid Code name is required. </div> 
						</div> 
					</div> 
					<div class="row"> 
						<div class="col-md-12 mb-3"> 
							<label for="comment">Comment</label> 
							<form:input path="comment" class="form-control" id="comment" placeholder="" value="" required="" /> 
						</div>
					</div> 
				</form:form> 
			</div> 
			<!-- Menu form {e} --> 
			<div> 
				<button type="button" class="btn btn-sm btn-primary" id="btnSave">저장</button> 
				<button type="button" class="btn btn-sm btn-primary" id="btnDelete">삭제</button> 
				<button type="button" class="btn btn-sm btn-primary" id="btnInit">초기화</button> 
			</div> 
			<h4 class="mb-3" style="padding-top:15px">Menu List</h4> 
			<!-- List{s} --> 
			<div class="table-responsive"> 
				<table class="table table-striped table-sm"> 
					<colgroup> 
						<col style="width:10%;" /> 
						<col style="width:15%;" /> 
						<col style="width:15%;" /> 
						<col style="width:10%;" /> 
						<col style="width:auto;" /> 
					</colgroup> 
					<thead> 
						<tr> 
							<th>menu id</th> 
							<th>code</th> 
							<th>codename</th> 
							<th>sort</th> 
							<th>command</th> 
						</tr>
					</thead> 
					<tbody id="menuList"> </tbody> 
				</table> 
			</div> 
			<!-- List{e} --> 
		</div> 
	</article> 
</body> 
</html>
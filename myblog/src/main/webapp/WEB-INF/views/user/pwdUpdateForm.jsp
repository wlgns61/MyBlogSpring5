<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<html>
<head>
<script>

	$(document).on('click', '#btnSignup', function(e){
		if($('#newpwd').val() == ""){
			alert("비밀번호를 입력해 주세요.");
		}
		else if($('#isPwdSame').attr("value") == 'false' ){
			alert("비밀번호가 일치하지 않습니다.");
		}
		else{
			e.preventDefault(); 
			$("#form").submit();	
		}
	}); 
	$(function(){ 
		$("input").keyup(function(){ 
			var pwd1 = $("#newpwd").val(); 
			var pwd2 = $("#re_pwd").val();
			if(pwd1 == "" && pwd2 == "" ){
				$("#pwdCheck").html("");
			}
			else if(pwd1 != "" || pwd2 != ""){
				var htmls = "";
				if(pwd1 == pwd2){ 
					htmls += "<div id='isPwdSame' style='font-size:10pt;' value='true'>";
					htmls += "비밀번호가 일치합니다.";
					htmls += "</div>";
					$("#pwdCheck").html(htmls);
				}
				else{  
					htmls += "<div id='isPwdSame' style='color:red; font-size:10pt;' value='false' >";
					htmls += "비밀번호가 일치하지 않습니다.";
					htmls += "</div>";
					$("#pwdCheck").html(htmls); 
				} 
			} 
		}); 
	});
	$(document).on('click', '#btnCancel', function(e){ 
		e.preventDefault(); 
		$('#newpwd').val(''); 
		$('#re_pwd').val('');  
		location.href="${pageContext.request.contextPath}/board/getBoardList"; 
	});
	
</script>
</head>
<body>
<article> 
	<div class="container col-md-6" role="main"> 
		<div class="card"> 
			<div class="card-header">비밀번호 변경</div> 
			<div class="card-body"> 				
				<form id="form" action="${pageContext.request.contextPath}/user/updatePwd" method="POST">	
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">		
					<!-- result -->
					<div class="form-group row"> 
						<label class="col-md-3 col-form-label text-md-right">아이디</label> 
						<div class="col-md-5"> 
							<span>${nowUser.uid}</span> 
						</div> 
					</div> 
					<div class="form-group row"> 
						<label class="col-md-3 col-form-label text-md-right">새 비밀번호</label> 
						<div class="col-md-5"> 
							 <input type="hidden" id="uid" name="uid" value="${nowUser.uid}"/>
							 <input type="password" id="newpwd" name="newpwd"/>
						</div>
					</div> 
					
					<div class="form-group row"> 
						<label class="col-md-3 col-form-label text-md-right">비밀번호 확인</label> 
						<div class="col-md-5"> 
							 <input type="password" id="re_pwd"/>
						</div>
					</div> 
					
					<div class="form-group row"> 
						<label class="col-md-3 col-form-label text-md-right"></label> 
						<div class="col-md-5"> 
							 <div id="pwdCheck" ></div>
						</div>
					</div> 
				</form>
			</div> 
		</div> 
		<div style="margin-top:10px"> 
			<button type="button" class="btn btn-sm btn-primary" id="btnSignup">변경하기</button> 
			<button type="button" class="btn btn-sm btn-primary" id="btnCancel">취소</button> 
		</div> 
	</div> 
</article>
</body>
</html>
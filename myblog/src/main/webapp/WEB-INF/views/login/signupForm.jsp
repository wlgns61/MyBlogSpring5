<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<html>
<head>
<script>
	$(document).on('click', '#btnValidate', function(e){ 
		var uid = $("#uid").val();
		var paramData = {"uid" : uid};
		$.ajax({
			url: "${pageContext.request.contextPath}/restLogin/userValidate"
			, data: paramData
			, type: "POST"
			, dataType: "text"
			, beforeSend : function(xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
              }
			, success: function(result){
				if(result == 0 && uid != ""){
					var htmls = "";
					htmls += "<div id='possible' style=' font-size:10pt;' value='true'>";
					htmls += "사용 가능한 ID 입니다."
					htmls += "</div>"
					$("#validateResult").html(htmls);
				}
				else{
					var htmls = "";
					htmls += "<div id='impossible' style='color:red; font-size:10pt;'>";
					htmls += "사용 불가능한 ID 입니다.";
					htmls += "</div>";
					$("#validateResult").html(htmls);
				}
			}
			, error: function(error){
				
			}
		});
	});
	$(document).on('click', '#btnSignup', function(e){
		
		var emailRegExp =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if($("#possible").attr("value")!='true'){
			alert("ID 중복검사를 해주세요");
		} 
		else if($('#uid').val() == ""){
			alert("ID를 입력해 주세요");
		}
		else if($('#name').val() == ""){
			alert("이름을 입력해 주세요");
		}
		else if($('#pwd').val() == ""){
			alert("비밀번호를 입력해 주세요.");
		}
		else if($('#isPwdSame').attr("value") == 'false' ){
			alert("비밀번호가 일치하지 않습니다.");
		}
		else if($('#email').val() == ""){
			alert("이메일을 입력해 주세요");
		}
		else if($('#email').val() != "" && $('#email').val().match(emailRegExp) == null){
			var htmls = "";
			htmls += "<div id='impossible' style='color:red; font-size:10pt;'>";
			htmls += "올바르지 않은 이메일입니다.";
			htmls += "</div>";
			$("#emailCheck").html(htmls);
		}
		else{
			e.preventDefault(); 
			$("#form").submit();	
		}
	}); 
	$(function(){ 
		$("input").keyup(function(){ 
			var pwd1 = $("#pwd").val(); 
			var pwd2 = $("#re_pwd").val(); 
			if(pwd1 != "" || pwd2 != ""){
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
		$('#uid').val(''); 
		$('#name').val(''); 
		$('#pwd').val(''); 
		$('#re_pwd').val(''); 
		$('#email').val(''); 
		location.href="${pageContext.request.contextPath}/login/loginForm"; 
	}); 
</script>
</head>
<body>
<article> 
	<div class="container col-md-6" role="main"> 
		<div class="card"> 
			<div class="card-header">회원가입</div> 
			<div class="card-body"> 
				<form:form name="form" id="form" class="form-signup" role="form" modelAttribute="userVO" method="post" action="${pageContext.request.contextPath}/user/insertUser" autocomplete='off'>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
					<!-- result -->
					<div id="validateResult"></div> 
					<div class="form-group row"> 
						<label for="uid" class="col-md-3 col-form-label text-md-right">아이디</label> 
						<div class="col-md-5"> 
							<form:input path="uid" id="uid" class="form-control" placeholder="아이디을 입력해 주세요" autocomplete='new-password'/> 
						</div> 
						<button type="button" class="btn btn-sm btn-primary" id="btnValidate">중복검사</button> 
					</div> 
					
					<div class="form-group row"> 
						<label for="name" class="col-md-3 col-form-label text-md-right">이름</label> 
						<div class="col-md-5"> 
							<form:input path="name" id="name" class="form-control" placeholder="이름을 입력해 주세요" autocomplete='off' />
							 
						</div> 
					</div> 
					
					<div class="form-group row"> 
						<label for="pwd" class="col-md-3 col-form-label text-md-right">비밀번호</label> 
						<div class="col-md-5"> 
							<form:password path="pwd" id="pwd" class="form-control" placeholder="비밀번호를 입력해 주세요" autocomplete='new-password' /> 
						</div>
					</div> 
					
					<div id="pwdCheck"></div> 
					<div class="form-group row"> 
						<label for="re_pwd" class="col-md-3 col-form-label text-md-right">비밀번호 확인</label> 
						<div class="col-md-5"> 
							<form:password path="re_pwd" id="re_pwd" class="form-control" placeholder="비밀번호를 입력해 주세요" autocomplete='off' /> 
						</div>
					</div> 
					
					<div id="emailCheck"></div>
					<div class="form-group row"> 
						<label for="email" class="col-md-3 col-form-label text-md-right">이메일</label> 
						<div class="input-group col-md-7"> 
							<div class="input-group-prepend"> 
								<span class="input-group-text">@</span> 
							</div> 
							<form:input path="email" id="email" class="form-control" placeholder="이메일을 입력해 주세요" autocomplete='off' /> 
						</div> 
					</div> 
					
				</form:form> 
			</div> 
		</div> 
		<div style="margin-top:10px"> 
			<button type="button" class="btn btn-sm btn-primary" id="btnSignup">회원가입</button> 
			<button type="button" class="btn btn-sm btn-primary" id="btnCancel">취소</button> 
		</div> 
	</div> 
</article>
</body>
</html> 

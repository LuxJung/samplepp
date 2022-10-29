<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!doctype html>
<html lang="ko">
<%
Cookie[] cookies = request.getCookies();
if(cookies != null){
    for(Cookie tempCookie : cookies){
        if(tempCookie.getName().equals("id")){
            //실행흐름이 서버에 있을때 서버코드로써 강제이동한다.
            //특정 page로 이동하라는 정보만 준다.
            response.sendRedirect("../index/index.jsp");
        }
    }
}
%>
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <meta name="description" content="">
   <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
   <meta name="generator" content="Hugo 0.104.2">
   <title>Best Seller</title>

   <link rel="stylesheet" type="text/css" href="../resource/css/bootstrap.css">
   
   <script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>
   <script type="text/javascript" src="../resource/js/bootstrap.bundle.min.js"></script>
   <script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
   <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
   <style>
      .bd-placeholder-img {
         font-size: 1.125rem;
         text-anchor: middle;
         user-select: none;
      }

      .b-example-divider {
         height: 3rem;
         background-color: rgba(0, 0, 0, .1);
         border: solid rgba(0, 0, 0, .15);
         border-width: 1px 0;
         box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
         flex-shrink: 0;
         width: 1.5rem;
         height: 100vh;
      }

      .nav-scroller {
         position: relative;
         z-index: 2;
         height: 2.75rem;
         overflow-y: hidden;
      }

      a {
         color: #999999;
         text-decoration: none;
      }

      .newatcl {
         position: fixed;
         right: 50px;
         bottom: 50px;
         font-size: 50px;
         width: 60px;
         height: 60px;
         background-color: #80d100;
         text-align: center;
         line-height: 50px;
         border-radius: 50%;
      }

      @media (min-width : 768px) {
         .bd-placeholder-img-lg {
            font-size: 3.5rem;
         }
      }

      .nav-scroller .nav {
         display: flex;
         flex-wrap: nowrap;
         padding-bottom: 1rem;
         margin-top: -1px;
         overflow-x: auto;
         text-align: center;
         white-space: nowrap;
         -webkit-overflow-scrolling: touch;
      }

      .bi {
         vertical-align: -.125em;
         fill: currentColor;
         color: #80d100;
         width: 150px;
         height: 150px;
      }

      .login_false {
         display: none;
      }

      .login_true {
         display: inline-block;
      }

      .mgt {
         margin-top: 30px;
      }

   </style>

</head>

<body class="text-center">
   <main class="form-signin mw-100 mh-auto mt-5">
      <form class="w-25 m-auto mh-50 mt-5" action="${contextPath}/userController/login.do" method="post">
         <img alt="#" class="bi me-2 mb-5" src="../resource/banner/logo_green.png">
         <h1 class="h3 mb-3 fw-normal">Login</h1>

         <div class="form-floating">
            <input type="text" class="form-control w-100 mb-3" id="floatingInput" placeholder="id" name="id">
            <label for="floatingInput">id</label>
         </div>
         <div class="form-floating">
            <input type="password" name="password" class="form-control w-100 mb-3" id="floatingPassword" placeholder="password">
            <label for="floatingPassword">Password</label>
         </div>
         
         <!--아이디 비번 틀렸을때 디스플레이 속성등등 사용해서..
         나타내주거나 ...-->
         <c:if test="${loginResult== -1 || loginResult==0}">
         <div class="alert alert-success" role="alert" >
          아이디 또는 비밀번호가 일치하지 않습니다.<br>
          다시 입력해주세요.
         </div>
         </c:if>
         
         <div class="checkbox mt-3 mb-3 ">
            <label>
               <input type="checkbox"  name="loginChk" value = "true"> 자동로그인
            </label>
         </div>
         <button class="w-100 btn btn-lg btn-success mb-3" type="submit">Sign in</button>
         <button class="w-100 btn btn-lg btn-success" type="button" onclick="location.href='../join/joinForm_2.jsp'">Sign up</button>
         
       
      </form>
        <a id="btn_kakao" href="#">
		  					<img src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="200" alt="카카오 로그인 버튼"/>
						</a>
		    		<form id="form_kakao" method="post" action="${contextPath}/userController/kakaologin.do">
		    			<input type="hidden" name="email"/>
		    			<input type="hidden" name="nickname"/>
		    			<button type="button" id="kakao_submit">카카오로그인</button>
		    			<input type="button" value="로그아웃" onclick="kakaoLogout()"/>		    		</form>
   </main>


  
  
  
<script type="text/javascript">
Kakao.init('a9bd1d62db585f44286b5451460b4031');

function kakaoLogout() {
	if (!Kakao.isInitialized()) {
		Kakao.init('a9bd1d62db585f44286b5451460b4031');
	};
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
            console.log(response)
            console.log('로그아웃 성공')
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  

$(function(){
	
	$("#kakao_submit").click(function(event){
		// a태그 기능 실행멈춤.
		//event.preventDefault();
		// 사용자 키를 전달, 카카오 로그인 서비스 초기화.
		if (!Kakao.isInitialized()) {
		Kakao.init('a9bd1d62db585f44286b5451460b4031');
	};
		// 카카오 로그인 서비스 실행하기 및 사용자 정보 가져오기.
		Kakao.Auth.login({
			success:function(auth){
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(response){
						// 사용자 정보를 가져와서 폼에 추가.
						var account = response.kakao_account;
						console.log('성공');
						
						$('#form_kakao input[name=email]').val(account.email);
						$('#form_kakao input[name=nickname]').val(account.profile.nickname);
						// 사용자 정보가 포함된 폼을 서버로 제출한다.
						document.querySelector('#form_kakao').submit();
					},
					fail: function(error){
						// 경고창에 에러메시지 표시
						console.log('오류가 발생했습니다.');
					}
				}); // api request
			}, // success 결과.
			fail:function(error){
				// 경고창에 에러메시지 표시
				console.log('오류가 발생했습니다.');
			}
		}); // 로그인 인증.
	}) // 클릭이벤트
})// 카카오로그인 끝.

</script>
</body>

</html>

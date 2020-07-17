<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<!doctype html>

<html>

<head>
<style>
	footer{ position:fixed; 
  left:0px; 
  bottom:0px; 
  height:70px; 
  width:100%; 
  background:grey; 
  color: white; }	<!-- footer 고정 -->
  </style>
  
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 너비에 맞게 설정 -->
	<title>견제팟 로그인</title>
	<! -- 부트스트랩 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/bootstrap.min.css">
	<! -- 커스텀 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/custom.css">
	
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-172961140-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-172961140-1');
</script>


</head>
  
<body>
<%

	String userID = null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}

	if(userID != null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인 상태입니다.');");

		script.println("location.href = 'index.jsp'");

		script.println("</script>");

		script.close();	

	}

%>	

	<nav class = "navbar navbar-expand-lg navbar-light bg-light">
		<a class = "navbar-brand" href="index.jsp">견제팟</a>
		<button class="navor-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class = "navbar-nav mr-auto">
				<li class ="nav-item">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class ="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id = "dropdown" data-toggle="dropdown">
					Menu
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%

	if(userID == null) {

%>
						<a class="dropdown-item active" href="userLogin.jsp">로그인</a>
						<!-- <a class="dropdown-item" href="userJoin.jsp">회원가입</a> -->
<%
	} else {

%>	
						<a class="dropdown-item" href="te.jsp">회원관리</a>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}

%>
					</div>
				</li>

			</ul>
		</div>
	</nav>
	<section class = "container mt-8" style= 'max-width: 560px;'>

		<form method = "post" action="./userLoginAction.jsp">
		<fieldset>
			<div class = "form-group" style="padding-top: 100px;">
				<label> 관리자 ID </label>
				<input type="text" name = "userID" class = "form-control">
			<div class = "form-group">
				<label> 비밀번호 </label>
				<input type = "password" name = "userPassword" class= "form-control">
			</div>
				<button type = "submit" class="btn btn-primary">확인</button>
				</div>
		</fieldset>
		</form>
		</section>
		
			 <footer class = "bg-dark mt -4 p -5 text-center" style = "color : #FFFFFF;">
			Copyright &copy; 2020 남현우 All Rights Reserved.
		</footer>
		
		<!-- <footer class = "bg-dark mt -4 p -5 text-center" style = "color : #FFFFFF;">
			Copyright &copy; 2020 남현우 All Rights Reserved.
		</footer> -->
	<!-- 제이쿼리 자바스크립트 추가하기 -->
  	<script src="./js/jquery.min.js"></script>
  	<!-- 파퍼 자바스크립트 추가하기 -->
  	<script src="./js/popper.js"></script>
  	<!-- 부트스트랩 자바스크립트 추가하기 -->
  	<script src="./js/bootstrap.min.js"></script>
</body>
</html>

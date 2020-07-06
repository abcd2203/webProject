<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>

<html>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 너비에 맞게 설정 -->
	<title>figertips 로그인</title>
	<! -- 부트스트랩 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/bootstrap.min.css">
	<! -- 커스텀 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/custom.css">
</head>
  
<body>
	<nav class = "navbar navbar-expand-lg navbar-light bg-light">
		<a class = "navbar-brand" href="index.jsp">fingertips</a>
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
					회원 관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">

						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item active" href="userJoin.jsp">회원가입</a>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
					</div>
				</li>

			</ul>
		</div>
	</nav>
	<section class = "container mt-8" style="max-width: 560px;">
		<form method = "post" action="./userRegisterAction.jsp">
			<div class = "form-group">
				<label>ID</label>
				<input type="text" name = "userID" class = "form-control">
			</div>
			<div class = "form-group">
				<label>비밀번호</label>
				<input type = "password" name = "userPassword" class= "form-control">
			</div>
				<label>이메일</label>
				<input type = "email" name = "userEmail" class= "form-control">
			<div>
				
			</div>
				<button type = "submit" class="btn btn-primary mt-3">가입</button>
		</form>
	</section>
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

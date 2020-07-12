<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<%@ page import="user.UserDAO"%>
<%@ page import="member.MemberDAO" %>
<%@ page import = "java.sql.*" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>

<%!String driverName = "com.mysql.jdbc.Driver";%>
<%!	//String url = "jdbc:mysql://namweb.iptime.org:3306/DB?useUnicode=true&characterEncoding=euc-kr"; // 라즈베리파이 DB 연결
	String url = "jdbc:mysql://localhost:8509/DB?useUnicode=true&characterEncoding=euc-kr";%>
<%!String user = "root";%>
<%!String pwd = "rus7wp850!@vkt";%>
<%!String Name = ""; %>

<%
Connection con = null;
PreparedStatement ps = null;
%>

<!Doctype html>

<html>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 너비에 맞게 설정 -->
	<title>견제팟</title>
<!-- 	<style>
			div { text-align: center; }
			img
			{
				border: 3px solid red;
				width : 800px;
				height : 600px;
			}

	</style> -->

	
	<! -- 부트스트랩 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/bootstrap.min.css">
	<! -- 커스텀 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/custom.css">
	
<style>

select {
	width: 200px;
	padding: .8em .3em;
	border: 2px solid #999;
	font-family: inherit;
	background: url('select.jpg') no-repeat 95% 50%;
	border-radius: 0px;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

select::-ms-expand {
    display: none;
}

#map {
		width : 80%;
        background-color: white;
      }

	footer{ position:fixed; 
  left:0px; 
  bottom:0px; 
  height:70px; 
  width:100%; 
  background:grey; 
  color: white; }	<!-- footer 고정 -->
  </style>

<script>
	function refresh(){
	document.location.reload();
	}
</script>
</head>
  
<body>

<%
	
	String userID = null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}

	if(userID == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 해주세요.');");

		script.println("location.href = 'userLogin.jsp'");

		script.println("</script>");

		script.close();	

	}

	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);

	if(emailChecked == false) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("location.href = 'emailSendConfirm.jsp'");

		script.println("</script>");

		script.close();		

		return;

	}

%>	

	<nav class = "navbar navbar-expand-lg navbar-light bg-light">
		<a class = "navbar-brand" href="index.jsp">견제팟</a>
		<button class="navor-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class = "navbar-nav mr-auto">
				<li class ="nav-item active">
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
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<!--  <a class="dropdown-item" href="userJoin.jsp">회원가입</a> -->
<%
	} else { 
%>
						<a class="dropdown-item" href="table.jsp">회원관리</a>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
						
<%
	}
%>
					</div>
				</li>

			</ul>
		</div>
	</nav>


	<section>
	
	<form name = "form" action="">		<!--  action에 구글 맵 연동 예정  -->
	<%
	Name = request.getParameter("name");
	int cnt = 0;
	//out.print(Name);
	try
	{
		Class.forName(driverName);
		con = DriverManager.getConnection(url,user,pwd);
		String sql = "SELECT distinct id FROM member order by id";	// 중복된 이름 제거
		ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery(); 
%>
	<table style="margin-left: auto; margin-right: auto;">
	<th>
	<select name = name id="searchType" >
	<!-- <option value=no selected>-이름-</option> -->
	<option value="null">아이디</option>
<%
	while(rs.next())
{
	String selName = rs.getString("id"); 	// 이름 값
	//out.print(selName);
	cnt++;
%>	
	<option value="<%=selName %>" >
	<!--  ${param.option eq "1" ? "selected" :""}> --> <%=selName %></option>
<%
}
%>
	</select></th>
		<th>
			<button type = "submit" class="btn btn-primary mt-3">검색</button>
		</th>
	</table>
<%
	}
	catch(SQLException e)
	{ 
	out.println(e);
}
%>
<%


	String Id = request.getParameter("id");
	String fname = null;
	//out.print(Id);
	try
	{
		String sql = "SELECT name FROM member where id = ? order by name";
		Class.forName(driverName);
		con = DriverManager.getConnection(url,user,pwd);
		ps = con.prepareStatement(sql);
		ps.setString(1, Name);
		ResultSet rs = ps.executeQuery();
%>

	<!-- <select name = id onchange="document.location='index.jsp?name=<%=Name%>'&id=+this.value;">
	<optgroup label="아이디"> -->
<%
	int count = 0;
	while(rs.next())
	{
	fname = rs.getString(1); 
%>
	<option value="<%=fname %>"></option>
	</optgroup>
<%	count++;
		}
	}
	catch(SQLException e)
	{ 
	out.println(e);
}
	//System.out.println("Name값 : "+Name);
	if (fname==null && cnt>=0){	%>
		<script>
		// 이벤트 추가
		</script>
	<%
	}
	else{%>
	<center><h3><%
		out.print(Name+" ("+fname+")님의 정보입니다."); %>
	</h3></center>
	<%
	}
%>
<%
	String Store = request.getParameter("store");
	//out.print(Store);
	//System.out.println(Id);
	String fstore = null;
	try
	{
		String sql = "SELECT distinct store FROM location, member where location.id = ? and la = ? and lo = ? order by store";
		Class.forName(driverName);
		con = DriverManager.getConnection(url,user,pwd);
		ps = con.prepareStatement(sql);
		ps.setString(1, Name);	//
		ps.setString(2, "la");
		ps.setString(3, "lo");
		ResultSet rs = ps.executeQuery(); 
%>

	<!-- <select name = store onChange="getSelectValue(this.form);"> --> 

<%
	while(rs.next())
{	
	fstore = rs.getString("store"); 
%>
	<option value=<%=fstore %> ${param.option eq "0" ? "selected" :""}><%=fstore %></option>
<%
}
%>
	</select>

<%
	}
	catch(SQLException e)
	{ 
	out.println(e);
}
	//if () 
%>
	<div id="map" style="width: 80%; height: 640px; margin : auto;"></div> <!-- 지도가 붙을 위치 -->
<%
	String la = request.getParameter("la");		// 위도
	String lo = request.getParameter("lo");		// 경도
	String store = request.getParameter("store");	//가게명
	String time = request.getParameter("time");
	//out.print(Store);
	//System.out.println(la);
	
	try
	{
		String sql = "select * from location where id = ? order by time desc";
		Class.forName(driverName);
		con = DriverManager.getConnection(url,user,pwd);
		ps = con.prepareStatement(sql);
		ps.setString(1, Name);	//
		ResultSet rs = ps.executeQuery();
%>

	<!-- <select name = store onChange="getSelectValue(this.form);"> --> 
<script>
	var mapLocation = null;
	var markLocation = null;
	var locations = [];		// 마커 위치 배열
</script>
<%
	while(rs.next())
{
	la = rs.getString("la"); 
	lo = rs.getString("lo");
	store = rs.getString("store");
	time = rs.getString("time");
	//System.out.printf("%s %s %s\n",la,lo,store);
	%>
	
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBLb937IYRKJavXiRcXYBKpR7__f9hbr9g&callback=initMap"></script>
	<script>
		// 마커 위치
    locations.push(["<%=store%><br><%=time %>", <%=la%>, <%=lo%>,"<%=store%>"]);		// 마커배열에 추가
		
    <%System.out.print(la +" " +lo+" "+store+" "+time+"\n");%>
    
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 14,
      center: new google.maps.LatLng(<%=la%>, <%=lo%>),	// 초기 지도 위치
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    var infowindow = new google.maps.InfoWindow();

    var marker, i;
    for (i = 0; i < locations.length; i++) {  
      marker = new google.maps.Marker({
        id:i,
        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        map: map,
        title: locations[i][3]
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][0]);
          infowindow.open(map, marker);
        }
      })(marker, i));
      if(marker)
      {
        marker.addListener('click', function() {
          map.setZoom(18);
          map.setCenter(this.getPosition());
        });
        }
    }
    

  </script>
<%
}
	}
	catch(SQLException e)
	{ 
	out.println(e);
}
%>
	<%--<input type = "text" name = text/> --%>
	</form>

<%
	//out.print(Name+" "+fname);
%>
		</section>
		
		<section>

	        <!-- GoogleMap API 연동(황영롱) -->
    <h3> </h3>
        </section>
        <!--  <iframe src="memberList.jsp" style="width:90%" height="500" scrolling="auto">
    </iframe>	iframe 사용-->
        
<!-- 	<article>
	<section class = "container" style="max-width:360px;">
		<form method = "get" action="./index.jsp" class="form-inline mt-3">
			<input type="text" name="url" class="form-control mx-3 mt-10" placeholder="Enter a URL">
			<input type="file" name="file" class="btn btn-primary mx-1 mt-2" accept=".jpg,.jpeg,.png">
		</form>

	</section> -->
<!-- 	<section>
		
		  <p id="status"></p>
  <div id="holder"></div>

<script>
var upload = document.getElementsByTagName('input')[0],
    holder = document.getElementById('holder'),
    state = document.getElementById('status');

if (typeof window.FileReader === 'undefined') {
  state.className = 'fail';
} else {
  state.className = 'success';
  state.innerHTML = '';
}
 
upload.onchange = function (e) {
  e.preventDefault();

  var file = upload.files[0],
      reader = new FileReader();
  reader.onload = function (event) {
    var img = new Image();
    img.src = event.target.result;
    // note: no onload required since we've got the dataurl...I think! :)
    if (img.width > 560) { // holder width
      img.width = 560;
    }
    holder.innerHTML = '';
    holder.appendChild(img);
  };
  reader.readAsDataURL(file);

  return false;
};
</script>
		
	</section>
	</article> -->

	 <footer class = "bg-dark mt -4 p -5 text-center" style = "color : #FFFFFF;">
			Copyright &copy; 2020 남현우 All Rights Reserved.
		</footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
  	<script src="./js/jquery.min.js"></script>
  	<!-- 파퍼 자바스크립트 추가하기 -->
  	<script src="./js/popper.min.js"></script>
  	<!-- 부트스트랩 자바스크립트 추가하기 -->
  	<script src="./js/bootstrap.min.js"></script>
</body>
</html>

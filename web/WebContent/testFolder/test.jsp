<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>

<%@ page import="user.UserDAO"%>
<%@ page import="member.memberDAO" %>
<%@ page import = "java.sql.*" %>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>

<%!String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/DB?useUnicode=true&characterEncoding=euc-kr";%>
<%!String user = "root";%>
<%!String pwd = "0000";%>
<%!String Name = ""; %>

<%
Connection con = null;
PreparedStatement ps = null;
%>

<!DOCTYPE html>
<html> 
<head> 
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
  <title>Google Maps Multiple Markers</title> 
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBLb937IYRKJavXiRcXYBKpR7__f9hbr9g&callback=initMap" 
          type="text/javascript"></script>
</head> 
<body>
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
	<select name = name id="searchType" >
	<!-- <option value=no selected>-이름-</option> -->
	<option value="">아이디</option>
<%
	while(rs.next())
{
	String selName = rs.getString("id"); 	// 이름 값
	//out.print(selName);
	cnt++;
%>	
	<option value="<%=selName %>" 
	${param.option eq "1" ? "selected" :""}><%=selName %></option>
<%
}
%>
	</select>
	<input type = submit value = "검색"/>
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
%>
  <div id="map" style="width: 100%; height: 800px;"></div>
  
<%
	String la = request.getParameter("la");		// 위도
	String lo = request.getParameter("lo");		// 경도
	String store = request.getParameter("store");	//가게명
	String time = request.getParameter("time");
	//out.print(Store);
	System.out.println(la);
	
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
	//System.out.println(rs.next());
	%>

  <script type="text/javascript">
		// 마커 위치
    locations.push(["<%=store%><br><%=time %>", <%=la%>, <%=lo%>]);		// 마커배열에 추가
		
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
        title:'<%=fname %>'
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

	//if () 
%>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>

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
  
	<style type = "text/css">
		table, td{
			margin : auto;
			height : 50px;
			text-align : center;
		}
		
	</style>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 너비에 맞게 설정 -->
	<title>회원리스트</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/custom.css">
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
						<a class="dropdown-item" href="index.jsp">메인</a>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
						
<%
	}

%>
					</div>
				</li>

			</ul>
		</div>
	</nav>
	<section><h2> </h2></section>

<section><center><h2>회원 목록</h2></center></section>

<table class="table table-hover" border="1" style="padding-top: 100px;">
<thead class="thead-dark">
    <tr>
        <th>ID</th>
        <th>이름</th>
        <th>비밀번호</th>
        <th>주소</th>
        <th>나이</th>
        <th>성별</th>
        <th>최근 사용 시간</th>
        <th>장소</th>
    </tr>
    </thead>
 
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        //JDBC 프로그램 순서
        //01단계 :드라이버 로딩 시작
        Class.forName("com.mysql.jdbc.Driver");
        //01단계 :드라이버 로딩 끝
        try {
            //02단계 :DB연결(Connection)시작
            String jdbcDriver = "jdbc:mysql://localhost:8509/DB?useUnicode=true&characterEncoding=euckr";
            String dbUser = "root";
            String dbPass = "rus7wp850!@vkt";
            // DB연결후 리턴값을 받는다.
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
            //02단계 :DB연결(Connection)끝
            //System.out.println(conn + "<-- conn m_list.jsp");
            // DB 연결이 성공 되었는지 안되었는지 판단하라
            if (conn != null) {
                System.out.println("DB연결 성공");
            } else {
                System.out.println("DB연결 실패");
            }
            //03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 시작
            pstmt = conn.prepareStatement("SELECT member.id,name,pwd,address,age,sex,time,store FROM member LEFT OUTER JOIN"+ 
            							"(SELECT id,time,store FROM (SELECT * FROM location WHERE(id,time)" + 
            							"IN (SELECT id, MAX(time) AS time FROM location GROUP BY id) ORDER BY time DESC) t GROUP BY t.id) t2 ON member.id = t2.id");
            //04단계 :Query실행 시작
            rs = pstmt.executeQuery();
            //04단계 :Query실행 끝
            //05단계 :Query실행결과 사용
            // 한번 호출되면 밑으로 내려간다. 전체 리스트를 보여줄때는 주석처리 해야 전체 리스트가 나온다.
            //             System.out.println(rs.next() + "<-- rs.next() m_list.jsp");
            //---   select문장 통해서 모든 회원 목록 가져와서 한줄씩 (레코드(record) or 로우(row))보여준다 시작 
            while (rs.next()) {
    %>
 
    <tr>
        <td><%=rs.getString("id")%></td>
        <td><%=rs.getString("name")%></td>
        <td><%=rs.getString("pwd")%></td>
        <td><%=rs.getString("address")%></td>
        <td><%=rs.getString("age")%></td>
        <td><%=rs.getString("sex")%></td>
        <td>
        	<%if(rs.getString("time")!=null) {%>
        	<%=rs.getString("time")%>
        	<%}
             else{%>
        		x<%} %>
        	</td>
        <td>
        	<%if(rs.getString("store")!=null) {%>
        	<%=rs.getString("store")%>
        	<%}
             else{%>
        		-<%} %></td>
        <%-- request.getContextPath() ==> 프로젝트명을 잡아주는 메서드 절대경로로 잡아주기 위해 다음과 같이 사용하였다. 
        m_update_form.jsp로 이동할때 send_id를 만들어서 아이디 값을 담아서 get방식으로 이동한다. --%>
 
    </tr>
 
    <%
        /* out.println(rs.getString("m_id") + "<-- m_id 필드=컬럼 값 in tb_member테이블 <br>");
            out.println(rs.getString("m_pw") + "<-- m_pw 필드=컬럼 값 in tb_member테이블 <br>");
            out.println(rs.getString("m_level") + "<-- m_level 필드=컬럼 값 in tb_member테이블 <br>");
            out.println(rs.getString("m_name") + "<-- m_name 필드=컬럼 값 in tb_member테이블 <br>");
            out.println(rs.getString("m_email") + "<-- m_email 필드=컬럼 값 in tb_member테이블 <br><br>"); */
            }
            //---   select문장 통해서 모든 회원 목록 가져와서 한줄씩 (레코드(record) or 로우(row))보여준다 끝
 
        } catch (SQLException ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        } finally {
            // 6. 사용한 Statement 종료
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException ex) {
                }
            if (pstmt != null)
                try {
                    pstmt.close();
                } catch (SQLException ex) {
                }
 
            // 7. 커넥션 종료
            if (conn != null)
                try {
                    conn.close();
                } catch (SQLException ex) {
                }
        }
    %>
 
</table>


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

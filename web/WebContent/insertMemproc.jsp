<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	
	String url = "jdbc:mysql://localhost:3306/DB";
	String user = "root";
	String pass = "0000";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = "insert into test(id,pwd,name) values(?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		pstmt.setString(3, name);
		pstmt.executeUpdate();
		
		out.println("회원가입 완료");
		
		conn.prepareStatement(sql);
		
	}catch(Exception e){
		out.println("Exception : "+e);
	}
	
%>
ID : <%=id%>;<br>
비번 : <%=pwd%>;<br>
이름 : <%=name%>;<br>
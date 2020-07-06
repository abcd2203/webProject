<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>depthmove</title>


<script type="text/javascript">
 
 //var groupnum = form1.groupnum.value; 
 function goSearch(val){
  var form = document.form1;
  form.groupnum.value = val;
  form.method = "get";
  form.action = "error2.jsp";
  form.submit(null);  
 } 
</script>
 <%
  String num = request.getParameter("groupnum");
 %>  
</head>
<body>

<form name="form1">

<%
   // 1. 드라이버 로딩
   
   Class.forName("com.mysql.jdbc.Driver");

   Connection con = null;
   Statement stmt = null;
   ResultSet rs = null;

   try {
    // 2. 커넥션 얻기
    String driver = "jdbc:mysql://localhost:3307/DB?useUnicode=true&characterEncoding=euc-kr";
    String id = "root";
    String pw = "0000";    
    String query = "select distinct name from member order by name";

    con = DriverManager.getConnection(driver, id, pw);
    stmt = con.createStatement();
    rs = stmt.executeQuery(query);

     
    // 마지막 데이터까지 반복함.
    out.print("<td><select name ='groupnum' id='groupnum' onchange='goSearch(form1.groupnum.value)' >");

    while (rs.next()) {
     out.println("<option value=" + rs.getString(1) + ">"
       + rs.getString(1) + "</option>");   
    }
    out.print("</select></td>");
   } catch (Exception e) {
    e.getStackTrace();
   } finally {
    //out.print("finally 끝~~");
    if (rs != null) try {rs.close();} catch (Exception ex) {}
    if (stmt != null)try {stmt.close();} catch (Exception ex) {}
    if (con != null)try {con.close();} catch (Exception ex) {}
   }
%>
<%
//1. 드라이버 로딩
Class.forName("com.mysql.jdbc.Driver");

try {
 // 2. 커넥션 얻기
 String driver = "jdbc:mysql://localhost:3307/DB?useUnicode=true&characterEncoding=euc-kr";
 String id = "root";
 String pw = "0000";     
 String query = "select store from member where id= ? order by store";
 
 con = DriverManager.getConnection(driver, id, pw);
 stmt = con.createStatement();
 rs = stmt.executeQuery(query);

 int i = 1;

 // 마지막 데이터까지 반복함.
 out.print("<td><select name ='toBox' id='toBox'>");
 out.println("<option value= '선택'> /");
 while (rs.next()) {
	 
  out.println("<option value=" + rs.getString(1) + ">"
		  + rs.getString(1) +"</option>");
  i++;
 }
 out.print("</select></td>");
} catch (Exception e) {
 e.getStackTrace();
 
} finally {
 //out.print("finally 끝~~");
 if (rs != null) try {rs.close();} catch (Exception ex) {}
 if (stmt != null)try {stmt.close();} catch (Exception ex) {}
 if (con != null)try {con.close();} catch (Exception ex) {}
}   
%>

</form>
</body>
</html>
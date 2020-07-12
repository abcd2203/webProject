<%@ page contentType="text/html;charset=euc-kr" %>
<html> <head>  <title>다중 셀렉트문 예제</title>
<%@ page import="java.util.*, java.text.*"  %>

<%

 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 String today = formatter.format(new java.util.Date());

 out.println(today);

%>
 </head> <body>
</body>
</html>
<%@ page contentType = "text/html; charset=utf-8" import= "java.util.*, java.text.*" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>Test Page</title>



</head>
<body>
<form action = "">
<select name="option" id="searchType">
<option value=""  selected>검색방법 선택</option>
<option value="0" ${param.option eq "0" ? "selected" :""}> 도로명</option>
<option value="1" ${param.option eq "1" ? "selected" :""}>리&동명</option>
<option value="2" ${param.option eq "2" ? "selected" :""}>하이</option>
</select>

<input type = "submit" value = "검색"></input>
</form>
</body>
</html>
<%@ page contentType="text/html;charset=euc-kr" %>
<html> <head>  <title>다중 셀렉트문 예제</title>
<script>
 <!--
 function createCookie(name, value, expires){
	 var today = new Date();
	 today.setTime (today.getTime() + expires);
	 document.cookie = name + "=" + escape(value) + "; expires=" + today.toGMTString() + "; path=/"
	}
 
 function readCookie(name){
	 var cook = document.cookie;
	 var search = name + "=";
	 
	 if(cook.length>0){
		 var offset = document.cookie.indexOf(search);
		 
		 if(offset != -1){
			 offset += search.length;
			 end = cook.indexOf(";",offset)
			 if (end == -1){
				 end = cook.length;
			 }
			 alert(cook.substring(offset,end));
			 return cook.substring(offset,end);
			 } else{
				 return "";
			 }
		 } else{
			 return "";
		 }
	 }
 function getCookie(){
	 document.frm.tx.value = unescape(readCookie("note"));
	 
 }
 -->
 </script>
 </head> <body>
 <form name = "frm">
 <textarea name = "tx" WRAP = "VIRTUAL">
 </textarea>
 <br>
 <select>
 <option value= "1" >안녕</option>
  <option value= "2">하세요</option>
 </select>
 <input type = "button" value="값 유지" onclick = "createCookie('note',document.frm.tx.value,36000); alert('하이')">
  <input type = "button" value="리로드" onclick = "parent.location='javascript:location.reload()'">
 </form></body>
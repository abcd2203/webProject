<%@ page contentType="text/html;charset=euc-kr" pageEncoding="UTF-8" %>

<!DOCTYPE html> <html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name = "viewport" content="width=device-width, initial-scale=1">
	<link rel = "stylesheet" href="../css/bootstrap.css">
	<title>JSP AJAX</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script type = "text/javascript">
		var searchrequest = new XMLHttpRequest();
		var registerRequest = new XMLHttpRequest();
		function searchFunction() {
			searchrequest.open("Post","../MemberSearchServlet?memberName=" + encodeURIComponent(document.getElementById("memberName").value), true);
			searchrequest.onreadystatechange = searchProcess;
			searchrequest.send(null);
		} 
		function searchProcess(){
			var table = document.getElementById("ajaxTable");
			table.innerHTML = "";
			if(searchrequest.readyState == 4 && searchrequest.status == 200) {
				var object = eval('(' + searchrequest.responseText + ')');
				var result = object.result;
				for(var i =0; i < result.length; i++){
					var row = table.insertRow(0);
					for (var j = 0; j < result[i].length; j++) {
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;
					}
				}
			}
		} 
		function registerFunction() {
			registerRequest.open("Post","../MemberRegisterServlet?memberName=" + encodeURIComponent(document.getElementById("registerName").value)+
										"&memberId=" + encodeURIComponent(document.getElementById("registerId").value) +
										"&memberPwd=" + encodeURIComponent(document.getElementById("registerPwd").value) +
										"&memberAddress=" + encodeURIComponent(document.getElementById("registerAddress").value) +
										"&memberAge=" + encodeURIComponent(document.getElementById("registerAge").value) +
										"&memberSex=" + encodeURIComponent($('input[name=registerSex]:checked').val()), true);
			registerRequest.onreadystatechange = registerProcess;
			registerRequest.send(null);
			
		}
		function registerProcess() {
			if (registerRequest.readyState == 4 && registerRequest.status == 200) {
				var result = registerRequest.responseText;
				if (result != 1) {
					alert('등록에 실패했습니다.');
				}
				else {
					var memberName = document.getElementById("memberName");
					var memberId = document.getElementById("memberId");
					var memberPwd = document.getElementById("memberPwd");
					var memberAddress = document.getElementById("memberAddress");
					var memberAge = document.getElementById("memberAge");
					//var memberSex = document.getElementById("memberSex");
					memberName.value = "";
					registerName.value = "";
					registerId.value = "";
					registerPwd.value = "";
					registerAddress.value = "";
					registerAge.value = "";
					searchFunction();
				}
			}
		}
		window.onload = function() {
			parent.searchFunction();
		}
	</script>

 </head>
 <body>
 	<br>
 	<center><h4>회원목록</h4></center>
 	<div class = "container">
 		<div class = "form-group row float-right">
 			<div class="col-xs-8">
 				<input class = "form-control" id="memberName" onkeyup="parent.searchFunction()" type="text" size="15">
 			</div>
 			<div class = "col -xs -2">
 				<button class ="btn btn-primary" onclick="parent.searchFunction();" type = "button">검색</button>
 			</div>
 		</div>
 		
 		<table class = "table" style = "text-align: center; border: 1px solid #dddddd">
 			<thead>
 				<tr>
 					<th style = "background-color : #fafafa; text-align: center;">ID</th>
 					<th style = "background-color : #fafafa; text-align: center;">이름</th>
 					<th style = "background-color : #fafafa; text-align: center;">비밀번호</th>
 					<th style = "background-color : #fafafa; text-align: center;">주소</th>
 					<th style = "background-color : #fafafa; text-align: center;">나이</th>
 					<th style = "background-color : #fafafa; text-align: center;">성별</th>
 				</tr>
 			</thead>
 			<tbody id="ajaxTable">
 			</tbody>
 		
 		</table>

 	</div>

</body>
</html>
<%@ page contentType="text/html;charset=euc-kr" pageEncoding="UTF-8" %>

<!DOCTYPE html> <html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name = "viewport" content="width=device-width, initial-scale=1">
	<link rel = "stylesheet" href="./css/bootstrap.css">
	<title>JSP AJAX</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<script type = "text/javascript">
		var searchrequest = new XMLHttpRequest();
		var registerRequest = new XMLHttpRequest();
		function searchFunction() {
			searchrequest.open("Post","./MemberSearchServlet?memberName=" + encodeURIComponent(document.getElementById("memberName").value), true);
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
			registerRequest.open("Post","./MemberRegisterServlet?memberName=" + encodeURIComponent(document.getElementById("registerName").value)+
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
					registerPwd.value = "";
					registerAddress.value = "";
					registerAge.value = "";
					searchFunction();
				}
			}
		}
		window.onload = function() {
			searchFunction();
		}
	</script>

 </head>
 <body>
 	<br>
 	<div class = "container">
 		<div class = "form-group row float-right">
 			<div class="col-xs-8">
 				<input class = "form-control" id="memberName" onkeyup="searchFunction()" type="text" size="15">
 			</div>
 			<div class = "col -xs -2">
 				<button class ="btn btn-primary" onclick="searchFunction();" type = "button">검색</button>
 			</div>
 		</div>
 		<table class = "table" style = "text-align: center; border: 1px solid #dddddd">
 			<thead>
 				<tr>
 					<th style = "background-color : #fafafa; text-align: center;">이름</th>
 					<th style = "background-color : #fafafa; text-align: center;">ID</th>
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
 	<div class = "container">
 		<table class = "table" style = "text-align: center; border : 1px solid #dddddd">
 			<thead>
 				<tr>
 					<th colspan="2" style="background-color: #fafafa; text-align : center;">회원 등록 양식</th>
 				</tr>
 			</thead>
 			<tbody>
 				<tr>
 					<td style = "background-color : #fafafa; text-align:center;"><h5>이름</h5></td>
 					<td><input class = "form-control" type="text" id = "registerName" size="20"></td>
 				</tr>
 				<tr>
 					<td style = "background-color : #fafafa; text-align:center;"><h5>ID</h5></td>
 					<td><input class = "form-control" type="text" id = "registerId" size="20"></td>
 				</tr>
 				<tr>
 					<td style = "background-color : #fafafa; text-align:center;"><h5>비밀번호</h5></td>
 					<td><input class = "form-control" type="text" id = "registerPwd" size="20"></td>
 				</tr>
 				<tr>
 					<td style = "background-color : #fafafa; text-align:center;"><h5>주소</h5></td>
 					<td><input class = "form-control" type="text" id = "registerAddress" size="30"></td>
 				</tr>
 				<tr>
 					<td style = "background-color : #fafafa; text-align:center;"><h5>나이</h5></td>
 					<td><input class = "form-control" type="number" id = "registerAge" size="20"></td>
 				</tr>
 				<tr>
 					<td style = "background-color : #fafafa; text-align : center;"><h5>성별</h5></td>
 					<td>
 						<div class = "form-group" style = "text-align: center; margin: 0 auto;">
 							<div class = "btn-group" data-toggle="buttons">
 								<label class = "btn btn-primary active">
 									<input type = "radio" name = "registerSex" autocomplete="off" value="남성" checked>남성
 								</label>
 								<label class = "btn btn-primary">
 									<input type = "radio" name = "registerSex" autocomplete="off" value="여성">여성
 								</label>
 							</div>
 						</div>
 					</td>
 				</tr>
 				<tr>
 					<td colspan = "2"><button class = "btn btn-primary float-right" onclick="registerFunction();" type = "button">등록</button>
 					</td>
 				</tr>
 			</tbody>
 		</table>
 	</div>
</body>
</html>
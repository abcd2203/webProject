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
		var request = new XMLHttpRequest();
		function searchFunction() {
			request.open("Post","./MemberSearchServlet?memberName=" + encodeURIComponent(document.getElementById("memberName").value), true);
			request.onreadystatechange = searchProcess;
			request.send(null);
		}
		function searchProcess(){
			var table = document.getElementById("ajaxTable");
			table.innerHTML = "";
			if(request.readyState==4 && request.status == 200) {
				var object = eval('(' + request.responseText + ')');
				var result = object.result;
				for(var i =0; i<result.length; i++){
					var row = table.insertRow(0);
					for (var j=0;j < result[i].length; j++) {
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;
					}
				}
			}
		}
	</script>

 </head>
 <body>
 	<br>
 	<div class = "container">
 		<div class = "form-group row float-right">
 			<div class="col-xs-8">
 				<input class = "form-control" id="userName" onkeyup="searchFunction()" type="text" size="15">
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
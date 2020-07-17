<%@ page contentType="text/html;charset=euc-kr" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html> <html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name = "viewport" content="width=device-width, initial-scale=1">
	<link rel = "stylesheet" href="./css/bootstrap.css">
		<title>회원리스트</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<!-- <link rel = "stylesheet" href="./css/bootstrap.min.css"> -->
	<!-- 커스텀 CSS 추가하기 -->
	<link rel = "stylesheet" href="./css/custom.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<script>
	$(function(){
	    // tr 태그에 마우스를 올릴때
	    $('table tbody tr').mouseover(function() {
	        $(this).children().css({
	            'backgroundColor' : '#DCDCDC',
	            'cursor' : 'pointer'
	        });
	    }).mouseout(function() {
	        $(this).children().css({
	            'backgroundColor' : '#FFFFFF',
	            'cursor' : 'default'
	        });
	    });

	    // 전체 선택, 전체 해제
	    $("#checkall").change(function() {
	        $("input:checkbox").prop('checked', $(this).prop("checked"));
	    });

	    $('#select_chkbox').click(function(i) {
	        var rowData = new Array();
	        var chkData = new Array();
	        var tmp = new Array();
	        var checkbox = $('input:checkbox[name="uid[]"]:checked');
	        checkbox.each(function(i){ // 반복되는 태그 단위를 찾아서 each() 함수 사용
	           var select_value = $(this).val();
	           chkData.push(select_value);

	           // checkbox.parent() : checkbox의 부모는 <td>
	           // checkbox.parent().parent() : <td>의 부모이므로 <tr>
	           var tr = checkbox.parent().parent().eq(i);
	           var td = tr.children();
	           rowData.push(tr.text()+"<br />");
	           alert(rowData);
	           
	        });
	        if (rowData.length == 0) {
	           $("#chk_result").html("선택한 항목이 없습니다").css("color", "blue");

	           $("#rawData_result").html("");

	        } else {
	           $("#chk_result").html("선택된 체크박스 값 : "+chkData).css("color", "blue");
	           //$("#rawData_result").html("체크된 Row의 모든 데이터 : <br /> "+rowData);
	           $("#rawData_result").html("id : <br /> "+rowData.split("<br />"));
	        }
	    });

	    var sum = 0;
	    $('table tbody tr').each(function(){ //테이블 모든 tr에 순차 접근
	       if($.isNumeric($("td:eq(4)",this).text())){ //해당 tr의 다섯번째 td에 접근해서 숫자인지 확인
	           sum += parseInt($("td:eq(4)",this).text());//해당하는 값을 숫자로 변환해서 누적합산 처리
	       }
	    });
	    $("#sum").text("수량 합계 : "+sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));// sum을 출력
	    
	    $("table tbody tr").click(function () {
	        // 현재 클릭된 Row(<tr>)
	        var checkbox = $(this).find('td:first-child :checkbox');
	        checkbox.attr('checked', !checkbox.is(':checked'));
	    });

		
	});


	$(document).ready(function(){

	    $(document).bind("contextmenu", function(e) {

	      alert("우클릭 금지");

	      return false;
	    });

	});
	</script>
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
					registerId.value = "";
					registerPwd.value = "";
					registerAddress.value = "";
					registerAge.value = "";
					alert('등록하였습니다.');
					searchFunction();
				}
			}
		}
		window.onload = function() {
			searchFunction();
		}
	</script>
	<style>
	footer{ position:fixed; 
  left:0px; 
  bottom:0px; 
  height:20px; 
  width:100%; 
  background:grey; 
  color: white; }	<!-- footer 고정 -->
  
  </style>
  
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-172961140-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-172961140-1');
</script>


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
	
 	<br>
 	<center><h3>회원목록</h3></center>
 	<div class = "container">
 		<div class = "form-group row float-right">
 			<div class="col-xs-8">
 				<input class = "form-control" id="memberName" onkeyup="searchFunction()" type="text" size="15">
 			</div>
 			<div class = "col -xs -2">
 				<button class ="btn btn-primary" onclick="searchFunction();" type = "button">검색</button>
 			</div>
 		</div>
 		
 		<table class = "table" style = "text-align: center; border: 1px solid #dddddd; table-layout: fixed">
 			<thead class="thead-dark">
 				<tr>
 					<!-- <th style = "background-color : #fafafa; text-align: center;"></th> -->
 					<th style = "text-align: center;">이름</th>
 					<th style = "text-align: center;">ID</th>
 					<th style = "text-align: center;">비밀번호</th>
 					<th style = "text-align: center;">주소</th>
 					<th style = "text-align: center;">나이</th>
 					<th style = "text-align: center;">성별</th>
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
 					<th colspan="2" style="background-color: #fafafa; text-align : center;">회원 등록</th>
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
 								<label class = "btn btn-outline-primary btn-toggle active">
 									<input type = "radio" name = "registerSex" autocomplete="off" value="남성" checked>남성
 								</label>
 								<label class = "btn btn-outline-primary btn-toggle">
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
 		 <footer class = "bg-dark mt -4 p -5 text-center" style = "color : #FFFFFF;">
			Copyright &copy; 2020 남현우 All Rights Reserved.
		</footer>
	<!-- 제이쿼리 자바스크립트 추가하기 -->
  	<script src="./js/jquery.min.js"></script>
  	<!-- 파퍼 자바스크립트 추가하기 -->
  	<script src="./js/popper.min.js"></script>
  	<!-- 부트스트랩 자바스크립트 추가하기 -->  
</body>
</html>
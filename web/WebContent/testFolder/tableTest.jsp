<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%!String id = ""; %>

<!DOCTYPE html>
<head>
<meta charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<meta http-equiv="X-UA Compatible" control="IE=edge,chrome=1" />
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
           <%=id%>
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
</head>
<body>
<div class="container">
    <div class="row">
        <table class="table table-hover">
        <thead>
        <tr>
        <th class="header" width="30"><input type="checkbox" id="checkall" /></th>
        <th class="header" width="100">번호</th>
        <th class="header" width="100">ID</th>
        <th class="header" width="100">이름</th>
        <th class="header" width="100">비밀번호</th>
        <th class="header" width="100">주소</th>
        <th class="header" width="100">나이</th>
        <th class="header" width="100">성별</th>
        <th class="header" width="200">최근 사용 시간</th>
        <th class="header" width="100">장소</th>
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
            String jdbcDriver = "jdbc:mysql://namweb.iptime.org:8509/DB?useUnicode=true&characterEncoding=euckr";
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
            int count = 0;
            while (rs.next()) {
            	count++;
    %>
        
        <tbody>

         <tr>
        <td><input type="checkbox" class="chkbox" name="uid[]" value="<%=count %>" /></td>
        <td><%=count %></td>
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
        		-<%} %>
        	</td>
 
    </tr>
        </tbody> 
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
    
        <!-- <td colspan="5" style="text-align:left;">   -->
        </table>
    </div>
    <button type="button" class="btn btn-success btn-sm" id="select_chkbox">선택</button>
    <div id="chk_result"></div>
    <div id="rawData_result"></div>
    <div id="sum"></div>
</div>

</body>
</html> 
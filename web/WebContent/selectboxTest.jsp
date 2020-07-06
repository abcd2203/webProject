<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Arrays" %>
<%!String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:8509/DB?useUnicode=true&characterEncoding=euc-kr";%>
<%!String user = "root";%>
<%!String pwd = "rus7wp850!@vkt";%>
<%!String Name = ""; %>

<%
	Connection con = null;
	PreparedStatement ps = null;
%>

<%
int count = 0;
int count1 = 0;
int count2 = 0;
String selId = "";
String [] ArrayId = new String [100];
String [] ArrayStore = new String [100];

try
	{
		Class.forName(driverName);
		con = DriverManager.getConnection(url,user,pwd);
		String sql = "SELECT id FROM member order by id";	// 중복된 이름 제거
		ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery(); 

	while(rs.next())
{
	selId = rs.getString("id"); 	// 아이디 값
	ArrayId[count] = selId;
	//out.print(selName);
	count++;
	//out.print(count);

}
	System.out.println(Arrays.toString(ArrayId));
	}
	catch(SQLException e)
	{ 
	out.println(e);
}
%>
<select name = id >
<%
	String Id = request.getParameter("id");
	//out.print(Id);
	System.out.println(Id);
	try
	{
		String sql = "SELECT distinct store FROM location"; //, member where location.id = ? order by store";
		Class.forName(driverName);
		con = DriverManager.getConnection(url,user,pwd);
		ps = con.prepareStatement(sql);
		//ps.setString(1, Id);	// 바꿔
		ResultSet rs = ps.executeQuery();
%>

<%
	while(rs.next())
	{
	String fname = rs.getString(1); 
%>
	<option value="<%=fname %>"><%=fname %></option>
<%	count1++;	// 반복문 갯수 증가
	}
%>
	</select><input type = submit value = "검색"/></form>
<%
	}
	catch(SQLException e)
	{ 
	out.println(e);
}
%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <Title>DB 연동</Title> 
        <Meta Http-Equiv="Content-Type" Content="text/html; charset=utf-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
    </head>
 
    아이디: <select name="mainCategory" style="width:200px">
        <option value="">ID </option>
    </select>
    장소: <select name="subCategory" style="width:200px">
        <option value="">장소</option>
    </select>

 <script>

var tmpArr = new Array();

<% for(int i=0;i<100;i++){ %>
tmpArrp[<%=i%>]=<%=ArrayId[i]%>;
<% }
%>

$(function(){
	$("#listButton").click(function(){
		  $.ajax({
		          type: 'post'
		        , url: '/error.jsp'
		        , dataType : 'html'
		        , success: function(data) {
		        	$("#listDiv").html(data);
		          }
		  });	
	})		
})

</script>

<body>
<%=count %>
<form name = "form" action="">
<script type="text/javascript">
var selectValue = null;
var dbId = null; // 설렉트 db 아이디
var store = null;
$(document).ready(function() {
    
    //Main 카테고리를 선택 할때 마다 AJAX를 호출할 수 있지만 DB접속을 매번 해야 하기 때문에 main, sub카테고리 전체을 들고온다.
    
    //****************이부분은 DB로 셋팅하세요.
    //Main 카테고리 셋팅 (DB에서 값을 가져와 셋팅 하세요.)
	var mainCategoryArray = new Array();
    var mainCategoryObject = new Object();
    	
    <% for (int i=0; i< count; i++){ %>
    
    	mainCategoryObject = new Object();
    	mainCategoryObject.main_category_id = <%=i%>;
    	mainCategoryObject.main_category_name = '<%=ArrayId[i]%>'
    	mainCategoryArray.push(mainCategoryObject);
    <%
    }
    %>
    
    //Sub 카테고리 셋팅 (DB에서 값을 가져와 셋팅 하세요.)
    var subCategoryArray = new Array();
    var subCategoryObject = new Object();
    <% for (int j=0; j< count; j++){
    	for (int k=0; k< count1; k++){ %>
    
    //스포츠에 해당하는 sub category 리스트
    subCategoryObject = new Object();
    subCategoryObject.main_category_id = <%=j%>;
    subCategoryObject.sub_category_id = <%=k%>;
    subCategoryObject.sub_category_name = "스포츠";	// 이걸 찾아라
    subCategoryArray.push(subCategoryObject);
    <%		} 
    	} %>
    //****************이부분은 DB로 셋팅하세요.
	
    // 메인 카테고리 셋팅
    var mainCategorySelectBox = $("select[name='mainCategory']");
    
    for(var i=0;i<mainCategoryArray.length;i++){
        mainCategorySelectBox.append("<option value='"+mainCategoryArray[i].main_category_id+"'>"+mainCategoryArray[i].main_category_name+"</option>");
    }
    //*********** 1depth카테고리 선택 후 2depth 생성 START ***********
    $(document).on("change","select[name='mainCategory']",function(){
        //두번째 셀렉트 박스를 삭제 시킨다.
        var subCategorySelectBox = $("select[name='subCategory']");
        subCategorySelectBox.children().remove(); //기존 리스트 삭제
        
        //선택한 첫번째 박스의 값을 가져와 일치하는 값을 두번째 셀렉트 박스에 넣는다.
        $("option:selected", this).each(function(){
        	//alert($(this).text());
        	dbId = String($(this).text()); // main category 에서 선택한 값
        	
            selectValue = $(this).val(); //main category 에서 선택한 번호
            //alert(dbId);
            subCategorySelectBox.append("<option value=''>전체</option>");
            for(var i=0;i<subCategoryArray.length;i++){
                if(selectValue == subCategoryArray[i].main_category_id){
                    
                    subCategorySelectBox.append("<option value='"+subCategoryArray[i].sub_category_id+"'>"+subCategoryArray[i].sub_category_name+"</option>");
                    
                }
               
            }
           
        });
    });
    $(document).on("change","select[name='subCategory']",function(){
    $("option:selected", this).each(function(){
    	store = String($(this).text());		// 가게명
    	//alert(dbId+store)
    	//document.location='index.jsp?name='+dbId+'?store='+store // index페이지로 이동
    	});
    
    //*********** 1depth 카테고리 선택 후 2depth 생성 END ***********
	});
});
</script>
<input type = "button" id = "listButton" value = "검색" onclick = "document.location='index.jsp?name='+dbId"/>
<% String test = request.getParameter("mailid"); %>
</form>

</body>
</html>
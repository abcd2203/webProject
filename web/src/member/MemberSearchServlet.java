package member;
  
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MemberSearchServlet")
public class MemberSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String memberName = request.getParameter("memberName");
		response.getWriter().write(getJSON(memberName));
	}
	
	public String getJSON(String memberName) {
		if(memberName == null || memberName.equals(null)) memberName = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		MemberDAO memberDAO = new MemberDAO();
		ArrayList<Member> memberList = memberDAO.search(memberName);
		
		for (int i = 0; i<memberList.size();i++) {
			result.append("[{\"value\": \"" + memberList.get(i).getMemberName() + "\"},");
			result.append("{\"value\": \"" + memberList.get(i).getMemberId() + "\"},");
			result.append("{\"value\": \"" + memberList.get(i).getMemberPwd() + "\"},");
			result.append("{\"value\": \"" + memberList.get(i).getMemberAddress() + "\"},");
			result.append("{\"value\": \"" + memberList.get(i).getMemberAge() + "\"},");
			result.append("{\"value\": \"" + memberList.get(i).getMemberSex() + "\"}],");
		}
		result.append("]}");
		return result.toString();
	}
	
}

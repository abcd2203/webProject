package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
/**
 * Servlet implementation class MemberRegisterServlet
 */
@WebServlet("/MemberRegisterServlet")
public class MemberRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String memberName = request.getParameter("memberName");
		String memberId = request.getParameter("memberId");
		String memberPwd = request.getParameter("memberPwd");
		String memberAddress = request.getParameter("memberAddress");
		String memberAge = request.getParameter("memberAge");
		String memberSex = request.getParameter("memberSex");
		response.getWriter().write(register(memberName, memberId, memberPwd, memberAddress, memberAge, memberSex) + "");
	}
	
	public int register(String memberName, String memberId, String memberPwd, String memberAddress, String memberAge, String memberSex) {
		Member member = new Member();
		try {
			member.setMemberName(memberName);
			member.setMemberId(memberId);
			member.setMemberPwd(memberPwd);
			member.setMemberAddress(memberAddress);
			member.setMemberAge(Integer.parseInt(memberAge));
			member.setMemberSex(memberSex);
			
		} catch (Exception e) {
			return 0;
		}
		return new MemberDAO().register(member);
	}
}

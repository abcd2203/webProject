package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/calc2")	// ������̼� Ȱ��

public class calc2 extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// �Էµ���
			, HttpServletResponse response	// ���䵵��
			) throws ServletException, IOException {
		//ServletContext application = request.getServletContext();	// ���ø����̼� ��ü
		HttpSession session = request.getSession();	// ���� ��ü (���� : ���� ����)
//		Cookie [] cookies = request.getCookies();
		response.setCharacterEncoding("UTF-8");	// ���ڵ��� UTF-8�� ����
		response.setContentType("text/html; charset=UTF-8");	//�̰ɷ� �о��
		//request.setCharacterEncoding("UTF-8");	// UTF-8�� �Է�
		
		String v_ = request.getParameter("v");
		String op = request.getParameter("operator");
		
		PrintWriter out = response.getWriter();
		
		int v = 0;
		
		// ���
		if (!v_.equals(""))
			v = Integer.parseInt(v_);
		
		if (op.equals("=")) {
			
			//int x = (Integer) application.getAttribute("value");
			int x = (Integer) session.getAttribute("value");
			
//			int x = 0;
//			for (Cookie c : cookies) {
//				if (c.getName().equals("value"))
//					x = Integer.parseInt(c.getValue());
//					break;
//			}
			int y = v;
			//String operator = (String) application.getAttribute("op");
			String operator = (String) session.getAttribute("op");
			
//			String operator ="";
//			for (Cookie c : cookies) {
//				if (c.getName().equals("value"))
//					operator =c.getValue();
//					break;
//			}
			
			int result = 0;
			if (operator.equals("+"))
				result = x+y;
			else
				result = x-y;
			out.printf("result is %d\n", result);
		}
		// ���� ����
		else {
			//application.setAttribute("value", v);
			//application.setAttribute("op", op);
			
			session.setAttribute("value", v);
			session.setAttribute("op", op);
			
//			Cookie valueCookie = new Cookie("value", String.valueOf(v));
//			Cookie opCookie = new Cookie("op",op);
//			valueCookie.setPath("/Calc2");	// ��Ű ���
//			valueCookie.setMaxAge(60*60); 	// ��Ű ���� ��¥
//			opCookie.setPath("/Calc2");		// ��Ű ���
//			response.addCookie(valueCookie);
//			response.addCookie(opCookie);
			
			response.sendRedirect("calc2.html"); 	// ������ ��ȯ
		}
		
		
		
		
		
	}
}

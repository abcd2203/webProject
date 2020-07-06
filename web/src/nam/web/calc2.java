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

@WebServlet("/calc2")	// 어노테이션 활용

public class calc2 extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// 입력도구
			, HttpServletResponse response	// 응답도구
			) throws ServletException, IOException {
		//ServletContext application = request.getServletContext();	// 어플리케이션 객체
		HttpSession session = request.getSession();	// 세션 객체 (세션 : 현재 접속)
//		Cookie [] cookies = request.getCookies();
		response.setCharacterEncoding("UTF-8");	// 인코딩을 UTF-8로 보냄
		response.setContentType("text/html; charset=UTF-8");	//이걸로 읽어라
		//request.setCharacterEncoding("UTF-8");	// UTF-8로 입력
		
		String v_ = request.getParameter("v");
		String op = request.getParameter("operator");
		
		PrintWriter out = response.getWriter();
		
		int v = 0;
		
		// 계산
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
		// 값을 저장
		else {
			//application.setAttribute("value", v);
			//application.setAttribute("op", op);
			
			session.setAttribute("value", v);
			session.setAttribute("op", op);
			
//			Cookie valueCookie = new Cookie("value", String.valueOf(v));
//			Cookie opCookie = new Cookie("op",op);
//			valueCookie.setPath("/Calc2");	// 쿠키 경로
//			valueCookie.setMaxAge(60*60); 	// 쿠키 만료 날짜
//			opCookie.setPath("/Calc2");		// 쿠키 경로
//			response.addCookie(valueCookie);
//			response.addCookie(opCookie);
			
			response.sendRedirect("calc2.html"); 	// 페이지 전환
		}
		
		
		
		
		
	}
}

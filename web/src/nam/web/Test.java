package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hi")	// 어노테이션 활용

public class Test extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req	// 입력도구
			, HttpServletResponse resp	// 응답도구
			) throws ServletException, IOException {
		
		resp.setCharacterEncoding("UTF-8");	// 인코딩을 UTF-8로 보냄
		resp.setContentType("text/html; charset=UTF-8");	//이걸로 읽어라
		
		PrintWriter out = resp.getWriter();
		
		String temp = req.getParameter("cnt");
		
		int cnt = 10;
		if(temp!=null && !temp.equals(""))
			cnt = Integer.parseInt(temp);
			
		for (int i = 1; i<=cnt; i++) {
			out.println((i)+ " : 안녕 서블릿!!! <br/>");
			System.out.println(i);
		}
	}
}

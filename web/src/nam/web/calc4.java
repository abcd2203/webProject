package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/calc4")	// 어노테이션 활용

public class calc4 extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// 입력도구
			, HttpServletResponse response	// 응답도구
			) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");	// 인코딩을 UTF-8로 보냄
		response.setContentType("text/html; charset=UTF-8");	//이걸로 읽어라
		//request.setCharacterEncoding("UTF-8");	// UTF-8로 입력
		
		String x_ = request.getParameter("x");
//		String y_ = request.getParameter("y");
		String op = request.getParameter("op");
		
		PrintWriter out = response.getWriter();
		String result = "";
//		int x = Integer.parseInt(x_);
//		int y = Integer.parseInt(y_);
		
		if(x_.equals("박주호"))
			result = x_;
		else
			result = "넌 누구냐";
		out.println(result);
	}
}

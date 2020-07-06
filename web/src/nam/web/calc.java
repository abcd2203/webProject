package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/calc")	// 어노테이션 활용

public class calc extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// 입력도구
			, HttpServletResponse response	// 응답도구
			) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");	// 인코딩을 UTF-8로 보냄
		response.setContentType("text/html; charset=UTF-8");	//이걸로 읽어라
		//request.setCharacterEncoding("UTF-8");	// UTF-8로 입력
		
		String num_ [] = request.getParameterValues("x");
		String op = request.getParameter("op");
		
		PrintWriter out = response.getWriter();
		int result = 0;
		int x = Integer.parseInt(request.getParameter("x"));
		int y = Integer.parseInt(request.getParameter("y"));
		
		if (op.equals("덧셈"))
			for (int i =0;i<num_.length;i++) {
				int num = Integer.parseInt(num_[i]);
				result += num;
			}
		if (op.equals("뺄셈"))
			result = x-y;
		out.println(result);
	}
}

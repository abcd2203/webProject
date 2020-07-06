package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/notice-reg")	// 어노테이션 활용

public class Notice extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// 입력도구
			, HttpServletResponse response	// 응답도구
			) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");	// 인코딩을 UTF-8로 보냄
		response.setContentType("text/html; charset=UTF-8");	//이걸로 읽어라
		//request.setCharacterEncoding("UTF-8");	// UTF-8로 입력
		
		
		PrintWriter out = response.getWriter();
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		if (!title.equals("") && title!=null) {
			out.println(title);
		}
		if (!content.equals("") && content!=null)
			out.println(content);
	}
}

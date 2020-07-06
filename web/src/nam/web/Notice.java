package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/notice-reg")	// ������̼� Ȱ��

public class Notice extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// �Էµ���
			, HttpServletResponse response	// ���䵵��
			) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");	// ���ڵ��� UTF-8�� ����
		response.setContentType("text/html; charset=UTF-8");	//�̰ɷ� �о��
		//request.setCharacterEncoding("UTF-8");	// UTF-8�� �Է�
		
		
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

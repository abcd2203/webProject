package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/calc")	// ������̼� Ȱ��

public class calc extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// �Էµ���
			, HttpServletResponse response	// ���䵵��
			) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");	// ���ڵ��� UTF-8�� ����
		response.setContentType("text/html; charset=UTF-8");	//�̰ɷ� �о��
		//request.setCharacterEncoding("UTF-8");	// UTF-8�� �Է�
		
		String num_ [] = request.getParameterValues("x");
		String op = request.getParameter("op");
		
		PrintWriter out = response.getWriter();
		int result = 0;
		int x = Integer.parseInt(request.getParameter("x"));
		int y = Integer.parseInt(request.getParameter("y"));
		
		if (op.equals("����"))
			for (int i =0;i<num_.length;i++) {
				int num = Integer.parseInt(num_[i]);
				result += num;
			}
		if (op.equals("����"))
			result = x-y;
		out.println(result);
	}
}

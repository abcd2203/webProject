package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/calc4")	// ������̼� Ȱ��

public class calc4 extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request	// �Էµ���
			, HttpServletResponse response	// ���䵵��
			) throws ServletException, IOException {
		
		response.setCharacterEncoding("UTF-8");	// ���ڵ��� UTF-8�� ����
		response.setContentType("text/html; charset=UTF-8");	//�̰ɷ� �о��
		//request.setCharacterEncoding("UTF-8");	// UTF-8�� �Է�
		
		String x_ = request.getParameter("x");
//		String y_ = request.getParameter("y");
		String op = request.getParameter("op");
		
		PrintWriter out = response.getWriter();
		String result = "";
//		int x = Integer.parseInt(x_);
//		int y = Integer.parseInt(y_);
		
		if(x_.equals("����ȣ"))
			result = x_;
		else
			result = "�� ������";
		out.println(result);
	}
}

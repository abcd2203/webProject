package nam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hi")	// ������̼� Ȱ��

public class Test extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req	// �Էµ���
			, HttpServletResponse resp	// ���䵵��
			) throws ServletException, IOException {
		
		resp.setCharacterEncoding("UTF-8");	// ���ڵ��� UTF-8�� ����
		resp.setContentType("text/html; charset=UTF-8");	//�̰ɷ� �о��
		
		PrintWriter out = resp.getWriter();
		
		String temp = req.getParameter("cnt");
		
		int cnt = 10;
		if(temp!=null && !temp.equals(""))
			cnt = Integer.parseInt(temp);
			
		for (int i = 1; i<=cnt; i++) {
			out.println((i)+ " : �ȳ� ����!!! <br/>");
			System.out.println(i);
		}
	}
}

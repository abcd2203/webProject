package FileTest;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.Model.FileDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
@WebServlet("/UploadService")
public class UploadService extends HttpServlet {

		
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          String fileName = request.getParameter("file");
          System.out.println(fileName);
          
          ServletContext context = getServletContext(); //어플리케이션에 대한 정보를 ServletContext 객체가 갖게 됨. 
          String saveDir = context.getRealPath("Upload"); //절대경로를 가져옴
          System.out.println("절대경로 >> " + saveDir);
          
          int maxSize = 3*1024*1024; // 3MB
          String encoding = "euc-kr";
          
          
          boolean isMulti = ServletFileUpload.isMultipartContent(request);// boolean타입. ??????
          if (isMulti) {
                MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, encoding,
                            new DefaultFileRenamePolicy());
                FileDAO dao = new FileDAO();
                String author = multi.getParameter("author");
                String title = multi.getParameter("title");
                String file = multi.getFilesystemName("file");
                try {
                      int result = dao.uploadFile(author, title, file);
                      String moveUrl = "";
                      if (result > 0) {
                            System.out.println("저장완료");
                            moveUrl = "selectService";
                      } else {
                            System.out.println("저장실패");
                            moveUrl = "Upload.html";
                      }
                      response.sendRedirect(moveUrl);
                } catch (Exception e) {
                      e.printStackTrace();
                }
          } else {
                System.out.println("일반 전송 form 입니다.");
          }
	}
}
package com.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import DB.DButil;

public class FileDAO {
      //DB연결
      public void getConnection() {}
    
      //DB연결 종료
      public void close() {}    
      
      // DB 모든 정보 읽음
      public ArrayList<FileVO> selectAll() {
    	    //코드생략
    	  String SQL = "select * from fileboard";
    	  try {
    			Connection conn = DButil.getConnection();
    			PreparedStatement pstmt = conn.prepareStatement(SQL);
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    	    return new ArrayList<FileVO>();
    	}

      //파일업로드
      public int uploadFile(String author, String title, String file) {
    	  String SQL = "insert into fileboard values (file_num.nextval,?,?,?,to_char(sysdate,'YYYY-MM-DD'))";
  		try {
  			Connection conn = DButil.getConnection();
  			PreparedStatement pstmt = conn.prepareStatement(SQL);
  			pstmt.setString(1, author);
  			pstmt.setString(2, title);
  			pstmt.setString(3, file);
  			
  			return pstmt.executeUpdate();	// insert구문 반영
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		return -1;
      }
      
}
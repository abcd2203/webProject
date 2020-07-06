package com.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import DB.DButil;

public class FileDAO {
      //DB����
      public void getConnection() {}
    
      //DB���� ����
      public void close() {}    
      
      // DB ��� ���� ����
      public ArrayList<FileVO> selectAll() {
    	    //�ڵ����
    	  String SQL = "select * from fileboard";
    	  try {
    			Connection conn = DButil.getConnection();
    			PreparedStatement pstmt = conn.prepareStatement(SQL);
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    	    return new ArrayList<FileVO>();
    	}

      //���Ͼ��ε�
      public int uploadFile(String author, String title, String file) {
    	  String SQL = "insert into fileboard values (file_num.nextval,?,?,?,to_char(sysdate,'YYYY-MM-DD'))";
  		try {
  			Connection conn = DButil.getConnection();
  			PreparedStatement pstmt = conn.prepareStatement(SQL);
  			pstmt.setString(1, author);
  			pstmt.setString(2, title);
  			pstmt.setString(3, file);
  			
  			return pstmt.executeUpdate();	// insert���� �ݿ�
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		return -1;
      }
      
}
package org.project.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.apache.ibatis.annotations.Mapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.project.domain.AuthVO;
import org.project.domain.MemberVO;
import org.project.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
  "file:src/main/webapp/WEB-INF/spring/root-context.xml",
  "file:src/main/webapp/WEB-INF/spring/security-context.xml"
  })
@Log4j
public class MemberTests {

  @Setter(onMethod_ = @Autowired)
  private PasswordEncoder pwencoder;
  
  @Setter(onMethod_ = @Autowired)
  private DataSource ds;
  
  @Autowired
  private MemberMapper mapper;
  

//<security:authentication-manager>
//	<security:authentication-provider>
//	<security:jdbc-user-service data-source-ref="dataSource" />
//	
//	<security:password-encoder ref="bcryptPasswordEncoder" />
//</security:authentication-provider>
//</security:authentication-manager>
  
  // 권한 부여
  public void testInsertAuth() {
    
    
    String sql = "insert into member_auth (userid, auth) values (?,?)";
    
    for(int i = 0; i < 100; i++) {
      
      Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
        con = ds.getConnection();
        pstmt = con.prepareStatement(sql);
      
        
        if(i <80) {
          
          pstmt.setString(1, "user"+i);
          pstmt.setString(2,"ROLE_USER");
          
        }else if (i <90) {
          
          pstmt.setString(1, "manager"+i);
          pstmt.setString(2,"ROLE_MEMBER");
          
        }else {
          
          pstmt.setString(1, "admin"+i);
          pstmt.setString(2,"ROLE_ADMIN");
          
        }
        
        pstmt.executeUpdate();
        
      }catch(Exception e) {
        e.printStackTrace();
      }finally {
        if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
        if(con != null) { try { con.close();  } catch(Exception e) {} }
        
      }
    }//end for
  }

  
  
  // user 생성
  public void testInsertMember() {

      String sql = "insert into member(userid, userpw, username, email) values (?,?,?,?)";
      
      for(int i = 0; i < 100; i++) {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
          con = ds.getConnection();
          pstmt = con.prepareStatement(sql);
          
          pstmt.setString(2, pwencoder.encode("pw" + i));
          
          if(i < 80) {
            
            pstmt.setString(1, "user"+i);
            pstmt.setString(3,"일반사용자"+i);
            pstmt.setString(4, "user"+i+"@example.com");
            
          } else if (i < 90) {
            
            pstmt.setString(1, "manager"+i);
            pstmt.setString(3,"운영자"+i);
            pstmt.setString(4, "manager"+i+"@example.com");
            
          } else {
            
            pstmt.setString(1, "admin"+i);
            pstmt.setString(3,"관리자"+i);
            pstmt.setString(4, "admin"+i+"@example.com");
            
          }
          
          pstmt.executeUpdate();
          
        } catch(Exception e) {
          e.printStackTrace();
        } finally {
          if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
          if(con != null) { try { con.close();  } catch(Exception e) {} }
          
        }
      }//end for
  }


  
}



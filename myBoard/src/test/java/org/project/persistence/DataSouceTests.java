package org.project.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSouceTests {
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private DataSource dataSource;
	
	@Test
	public void testMyBatis() {

		// java의 예외차리 문법 중 try-with-resources문법
	    // AutoCloseable 인터페이스(close메서드를 정의한)를 구현한 리소스(SqlSession,Connection..)를 
	    // 자동으로 닫는데 사용됨(리소스 누수를 방지함)
	    // 주로 파일, 네트워크 연결, 데이터베이스 연결과 같은 리소스를 다룰 때 활용함
	    
	    // sqlsessiton에 autoclose가 구현되어 있고, 
	    // try 구문이 끝나면  close()메서드가 호출되어 자동으로 리소스가 닫힌다.
		try (SqlSession session = sqlSessionFactory.openSession();
				// RootConfig에 정의한 데이터 연결 정보를 session에 담음`
				
				Connection con = session.getConnection();
				// Connection클래스는 데이터베이스와 연결 및 반환하는 역할
				) {
			
			log.info("sqlSessionFactory.openSession() :" + sqlSessionFactory.openSession());
			log.info("session은: " + session);	
			log.info("session.getConnection() :" + session.getConnection());			
			log.info("con은: " + con);
			
			session.close();
			con.close();
			
		} catch (Exception e) {
			fail(e.getMessage());
		}

	}
	
	  @Test 
	  public void testConnection() { try (Connection con =
	  dataSource.getConnection()) { log.info(con); } catch (Exception e) {
	  fail(e.getMessage()); } }

}

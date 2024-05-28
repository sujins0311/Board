package org.project.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JDBCTests {
	

	// SLF4J 로거를 초기화합니다.
	private static final Logger log = LoggerFactory.getLogger(JDBCTests.class);
	
	static {
        try {
            // MariaDB JDBC 드라이버 클래스를 로드
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	@Test// 이미지 파일인지 확인 여부
	public void testRegExp() {
		String suffix = "jpeg";
		
		String regExp = "^(jpg|jpeg|JPG|JPEG|png|PNG|gif|GIF|bmp|BMP)";
		
		System.out.println(suffix.matches(regExp));
	}


    public void testConnection() {
        try (Connection con = DriverManager.getConnection(
                // MariaDB 데이터베이스에 연결
        		
        		// 데이터베이스 서버 주소 및 포트, 데이터베이스 이름, SSL옵션 추가
        		"jdbc:mariadb://localhost:13306/myBoard?useSSL=false",             
                "user", // 사용자 이름
                "mypw1234")) { // 사용자 비밀번호
        	

            // 연결에 성공하면 연결 정보와 함께 로그 메시지를 출력
        	// {}는 포맷 문자열로 동적인 값으로 대체됨. 매게변수로 받음. con이 {}에 대체됨
            log.info("Connection: {}", con);
            // INFO : org.project.persistence.JDBCTests - Connection: org.mariadb.jdbc.Connection@19c0f4a


        } catch (Exception e) {
            // 연결이 실패하면 예외가 발생하고 스택 트레이스를 출력
            e.printStackTrace();
        }
    }
}
package org.project.security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BCryptTests {
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Test
	public void test1() {
		String str = "1111";
		
		String enStr = passwordEncoder.encode(str);
		boolean match = passwordEncoder.matches("1111",enStr);
		
		log.info(match); //INFO : org.project.security.BCryptTests - true
		log.info("----------------------------------");
		log.info(enStr);
		//INFO : org.project.security.BCryptTests - $2a$10$RyVh17J/hwqlET2DaQqT0Ow5WRbYeEHN6Y6tRphvDKUvPy9ZkEJ1e
		//INFO : org.project.security.BCryptTests - $2a$10$1FJ/zRbEY3WyyrgGMh6oSuV5FUVFskfWrscJHvL2lFNCMzERZxmb6
	}

}

package org.project.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.project.domain.Ticket;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//was를 실행하지 않는 테스트(Test for Controller)
//Java Config 일경우,
//@ContextConfiguration(classes = {
//org.project.config.RootConfig.class,
//org.project.config.ServletConfig.class} )
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // servlet-context.xml
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
public class ReplyControllerTests {
	// RestController 테스트
	// 순수 데이터를 반환 = 다양한 포맷 데이터 전송가능(일반문자열 , JSON, XML..)

	@Setter(onMethod_ = { @Autowired })
	private WebApplicationContext ctx;

	// MockMvc는 가짜MVC로 가짜URL과 파라미터 등을 브라우저에서 사용하는 것처럼 만들어 Controller를 실행하기 위함
	private MockMvc mockMvc;

	// @Before는 해당메서드는 모든 메서드 실행 전에 매번 실행되는 초기화 메서드가 됨
	@Before // import org.junit.Before;
	public void setup() {
		this.mockMvc = MockMvcBuilders
				.webAppContextSetup(ctx) // 웹 어플리케이션 환경설정(ApplicationContext 또는 WebApplicationContext를 인자로 받음)
				.build();
	}
	
	
	  @Test
	  public void testConvert() throws Exception {

	    Ticket ticket = new Ticket();
	    ticket.setTno(123);
	    ticket.setOwner("Admin");
	    ticket.setGrade("AAA");
	    
	    String jsonStr = new Gson().toJson(ticket);
	    
	    log.info(jsonStr);
	    
	    mockMvc.perform(post("/sample/ticket")
	        .contentType(MediaType.APPLICATION_JSON)
	        .content(jsonStr))
	        .andExpect(status().is(200));
	  }

}

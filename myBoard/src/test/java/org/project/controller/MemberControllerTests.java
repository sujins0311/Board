package org.project.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.project.domain.AuthVO;
import org.project.domain.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;


import lombok.Setter;
import lombok.extern.log4j.Log4j;

//was를 실행하지 않는 테스트(Test for Controller)
//Java Config
//@ContextConfiguration(classes = {
//org.zerock.config.RootConfig.class,
//org.zerock.config.ServletConfig.class} )
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // servlet-context.xml
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
public class MemberControllerTests {

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

	
	// ModelMap는 컨트롤러가 뷰에 전달한 데이터
	// MvcResult를 통해 HTTP 응답과 관련된 정보
	// 게시글 등록
	@Test
	public void testCreatePost() throws Exception {
		
	    MemberVO memberVO = new MemberVO();
	    memberVO.setUserid("admin00");
	    memberVO.setUserpw("pw00");
	    memberVO.setUsername("admin00");
	    memberVO.setEmail("admin00@test.com");
	    memberVO.setAuthList(new ArrayList<>());
	    
	    List<AuthVO> authList = new ArrayList<>();
	    AuthVO authVO = new AuthVO();
	    authVO.setUserid("");
	    authVO.setAuth("");
	    authList.add(authVO);

	    memberVO.setAuthList(authList);
	    
	    
	    String resultPage = mockMvc.perform(post("/auth/register")
	            .param("userid", memberVO.getUserid())
	            .param("userpw", memberVO.getUserpw())
	            .param("username", memberVO.getUsername())
	            .param("email", memberVO.getEmail()))
	            .andExpect(status().is3xxRedirection())
	            .andExpect(view().name("redirect:/auth/register"))
	            .andReturn().getModelAndView().getViewName();
	    log.info(resultPage);
	}
	


}

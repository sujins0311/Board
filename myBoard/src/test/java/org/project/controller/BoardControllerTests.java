package org.project.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//was를 실행하지 않는 테스트(Test for Controller)
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration //servlet-context.xml
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
//Java Config
//@ContextConfiguration(classes = {
//org.zerock.config.RootConfig.class,
//org.zerock.config.ServletConfig.class} )
@Log4j
public class BoardControllerTests {

	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;

	// MockMvc는 가짜MVC로 가짜URL과 파라미터 등을 브라우저에서 사용하는 것처럼 만들어 Controller를 실행하기 위함
	private MockMvc mockMvc;

	//@Before는 해당메서드는 모든 메서드 실행 전에 매번 실행되는 초기화 메서드가 됨
	@Before //import org.junit.Before;
	public void setup() {
		this.mockMvc = MockMvcBuilders
				.webAppContextSetup(ctx) // 웹 어플리케이션 환경설정(ApplicationContext 또는 WebApplicationContext를 인자로 받음)
				.build();
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc
		.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "58"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	
	
//	@Test
//	public void testModify() throws Exception {
//		String resultPage = mockMvc
//				.perform(MockMvcRequestBuilders.post("/board/modify")
//						.param("bno", "1")
//						.param("title", "수정된 테스트 새글 제목")
//						.param("content", "수정된 테스트 새글 내용")
//						.param("writer", "user00"))
//				.andReturn().getModelAndView().getViewName();
//		log.info(resultPage);
//	}
	
//	@Test
//	public void testGet() throws Exception {
//		log.info(mockMvc.perform(MockMvcRequestBuilders
//						.get("/board/get")
//						.param("bno", "1"))
//						.andReturn().getModelAndView().getModelMap());
//	}
	
//	@Test
//	public void testRegister()throws Exception{
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders
//				.post("/board/register")
//				.param("title", "테스트 새글 제목")
//				.param("content", "테스트 새글 내용")
//				.param("writer", "user")
//				).andReturn().getModelAndView().getModelMap();
//		log.info(resultPage);
//	}

//	// 가짜URL: MockMvcRequestBuilders를 이용해 GET방식 호출하고,
//	// BoardContorller의 @RequestMapping("/board/*")@GetMapping("/list")list() 
//	// list()메서드의 service.getList()에서 반환된 결과를 이용해 Model에 어떤 데이터가 담긴지 확인함
//	@Test
//	public void testList() throws Exception {
//
//		log.info(
//				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
//				.andReturn() //요청결과를 반환
//				.getModelAndView() // 반환된 결과에서`ModelAndView`객체를 가져옴
//				.getModelMap()); // `ModelAndView`에서 모델 정보를 가져옴
//	}//INFO : org.zerock.controller.BoardControllerTests - {list=[BoardVO(bno=1, title=수정된 제목, content=수정된 내용, writer=user00, regdate=Wed Nov 22 03:20:42 KST 2023, updateDate=Mon Nov 27 19:26:19 KST 2023), BoardVO(bno=49, title=테스트 제목, content=테스트 내용, writer=user00, regdate=Mon Nov 27 18:30:16 KST 2023, updateDate=Mon Nov 27 18:30:16 KST 2023), BoardVO(bno=50, title=테스트 제목, content=테스트 내용, writer=user00, regdate=Mon Nov 27 18:30:17 KST 2023, updateDate=Mon Nov 27 18:30:17 KST 2023), BoardVO(bno=52, title=테스트 제목, content=테스트 내용, writer=user00, regdate=Mon Nov 27 18:42:56 KST 2023, updateDate=Mon Nov 27 18:42:56 KST 2023), BoardVO(bno=53, title=제목 수정합니다., content=새로 작성하는 내용, writer=newbie, regdate=Wed Nov 29 15:42:22 KST 2023, updateDate=Wed Nov 29 19:14:48 KST 2023), BoardVO(bno=54, title=새로 작성하는 글, content=새로 작성하는 내용, writer=newbie, regdate=Wed Nov 29 15:48:45 KST 2023, updateDate=Wed Nov 29 15:48:45 KST 2023)]}

}

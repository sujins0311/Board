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
import org.springframework.web.bind.annotation.RequestParam;
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
public class BoardControllerTests {

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
	
	
	// 게시글 목록(페이지)
	@Test
	public void testGetPostsByPage() throws Exception {
		log.info(mockMvc
				.perform(MockMvcRequestBuilders.get("/board/getPostList")
				.param("currentPageNum", "2")
				.param("itemsPerPage", "10"))
				.andReturn() // 요청결과를 반환
				.getModelAndView() // 반환된 결과에서`ModelAndView`객체를 가져옴
				.getModelMap()); // `ModelAndView`에서 모델 정보를 가져옴
	}



	// 게시글 수정
	public void testModify() throws Exception {
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/board/modifyPost")
						.param("bno", "4")
						.param("title", "수정된 테스트 새글 제목")
						.param("content", "수정된 테스트 새글 내용")
						.param("writer", "user00"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	
	// 게시글 삭제
	public void testDeletePost() throws Exception {
		String resultPage = mockMvc
		.perform(MockMvcRequestBuilders.post("/board/deletePost")
				.param("bno", "9"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}


	// 게시글 조회
	public void testGetPost() throws Exception {
		log.info(mockMvc
				.perform(MockMvcRequestBuilders.get("/board/getPost")
				.param("bno", "26"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	//{board=BoardVO(bno=26, title=테스트 새글 제목, content=테스트 새글 내용, writer=user, createdDate=Wed Dec 27 14:26:08 KST 2023, updatedDate=null), 
	// org.springframework.validation.BindingResult.board=org.springframework.validation.BeanPropertyBindingResult: 0 errors}
	// @RequestParam("bno")에서 bno를 바인딩 -> BindingResult

	
	// ModelMap는 컨트롤러가 뷰에 전달한 데이터
	// MvcResult를 통해 HTTP 응답과 관련된 정보
	// 게시글 등록
	public void testCreatePost() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/createPost")
				.param("title", "테스트 새글 제목")
				.param("content", "테스트 새글 내용")
				.param("writer", "user")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}//INFO : org.project.controller.BoardControllerTests - redirect:/board/list
	
	 
	// 가짜URL: MockMvcRequestBuilders를 이용해 GET방식 호출하고,
	// BoardContorller의 @RequestMapping("/board/*")@GetMapping("/list")list()
	// list()메서드의 service.getList()에서 반환된 결과를 이용해 Model에 어떤 데이터가 담긴지 확인함
	// 게시글 목록 조회
	public void testGetPostList() throws Exception {
		log.info(mockMvc
				.perform(MockMvcRequestBuilders.get("/board/getPostList"))
				.andReturn() // 요청결과를 반환
				.getModelAndView() // 반환된 결과에서`ModelAndView`객체를 가져옴
				.getModelMap()); // `ModelAndView`에서 모델 정보를 가져옴
	}

}

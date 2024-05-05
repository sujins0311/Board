package org.project.controller;

import org.project.domain.Criteria;
import org.project.domain.ReplyPageDTO;
import org.project.domain.ReplyVO;
import org.project.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/replies/*")
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;

	// 등록
	// @PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", // url
				consumes = "application/json", // 요청타입 > json
				produces = { MediaType.TEXT_PLAIN_VALUE }) // 응답타입 > text
	@PreAuthorize("hasAnyRole('principal.username == #vo.replyer','ROLE_ADMIN')")
	public ResponseEntity<String> create(@RequestBody ReplyVO replyVO) { 
		// payload(JSON) ----> ReplyVO Mapping 시도 Setter 사용 (메서드 호출 시)
		// 메서드 로직 시작하면서 파라메터에 주입 할때는 Getter 사용
		
		// @RequestBody ReplyVO > 요청본문을 자바객체로 변환
		// ResponseEntity<String> > text로 반환하므로 string
		log.info("ReplyVO: ***** " + replyVO);
		int insertCount = service.register(replyVO); 
		log.info("Reply INSERT COUNT: ************service 객체의 register 메서드를 호출하여 DB에 등록 댓글을 확인합니다. " + insertCount);
		
		return insertCount == 1  
		        ?  new ResponseEntity<>("success", HttpStatus.OK)
		        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	

	// 조회
	@GetMapping(value = "/{rno}", 
			produces = { MediaType.APPLICATION_XML_VALUE, 
					     MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {

		log.info("get: " + rno);

		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}

	// 수정
	@PreAuthorize("hasAnyRole('principal.username == #vo.replyer','ROLE_ADMIN')")
	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{rno}", consumes = "application/json", produces = {
					MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
			 @RequestBody ReplyVO replyVO, 
			 @PathVariable("rno") Long rno) {

		replyVO.setRno(rno);

		log.info("rno: " + rno);
		log.info("modify: " + replyVO);

		return service.modify(replyVO) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
	
	// @DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	// public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
	//
	// log.info("remove: " + rno);
	//
	// return service.remove(rno) == 1 ? new ResponseEntity<>("success",
	// HttpStatus.OK)
	// : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	//
	// }

	// 삭제
	@PreAuthorize("hasAnyRole('principal.username == #vo.replyer','ROLE_ADMIN')")
	@DeleteMapping("/{rno}")
	public ResponseEntity<String> remove(
			@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {

		log.info("remove: " + rno);
		log.info("replyer: " + vo.getReplyer());

		return service.remove(rno) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	// http://localhost:8080/replies/pages/47/1.json
//	 @GetMapping(value = "/pages/{bno}/{page}", 
//			 produces = {
//					 MediaType.APPLICATION_XML_VALUE,
//					 MediaType.APPLICATION_JSON_UTF8_VALUE })
//	 public ResponseEntity<List<ReplyVO>> getList(
//			 @PathVariable("page") int page,
//			 @PathVariable("bno") Long bno) {
//		 
//		 log.info("getList.................");
//		 Criteria cri = new Criteria(page,10);
//		 log.info(cri);
//	
//	 return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
//	 }

	// 목록
	// http://localhost:8080/replies/pages/47/1.json
	// .json 일 경우 JSON 타입으로 응답
	// http://localhost:8080/replies/pages/47/1
	// 아닐 경우 XML 타입으로 응답
	@GetMapping(value = "/pages/{bno}/{page}", 
			produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) {
		Criteria cri = new Criteria(page, 10);	
		log.info("get Reply List bno: " + bno);
		log.info("cri:" + cri);
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}

}

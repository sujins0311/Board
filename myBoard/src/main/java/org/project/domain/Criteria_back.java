//package org.project.domain;
//
//import lombok.Getter;
//import lombok.Setter;
//import lombok.ToString;
//
//@ToString
//@Setter
//@Getter
//public class Criteria_back {
//
//	private int currentPageNum; // 현재 페이지 그룹의 번호
//	private int itemsPerPage; // 한 페이지에 보여줄 아이템 개수
//	
//	private String type;
//	private String titleKeyword;
//	private String contentKeyword;
//	private String writerKeyword;
//	
//	// 생성자 정의 -> @Builder로 대체함
//	// 생성자는 클래스의 이름과 동일해야 합니다.
//	// 생성자에 반환 타입을 명시하지 않습니다.
//	// 생성자는 객체를 초기화하는 데 사용되며, 객체를 생성할 때 호출된다
//	public Criteria_back(int currentPageNum, int itemsPerPage) {
//		this.currentPageNum = currentPageNum; // 페이지 번호 초기화
//		this.itemsPerPage = itemsPerPage; // 페이지 당 항목 수 초기화
//	}
//
//	// 별도의 매개변수가 없으면 페이지 번호와 항목 수를 (1,10)기본값으로 초기화
//	public Criteria_back() {
//		this(1, 10);
//	}
//
//	// 검색
//	public String[] getTypeArr() {
//		System.out.println("검색기능 작성주우우웅....................");
//		return type == null? new String[] {} : type.split(""); 
//		// 디버그모드에서 메서드 진입 후 그 메서드에서 실행부의 결과를 미리 실행해볼수 있다.
//		// ctrl + shift + i
//		// 이클립스 여러줄 편집 alt + shift + a
//		// 삼항연산자(조건 ? 값1 : 값2)
//		// type.split("") 빈문자열을 구분자로 hi = h,i
//	}
//}
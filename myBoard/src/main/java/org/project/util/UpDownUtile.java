package org.project.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import net.coobird.thumbnailator.Thumbnails;

@Component
@Log4j
public class UpDownUtile {

	private final String UPLOAD = "C:\\upload\\tmp";

	public void uploadFormPost(MultipartFile[] uploadFile) {

		if (uploadFile == null || uploadFile.length == 0) { // 파일이 없을떄
			return;
		}

		// MultipartFile[] 배열이라 for루프
		for (MultipartFile multipartFile : uploadFile) {

			// fileSize 체크
			if (multipartFile.getSize() == 0) { // getSize == 0 일경우 계속하고
				continue;
			}
			
			String fileName = multipartFile.getOriginalFilename();
			String uuid = UUID.randomUUID().toString(); // 36자리 랜덤 문자열

			String saveFileName = uuid + "_" + fileName; // _ 로 구분
			// 파일 섬네일 시작
			// jpg, gif, png, bmp
			String suffix = fileName.substring(fileName.lastIndexOf(".")+1);
			
			log.info("----------------------------------------------");
			log.info(suffix);
			// 파일 확장자로 외부 공격을 막음
	        // 파일 확장자를 검사하여 허용된 이미지 파일만 업로드할 수 있게 합니다.
	    	// 이는 악성 스크립트나 다른 공격을 포함할 수 있는 허용되지 않은 파일의 업로드를 방지하여 보안성을 높인다.
			String regExp = "^(jpg|jpeg|JPG|JPEG|png|PNG|gif|GIF|bmp|BMP)";
			
			if(!suffix.matches(regExp)) {
				continue;
			}
			
			// 파일 섬네일 끝

			// try-catch 해줘야한다
			try (InputStream in = multipartFile.getInputStream(); 
					OutputStream out = new FileOutputStream(UPLOAD + File.separator + saveFileName)
							) {
				// 파일 지정경로에 저장
				FileCopyUtils.copy(in, out);
				
				// 파일 섬네일
				Thumbnails.of(new File(UPLOAD + File.separator + saveFileName))
				.size(200, 200)
				.toFile(UPLOAD + File.separator + "s_" + saveFileName);

			} catch (Exception e) {
				log.error(e.getMessage());

			}

		} // 파일업로드처리 for

	}

}

package com.astemall.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

public class FileUtils {

	/* 
	 * 파일 업로드
	 uploadFolder: 업로드할 폴더 경로  C:\\dev\\upload\\pds
	 uploadDateFolder: 날짜 폴더
	 uploadFile: 업로드할 파일
	 * 상품이미지를 업로드 하면 -> 업로드할 폴더 경로에, 업로드 당일 날짜 폴더를 자동 생성한 뒤 -> 업로드된다.
	 */
	public static String uploadFile(String uploadFolder, String uploadDateFolder, MultipartFile uploadFile) {
		
		String uploadFileName = ""; // 업로드할 파일 이름
		File uploadFolderPath = new File(uploadFolder, uploadDateFolder); // 업로드할 폴더 경로, 날짜 폴더 정보 저장
		
		// 1) 날짜 폴더 생성
		// uploadFolder(업로드 폴더 경로)에 uploadDateFolder(날짜 폴더)가 존재하는지 확인하고, 없다면 생성
		if(uploadFolderPath.exists() == false) { uploadFolderPath.mkdirs(); }
		
		// 2) 클라이언트에서 업로드한 파일명 추출
		String uploadClientFileName = uploadFile.getOriginalFilename();
		
		// 3) 실제 업로드할 파일명 생성 - 클라이언트에서 업로드한 파일명은 중복될 수 있기 때문에 별도의 파일명 생성
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadClientFileName;
		
		try {
			// 업로드할 파일 객체 생성
			File saveFile = new File(uploadFolderPath, uploadFileName);
			// 파일 업로드(실질적으론 복사). 예외처리
			uploadFile.transferTo(saveFile);  
			
			// 썸네일 작업
			// 파일이 이미지인지 확인
			if(checkImageType(saveFile)) {
				// 업로드할 폴더 경로에  썸네일 파일(0byte, 파일명"s_uploadFileName") 생성
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadFolderPath, "s_" + uploadFileName));  
				// 원본 이미지파일을 읽고, 썸네일 이미지파일에 출력
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return uploadFileName;
	}
	
	// 날짜폴더 생성을 위한 날짜 정보
	public static String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator); // 현재 운영체제에 맞춰 경로 구분자 변경(서버 배포할 때를 고려)
	}
	
	// 업로드되는 파일 구분(이미지파일 or 일반파일)
	private static boolean checkImageType(File saveFile) {
		boolean isImage = false;
		
		try {
			String contentType = Files.probeContentType(saveFile.toPath()); // 업로드 파일의 MIMEtype 
			isImage = contentType.startsWith("image");  // 이미지 파일이면 true, 아니면 false
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isImage;
	}
	
	// 상품이미지를 바이트배열로 읽어오기 -> 상품 목록의 상품 이미지 출력, 상품 수정 폼에서 기존 상품 이미지 미리보기에 사용
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) throws IOException{
		ResponseEntity<byte[]> entity = null;
		File file = new File(uploadPath, fileName);  // uploadPath: 상품이미지가 저장된 경로, fileName: 이미지 파일명
		
		//해당 상품이미지가 존재하지 않는 경우
		if(!file.exists()) return entity;
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", Files.probeContentType(file.toPath()));  // 업로드 이미지의 MIMEtype을 헤더에 추가
		entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		return entity;
	}
	
	// 파일 삭제 - 상품 수정 시, 원본 상품이미지 삭제에 사용
	public static void deleteFile(String uploadPath, String folderName, String fileName) {
		// 원본 상품이미지 삭제
		new File((uploadPath + folderName + "/" + fileName).replace('/', File.separatorChar)).delete();
		
		// 원본 썸네일이미지 삭제
		new File((uploadPath + folderName + "/" + "s_" + fileName).replace('/', File.separatorChar)).delete();
		
	}
}

package com.astemall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.astemall.domain.CategoryVO;
import com.astemall.domain.ProductVO;
import com.astemall.dto.Criteria;
import com.astemall.dto.PageDTO;
import com.astemall.service.AdProductService;
import com.astemall.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/product/*")
@Controller
public class AdProductController {

	@Setter(onMethod_ = {@Autowired})
	private AdProductService adProductService;
	
	// 상품이미지 업로드 폴더 주입
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// CKEditor 업로드 폴더 주입
	@Resource(name = "uploadCKEditorPath")
	private String uploadCKEditorPath;
	
	// 상품등록 폼
	@GetMapping("/pro_insert")
	public void pro_insert(Model model) {
		// 1차 카테고리 출력
		model.addAttribute("categoryList", adProductService.mainCategoryList());
	}
	
	// 2차 카테고리 출력. Ajax
	@ResponseBody
	@GetMapping("/subCategory/{ctgr_cd}")
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("ctgr_cd") Integer ctgr_cd){
		ResponseEntity<List<CategoryVO>> entity = null;
		entity = new ResponseEntity<List<CategoryVO>>(adProductService.subCategoryList(ctgr_cd), HttpStatus.OK);
		return entity;
	}
	
	// 상품 등록 - 상품정보 저장
	@PostMapping("/pro_insert")
	public String pro_insert(ProductVO vo, RedirectAttributes rttr) {
		
		String uploadDateFolder = FileUtils.getFolder();  // 상품이미지가 업로드된 날짜 폴더
		String saveImageName = FileUtils.uploadFile(uploadPath, uploadDateFolder, vo.getUploadFile());  // 업로드된 파일명
		
		// vo객체에 업로드 이미지 정보 추가
		vo.setPrd_img(saveImageName);
		vo.setPrd_up_folder(uploadDateFolder);
				
		adProductService.pro_insert(vo);
		log.info("상품정보: " + vo);
		
		return "redirect:/admin/product/pro_list";
	}
	
	// CKEditor에서 파일업로드 사용 (상품등록 - 상품설명 - 이미지삽입)
	@PostMapping("/imageUpload")
	public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		// 클라이언트에 보낼 정보에 대한 설명
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8"); 
		
		try {
			// 1)업로드 작업
			String fileName = upload.getOriginalFilename();  // 클라이언트에서 보낸 파일 이름
			byte[] bytes = upload.getBytes();  // 파일 내용을 바이트배열로 확보
			
			String uploadPath = uploadCKEditorPath + fileName;
			log.info("파일업로드: " + uploadPath);
			
			out = new FileOutputStream(new File(uploadPath));  // 0byte의 파일 생성
			out.write(bytes);  // bytes의 내용 출력
			out.flush();
			
			// 2)업로드된 파일 정보를 CKEditor에게 보내기 - JSON
			printWriter = res.getWriter();
			String fileUrl = "/upload/" + fileName;
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1, \"url\":\"" + fileUrl + "\"}");
			printWriter.flush();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(out != null) {
				try {
					out.close();
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) printWriter.close();
		}
	}
	
	// 상품 목록
	@GetMapping("/pro_list")
	public void pro_list(@ModelAttribute("cri") Criteria cri, Integer ctgr_cd, Model model) {
		log.info("파라미터: " + cri);  // 검색기능 사용X 로그 확인용  & 검색기능 사용O 로그 확인용
		log.info("카테고리 코드: " + ctgr_cd);
		
		// 검색어 검색 기능 사용 후, 카테고리 검색 시 검색 파라미터 초기화
		if(ctgr_cd != null) {
			cri = new Criteria();
		}
		// 카테고리 검색 - 1차 카테고리 목록 출력
		model.addAttribute("categoryList", adProductService.mainCategoryList());
		
		// 상품목록 데이터
		List<ProductVO> pro_list = adProductService.getListWithPaging(cri, ctgr_cd); 
		
		// 클라이언트 -> 서버 요청시 데이터에 역슬래시 \가 있으면 파싱과정에서 문제 발생하므로 폴더 구분자를 슬래시 /로 변경한다.
		pro_list.forEach(vo -> {
			vo.setPrd_up_folder(vo.getPrd_up_folder().replace("\\", "/"));
		});
		log.info("폴더 경로: " + pro_list.get(0).getPrd_up_folder());  // 폴더 구분자 /
		
		model.addAttribute("pro_list", pro_list);  // 목록 데이터
		
		int totalCount = adProductService.getTotalCount(cri, ctgr_cd);
		model.addAttribute("pageMaker", new PageDTO(totalCount, cri));  // 페이징기능 정보
	}
	
	// 상품 이미지 (상품 목록, 상품 수정 폼의 현재 상품 이미지 미리보기에 사용)
	// /admin/product/displayImage?folderName=값&fileName=값
	@GetMapping("/displayImage")
	public ResponseEntity<byte[]> displayImage(String folderName, String fileName) throws IOException{
		return FileUtils.getFile(uploadPath+folderName, fileName);
	}
	
	// 상품 수정 폼
	@GetMapping("/pro_modifyForm")
	public void pro_modifyForm(Integer prd_no, int ctgr_cd, @ModelAttribute("cri") Criteria cri, Model model) {
		
		// 수정할 상품 정보
		ProductVO productVO = adProductService.pro_modifyForm(prd_no);  // 상품코드에 해당하는 상품 정보
		productVO.setPrd_up_folder(productVO.getPrd_up_folder().replace("\\", "/"));  // 상품 이미지 폴더 경로의 구분자 / 로 변경
		model.addAttribute("productVO", productVO);
		
		// 수정할 상품의 1차 카테고리 정보
		// DB에는 2차카테고리 정보만 존재하므로,
		// 2차 카테고리만을 가지고 그것의 상위 카테고리인 1차카테고리를 구하는 메소드를 만들어 사용
		CategoryVO categoryVO = adProductService.mainFSCategory(ctgr_cd);
		model.addAttribute("categoryVO", categoryVO);
		
		// 1차 카테고리 목록
		model.addAttribute("mainCategoryList", adProductService.mainCategoryList());
		// 1차 카테고리를 참조하는 2차 카테고리 목록
		model.addAttribute("subCategoryList", adProductService.subCategoryList(categoryVO.getCtgr_cd()));
	}
	
	// 상품 수정
	@PostMapping("/pro_modify")
	public String pro_modify(ProductVO vo, Criteria cri, RedirectAttributes rttr) {
		
		// 상품 이미지를 변경했을 경우, 기존 이미지를 삭제하고 변경 이미지를 업로드한다. (변경하지 않으면 기존 이미지 유지)
		if(!vo.getUploadFile().isEmpty()) {
			// 기존 상품이미지 삭제
			FileUtils.deleteFile(uploadPath, vo.getPrd_up_folder(), vo.getPrd_img());
			// 변경 상품이미지 업로드
			String uploadDateFolder = FileUtils.getFolder();  // 날짜폴더 경로
			String saveImageName = FileUtils.uploadFile(uploadPath, uploadDateFolder, vo.getUploadFile());  // 이미지 파일명
			vo.setPrd_img(saveImageName);
			vo.setPrd_up_folder(uploadDateFolder);
		
		// 상품 이미지를 변경하지 않았을 경우,
		}else if(vo.getUploadFile().isEmpty()){
			vo.setPrd_up_folder(vo.getPrd_up_folder().replace("/", "\\"));  // 상품 이미지 폴더 경로의 구분자 \ 로 변경하여 DB저장
		}
		
		
		// 수정 작업(상품이미지 변경 유무 상관없이 공통 작업)
		adProductService.pro_modify(vo);
		rttr.addFlashAttribute("msg", "modify");
		
		return "redirect:/admin/product/pro_list";
	}
	
	// 목록에서 체크박스 선택상품 수정. Ajax
	@ResponseBody
	@PostMapping("/pro_checked_modify")
	public ResponseEntity<String> pro_checked_modify(
			@RequestParam("prd_no_arr[]") List<Integer> prd_no_arr,
			@RequestParam("prd_price_arr[]") List<Integer> prd_price_arr,
			@RequestParam("prd_buy_arr[]") List<String> prd_buy_arr){
		ResponseEntity<String> entity = null;
		log.info("수정상품 코드: " + prd_no_arr);
		log.info("수정상품 가격: " + prd_price_arr);
		log.info("수정상품 판매여부: " + prd_buy_arr);
		
		// 수정상품들의 정보 -> List컬렉션에 저장
		List<ProductVO> prd_list = new ArrayList<ProductVO>();
		for(int i=0; i<prd_no_arr.size(); i++) {
			ProductVO productVO = new ProductVO();
			productVO.setPrd_no(prd_no_arr.get(i));
			productVO.setPrd_price(prd_price_arr.get(i));
			productVO.setPrd_buy(prd_buy_arr.get(i));
			prd_list.add(productVO);
		}
		
		// 수정 작업
		adProductService.pro_checked_modify(prd_list);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	// 상품 삭제
	@PostMapping("/pro_delete")
	public String pro_delete(Integer prd_no, Criteria cri, RedirectAttributes rttr) {
		adProductService.pro_delete(prd_no);
		rttr.addFlashAttribute("msg", "delete");
		return "redirect:/admin/product/pro_list" + cri.getListLink();
	}
	
	// 목록에서 체크박스 선택상품 수정. Ajax
	@ResponseBody
	@PostMapping("/pro_checked_delete")
	public ResponseEntity<String> pro_checked_delete(@RequestParam("prd_no_arr[]") List<Integer> prd_no_arr){
		ResponseEntity<String> entity = null;
		log.info("삭제상품 코드: " + prd_no_arr);
		
		adProductService.pro_checked_delete(prd_no_arr);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	// 상품 상세
	@GetMapping("/pro_get")
	public void pro_get(Integer prd_no, int ctgr_cd, @ModelAttribute("cri") Criteria cri, Model model) {
		
		// 상품 정보
		ProductVO productVO = adProductService.pro_detail(prd_no);  // 상품코드에 해당하는 상품 정보
		productVO.setPrd_up_folder(productVO.getPrd_up_folder().replace("\\", "/"));  // 상품 이미지 폴더 경로의 구분자 / 로 변경
		model.addAttribute("productVO", productVO);
		
		// 1차 카테고리 정보
		// 2차 카테고리만을 가지고 그것의 상위 카테고리인 1차카테고리를 구함
		CategoryVO mainCategoryVO = adProductService.mainFSCategory(ctgr_cd);
		model.addAttribute("mainCategoryVO", mainCategoryVO);
		
		// 2차 카테고리 정보
		CategoryVO subCategoryVO = adProductService.subCategory(ctgr_cd);
		model.addAttribute("subCategoryVO", subCategoryVO);
		
	}
	
	
}

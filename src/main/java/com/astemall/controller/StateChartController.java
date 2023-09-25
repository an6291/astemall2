package com.astemall.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.astemall.service.StateChartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/chart/*")
@Controller
public class StateChartController {

	@Setter(onMethod_ = {@Autowired})
	private StateChartService stateChartService;
	
	// 전체 통계 페이지 
	@GetMapping("/overall")
	public void overall() {
		
	}
	
	// (전체) 1차 카테고리별 매출.  Ajax
	@ResponseBody
	@GetMapping("/firstCategorySales")
	public ResponseEntity<JSONObject> firstCategorySales(){
		ResponseEntity<JSONObject> entity = null;
		entity = new ResponseEntity<JSONObject>(stateChartService.firstCategorySales(), HttpStatus.OK);
		return entity;
	}
	
	
}

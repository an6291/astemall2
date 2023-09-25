package com.astemall.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.mapper.StateChartMapper;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;

import lombok.Setter;

@Service
public class StateChartServiceImpl implements StateChartService {

	@Setter(onMethod_ = {@Autowired})
	private StateChartMapper stateChartMapper;

	@Override
	public JSONObject firstCategorySales() {
		
		// 1차 카테고리별 매출 데이터
		List<Map<String, Object>> list = stateChartMapper.firstCategorySales();
		
		/*
		 * chart api 데이터 구조 예시
		 {"rows":
		 	[
		 	 {"c":[{"v":"PANTS"},{"v":10000}]},
		 	 {"c":[{"v":"SHIRTS"},{"v":80000}]},
		 	 {"c":[{"v":"TOP"},{"v":205555}]}
		 	],
		 "cols":
		 	[											
		 	 {"label":"1차카테고리이름","type":"string"},
		 	 {"label":"주문금액","type":"number"}		
		 	]
		 }
		 */
		
		JSONObject data = new JSONObject();  // JSON데이터 전체 관리 객체
		
		// cols --------------------------------------------------------
		JSONArray title = new JSONArray();
		
		JSONObject col1 = new JSONObject();
		col1.put("label", "1차카테고리명");
		col1.put("type", "string");
		JSONObject col2 = new JSONObject();
		col2.put("label", "매출금액");
		col2.put("type", "number");
		
		title.add(col1);
		title.add(col2);
		
		data.put("cols", title);
		
		// rows --------------------------------------------------------
		JSONArray body = new JSONArray();
		for(Map<String, Object> map : list) {  // list: 1차 카테고리별 매출 데이터
			JSONArray row = new JSONArray();
			
			// "v":"카테고리명", ...
			JSONObject categoryname = new JSONObject();
			categoryname.put("v", map.get("categoryname"));
			// "v":매출금액, ...
			JSONObject sales = new JSONObject();
			sales.put("v", map.get("sales"));
			
			row.add(categoryname);
			row.add(sales);
			
			JSONObject cell = new JSONObject();
			cell.put("c", row);
			
			body.add(cell);
			
		}
		
		data.put("rows", body);
		
		return data;
	}
	
}

package com.astemall.mapper;

import java.util.List;
import java.util.Map;

public interface StateChartMapper {

	// (전체) 1차 카테고리별 매출
	List<Map<String, Object>> firstCategorySales();
	
	// (월별) 1차 카테고리별 매출
	List<Map<String, Object>> firstCategorySales_m(String ord_date);
	
	// (전체) 2차 카테고리별 매출
	List<Map<String, Object>> secondCategorySales();
	
	// (월별) 2차 카테고리별 매출
	List<Map<String, Object>> secondCategorySales_m(String ord_date);
	
	// 월별 매출
	List<Map<String, Object>> monthlySales(String ord_date);
	
	// 매년 총 매출
	List<Map<String, Object>> totalSales();
}

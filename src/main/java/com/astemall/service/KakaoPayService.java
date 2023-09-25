package com.astemall.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.astemall.kakaopay.ApproveResponse;
import com.astemall.kakaopay.ReadyResponse;

@Service
public class KakaoPayService {

	/* 결제준비요청 
	 * 기본정보
	 	POST /v1/payment/ready HTTP/1.1
		Host: kapi.kakao.com
		Authorization: KakaoAK ${APP_ADMIN_KEY}
		Content-type: application/x-www-form-urlencoded;charset=utf-8
	 */
	public ReadyResponse payReady(String cid, Long partner_order_id, String partner_user_id, String item_name, 
			int quantity, int total_amount, int tax_free_amount, String approval_url, String cancel_url, String fail_url) {

		String url = "https://kapi.kakao.com/v1/payment/ready";
		
		// 요청에 사용될 파라미터(Body)
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>(); 
		parameters.add("cid", cid);
		parameters.add("partner_order_id", String.valueOf(partner_order_id));
		parameters.add("partner_user_id", partner_user_id);
		parameters.add("item_name", item_name);
		parameters.add("quantity", String.valueOf(quantity));
		parameters.add("total_amount", String.valueOf(total_amount));
		parameters.add("tax_free_amount", "0");
		parameters.add("approval_url", approval_url);
		parameters.add("cancel_url", cancel_url);
		parameters.add("fail_url", fail_url);
		
		// Headers
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, getHeaders());
		
		// 외부API통신 (카카오페이 서버 API)
		RestTemplate template = new RestTemplate();
		ReadyResponse readyResponse = template.postForObject(url, requestEntity, ReadyResponse.class);
		
		return readyResponse;
	}
	
	/* 결제승인요청
	 * 기본정보
		POST /v1/payment/approve HTTP/1.1
		Host: kapi.kakao.com
		Authorization: KakaoAK ${APP_ADMIN_KEY}
		Content-type: application/x-www-form-urlencoded;charset=utf-8
	 */
	public ApproveResponse payApprove(String cid, String tid, long partner_order_id, String partner_user_id, String pg_token) {
		
		String url = "https://kapi.kakao.com/v1/payment/approve";
		
		// 요청에 보낼 파라미터(Body)
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("cid", cid);
		parameters.add("tid", tid);
		parameters.add("partner_order_id", String.valueOf(partner_order_id));
		parameters.add("partner_user_id", partner_user_id);
		parameters.add("pg_token", pg_token);
		
		// Headers
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, getHeaders());
		
		// 외부API통신 (카카오페이 서버 API)
		RestTemplate template = new RestTemplate();
		
		ApproveResponse approveResponse = template.postForObject(url, requestEntity, ApproveResponse.class);
		
		return approveResponse;
	}
	
	// 공통헤더정보
	public HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		
		headers.set("Authorization", "KakaoAK 697d5ccd3c3687f85b710a8def42eeb9");
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		return headers;
	}
}

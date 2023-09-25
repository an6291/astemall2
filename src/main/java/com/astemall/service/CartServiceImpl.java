package com.astemall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.domain.CartVO;
import com.astemall.dto.CartListDTO;
import com.astemall.mapper.CartMapper;

import lombok.Setter;

@Service
public class CartServiceImpl implements CartService {

	@Setter(onMethod_ = {@Autowired})
	private CartMapper cartMapper;

	@Override
	public int cart_add(CartVO vo) {
		// TODO Auto-generated method stub
		return cartMapper.cart_add(vo);
	}

	@Override
	public List<CartListDTO> cart_list(String mb_id) {
		// TODO Auto-generated method stub
		return cartMapper.cart_list(mb_id);
	}

	@Override
	public int cart_tot_price(String mb_id) {
		// TODO Auto-generated method stub
		return cartMapper.cart_tot_price(mb_id);
	}

	@Override
	public int cart_amount_change(Long cart_no, int cart_amount) {
		// TODO Auto-generated method stub
		return cartMapper.cart_amount_change(cart_no, cart_amount);
	}

	@Override
	public int cart_delete(Long cart_no) {
		// TODO Auto-generated method stub
		return cartMapper.cart_delete(cart_no);
	}

	@Override
	public void cart_empty(String mb_id) {
		// TODO Auto-generated method stub
		cartMapper.cart_empty(mb_id);
	}
	
}

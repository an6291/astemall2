package com.astemall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartListDTO {
	private	int		no;
	private Long	cart_no;
	private String	prd_up_folder;
	private String	prd_img;	
	private int		prd_no;
	private String	prd_name;
	private int		cart_amount;
	private	int		prd_price;
	private	int		unitprice;
	
}

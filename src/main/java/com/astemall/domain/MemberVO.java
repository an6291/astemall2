package com.astemall.domain;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	
	private String	mb_id;
	private	String	mb_pw;
	private String	mb_name;
	private	String	mb_zipcode;
	private	String	mb_addr;
	private	String	mb_addr_d;
	private	String	mb_phone;
	private	String	mb_email;
	private	String	mb_email_acpt;
	private	int		mb_point;
	private	Date	last_visit;
	private	Date	create_date;
	private	Date	update_date;

}

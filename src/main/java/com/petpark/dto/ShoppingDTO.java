package com.petpark.dto;

import lombok.Data;

@Data
public class ShoppingDTO {

	String shopping_id;
	String product_image;
	String product_name;
	String product_kind;
	int product_price;
	int product_count;
	boolean product_status;
	String product_content;
	String date;
	int count;
}

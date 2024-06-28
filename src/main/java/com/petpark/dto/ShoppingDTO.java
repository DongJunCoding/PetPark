package com.petpark.dto;

import lombok.Data;

@Data
public class ShoppingDTO {

	String shoppingId;
	String productImage;
	String productName;
	String productKind;
	int productPrice;
	int productCount;
	boolean productStatus;
	String productContent;
	String date;
	int count;
}

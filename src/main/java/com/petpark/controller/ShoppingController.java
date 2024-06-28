package com.petpark.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.dto.ShoppingDTO;
import com.petpark.service.ShoppingServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ShoppingController {
	
	@Autowired
	private ShoppingServiceImpl shoppingServiceImpl;
	
	@Value("spring.servlet.multipart.location")
	private String uploadDirectory;

	@GetMapping("/shoppingWrite.do")
	public ModelAndView shoppingView(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("shopping/shopping_write");
		return mv;
	}
	
	
	@PostMapping("/shoppingWrite.do")
	public String shoppingWriteOk(HttpServletRequest req, @RequestParam("product-image") MultipartFile upload) {
		
		String imageFile = "";
		String newFileName = "";
		
		if(!upload.isEmpty()) {			
			imageFile = upload.getOriginalFilename(); // imageFile에 업로드한 파일의 이름을 넣는다.
			String extension = imageFile.substring(imageFile.lastIndexOf(".")); // . 이후의 확장자 이름
			String filename = imageFile.substring(0, imageFile.lastIndexOf(".")); // 0번째부터 . 위치번째까지의 이름부분
			newFileName = filename + "-" + System.currentTimeMillis() + extension;
			
			try {
				upload.transferTo(new File(newFileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		String image = newFileName;
		String productName = req.getParameter("subject");
		String productKind = req.getParameter("category");
		String productPriceString = req.getParameter("product-price");
		String productCountString = req.getParameter("product-count");
		String statusString  = req.getParameter("status");
		String productContent = req.getParameter("content");
		
		int productPrice = 0;
		int productCount = 0;
		
		boolean status = false;
		
		if(!( productPriceString.equals("null") && productCountString.equals("null"))) {
			
			productPrice = Integer.parseInt(productPriceString);
			productCount = Integer.parseInt(productCountString);
			
		}
		
		if(statusString.equals("true")) {
			status = true;
		}
	
	
		int result = shoppingServiceImpl.insertProduct(image, productName, productKind, productPrice, productCount, status, productContent);
		
		System.out.println("result : " + result);
		
		return "redirect:/petpark.do#shopping";
	}
	
	
	@GetMapping("shoppingList.do")
	public ModelAndView shoppingList() {
		
		ArrayList<ShoppingDTO> shoppingList = new ArrayList<ShoppingDTO>();

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("shoppingList", shoppingList);
		mv.setViewName("main");
		return mv;
	}
	
	
}

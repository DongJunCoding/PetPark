package com.petpark.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.dto.ShoppingDTO;
import com.petpark.service.ShoppingServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ShoppingController {
	
	@Autowired
	private ShoppingServiceImpl shoppingServiceImpl;
	
	@Value("${spring.servlet.multipart.location}")
	private String uploadDirectory;
	
	@Value("${portOne-Store-ID}")
	private String storeId;
	
	@Value("${portOne-identification-code}")
	private String identificationCode;
	
	@Value("${portOne-V1-REST-API-KEY}")
	private String portOneAPIKEY;
	
	@Value("${portOne-V1-REST-API-Secret}")
	private String portOneSecretKey;

	@GetMapping("/shoppingWrite.do")
	public ModelAndView shoppingWrite(HttpServletRequest req) {
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
	
	
	@ResponseBody
	@GetMapping("/shoppingList.do")
	public Map<String, Object> shoppingList(HttpServletRequest req) {
		// 뉴스별 카테고리를 눌렀을 때 초기값 1페이지로 설정 ( AJAX로 받아올 때 이미 1을 받아오기는 한다. )
		int currentPage = 1;
		
		// AJAX의 data로 보낸 값(페이지 번호)을 받아온다.
		String currentPageStr = req.getParameter("currentPage");
		
		// 검색창에 입력한 데이터를 가져온다.
		String searchInput = req.getParameter("searchInput");
		
		// 카테고리별로 뉴스 데이터가 필요하여 카테고리를 가져옴
		String category = req.getParameter("category");
		
		
		// 뉴스 데이터 개수
		int shoppingSize = 0;
				
		// 페이지를 누르지 않았을 때 초기값이 null이여서 에러가 나기때문에 if문으로 처리, String이라서 문자열로 비교를 해야할 것 같지만 request로 받아온 것이라 비교연산자로 처리
		if(currentPageStr != null) {
			
			// AJAX로 받아온 현재 페이지 번호를 int형으로 변환 ( 페이지 번호 설정을 INT로 하였음 )
			currentPage = Integer.parseInt(currentPageStr);
			
		}

		// 뉴스 리스트 검색을 한다면
		if(searchInput != null) {			
			// 페이징 설정을 위해 해당 카테고리의 뉴스 데이터 size를 가져옴
			shoppingSize = shoppingServiceImpl.searchShoppingDataSize(category, searchInput);				
		} else if (searchInput == null){		
			// 페이징 설정을 위해 해당 카테고리의 뉴스 데이터 size를 가져옴
			shoppingSize = shoppingServiceImpl.shoppingDataSize(category);	
		}
		
		System.out.println("shoppingSize : " + shoppingSize);
		System.out.println();
				
		// 데이터들을 json형태로 받아오기 위해 Map 생성
		Map<String, Object> response = new HashMap<String, Object>();
		
		response = shoppingServiceImpl.postsPerPage(category, currentPage, shoppingSize, searchInput);

		return response;
	}
	
	
	@GetMapping("/shoppingView.do")
	public ModelAndView shoppingView(HttpServletRequest req) {
				
		String shoppingId = req.getParameter("shopping_id");
		
		ShoppingDTO shoppingView = shoppingServiceImpl.shoppingView(shoppingId);
				
		ModelAndView mv = new ModelAndView();	
		
		mv.addObject("shoppingView", shoppingView);
		mv.setViewName("shopping/shopping_view");
		return mv;
	}
	
	@ResponseBody
	@GetMapping("/price.do")
	public Map<String, Object> shoppingPrice(HttpServletRequest req) {
			
		String shoppingId = req.getParameter("shoppingId");
		String count = req.getParameter("count");
		
		Map<String, Object> response = new HashMap<>();
		
		if(shoppingId != null && count != null) {
			response = shoppingServiceImpl.selectPrice(shoppingId, count);
		}
		
		return response;
	}
	
	
	@GetMapping("/payment.do")
	public ModelAndView payment(HttpServletRequest req) {

		String storeId = this.storeId;
		String identificationCode = this.identificationCode;
		String portOneAPIKEY = this.portOneAPIKEY;
		String portOneSecretKey = this.portOneSecretKey;
		
		String shoppingId = req.getParameter("shoppingId");
		String productImage = req.getParameter("product-image");
		String productName = req.getParameter("select-product");
		String productCount = req.getParameter("select-product-count");
		String productPrice = req.getParameter("select-product-total-money");
			
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("storeId",storeId);
		mv.addObject("identificationCode",identificationCode);
		mv.addObject("portOneAPIKEY",portOneAPIKEY);
		mv.addObject("portOneSecretKey",portOneSecretKey);
		
		mv.addObject("shoppingId",shoppingId);
		mv.addObject("productImage",productImage);
		mv.addObject("productName",productName);
		mv.addObject("productCount",productCount);
		mv.addObject("productPrice",productPrice);
		
		mv.setViewName("shopping/payment");
		
		return mv;
	}
}

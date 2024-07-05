<%@page import="com.petpark.dto.ShoppingDTO"%>
<%@page import="com.petpark.dto.BoardDTO"%>
<%@page import="com.petpark.dto.PageDTO"%>
<%@page import="java.io.Console"%>
<%@page import="com.petpark.dto.CrawlingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
ArrayList<CrawlingDTO> recentNews = new ArrayList<CrawlingDTO>();
recentNews = (ArrayList<CrawlingDTO>)request.getAttribute("news");

ArrayList<BoardDTO> recentBoard = new ArrayList<BoardDTO>();
recentBoard = (ArrayList<BoardDTO>)request.getAttribute("boards");

String kakaoAPI_KEY = (String)request.getAttribute("kakaoAPI_KEY");

String id = "";
String subject = "";
String writer = "";
String date = "";
String image = "";
int viewCount = 0;

StringBuilder newsSB = new StringBuilder();

for(CrawlingDTO news : recentNews) {
	
	id = news.getNews_id();
	subject = news.getSubject();
	writer = news.getWriter();
	date = news.getDate();
	viewCount = news.getView_count();
	
	newsSB.append("<tr>");
	newsSB.append("<td>" + id + "</td>");
	newsSB.append("<td class='tit'>");
	newsSB.append("<a href='/newsView.do?news_id=" + id + "'>" + subject + "</a>");
	newsSB.append("</td>");
	newsSB.append("<td>" + writer + "</td>");
	newsSB.append("<td>" + date + "</td>");
	newsSB.append("<td>" + viewCount + "</td>");
	newsSB.append("<tr>");
	
}

StringBuilder boardSB = new StringBuilder();

for(BoardDTO board : recentBoard) {
	
	id = board.getBoard_id();
	subject = board.getSubject();
	writer = board.getWriter();
	date = board.getDate();
	viewCount = board.getView_count();
	
	boardSB.append("<tr>");
	boardSB.append("<td>" + id + "</td>");
	boardSB.append("<td class='tit'>");
	boardSB.append("<a href='/boardView.do?board_id=" + id + "'>" + subject + "</a>");
	boardSB.append("</td>");
	boardSB.append("<td>" + writer + "</td>");
	boardSB.append("<td>" + date + "</td>");
	boardSB.append("<td>" + viewCount + "</td>");
	boardSB.append("<tr>");
	
}

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PetPark</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>				   
    <link rel="stylesheet" href="setting/css/main.css">	
    
	<script type="text/javascript">
	
	/* ====================== 뉴스 & 소식 AJAX 시작 ====================== */
	
	// 페이징 + 페이지별 뉴스 데이터 가져오기 ( 카테고리별 )
	function page(pageNum, category, searchInput) {
		$.ajax({
			type:'GET', // 타입 ( GET, POST, PUT 등... )
			url:'/newsList.do', // 요청할 URL 서버
			async:true,	 // 비동기화 여부 ( default : true ) / true : 비동기 , false : 동기
			dataType:'json', // 데이터 타입 ( HTML, XML, JSON, TEXT 등 .. )
			data: { // 보낼 데이터 설정
				'currentPage' : pageNum,
				'category' : category,
				'searchInput' : searchInput
			},
			success: function(page) { // 결과 성공 콜백함수
				
				let postsPerPages = page.postsPerPage;
				
				let newsSB = new StringBuilder();
								
				postsPerPages.forEach(postsPerPage => {
	                newsSB.append("<tr>");
	                newsSB.append("<td>" + postsPerPage.news_id + "</td>");
	                newsSB.append("<td class='tit'>");
	                newsSB.append("<a href='/newsView.do?news_id=" + postsPerPage.news_id + "'><img class='board_list_image' src='" + postsPerPage.main_image + "'>" + postsPerPage.subject + "</a>");
	                newsSB.append("</td>");
	                newsSB.append("<td>" + postsPerPage.writer + "</td>");
	                newsSB.append("<td>" + postsPerPage.date + "</td>");
	                newsSB.append("<td>" + postsPerPage.view_count + "</td>");
	                newsSB.append("</tr>");
	            });
	            
				// 해당 페이지와 카테고리별 데이터를 가져온다.
	            document.getElementById(category + "TableBody").innerHTML = newsSB.toString();
	            				
				// 페이징
				let pagination = page.page;
				
				let pageSB = new StringBuilder();
				
				
				if(searchInput != null) {
					
					pageSB.append("<a href='#' class='bt' onclick='page("+1+",\""+category+"\",\"" + searchInput + "\")'>첫 페이지</a>");
	                
	                // 시작 페이지가 1보다 클 경우에는 이전 페이지가 실행이 되지만 그러지 않을 경우에는 반응하지 않게 설정
					if(pagination.startPage > 1) {	
						pageSB.append("<a href='#' class='bt' onclick='page("+(pagination.startPage - 5)+",\""+category+"\",\"" + searchInput + "\")'>이전 페이지</a>");
					} else {
	                	pageSB.append("<a href='#' class='bt disabled'>이전 페이지</a>");     
						
					}
	                
	                // 페이지가 5개씩 보이게 설정하였으며 시작페이지부터 끝페이지(5페이지)가 뜨도록 반복문을 통해 처리
					for(let i = pagination.startPage; i <= pagination.endPage; i++) {			
						
						// 매개변수로 받은 현재페이지번호(pageNum)와 i의 값이 같으면 class='num on'을 통해 현재 페이지 색깔 넣어줌  
	                    if(pageNum == i) {                    	
	                    	pageSB.append("<a href='#' class='num on'>" + i + "</a>");                    	
	                    } else { // 현재페이지가 아닌 번호에는 클릭시 카테고리와 페이지 번호를 page함수로 다시 전달하여 페이지 이동이 가능하도록 처리 
	                    	pageSB.append("<a href='#' class='num' onclick='page("+i+",\""+category+"\",\"" + searchInput + "\")'>" + i + "</a>");                                     	
	                    }   

					}
	                
	                // 끝페이지가 전체 페이지보다 작다면 다음 페이지 버튼이 작동하도록 처리 아닐경우 무반응
					if(pagination.endPage < pagination.totalPages) {					
	                	pageSB.append("<a href='#' class='bt' onclick='page("+(pagination.startPage + 5)+",\""+category+"\",\"" + searchInput + "\")'>다음 페이지</a>");
					} else {
						pageSB.append("<a href='#' class='bt disabled'>다음 페이지</a>");
					}
					
	                // 마지막 페이지로가기는 전체 페이지의 수를 넣어 마지막페이지로 가도록 처리 
	                pageSB.append("<a href='#' class='bt' onclick='page("+pagination.totalPages+",\""+category+"\",\"" + searchInput + "\")'>마지막 페이지</a>");
					
				} else {
					
	                pageSB.append("<a href='#' class='bt' onclick='page("+1+",\""+category+"\")'>첫 페이지</a>");
	                
	                // 시작 페이지가 1보다 클 경우에는 이전 페이지가 실행이 되지만 그러지 않을 경우에는 반응하지 않게 설정
					if(pagination.startPage > 1) {	
						pageSB.append("<a href='#' class='bt' onclick='page("+(pagination.startPage - 5)+",\""+category+"\")'>이전 페이지</a>");
					} else {
	                	pageSB.append("<a href='#' class='bt disabled'>이전 페이지</a>");     
						
					}
	                
	                // 페이지가 5개씩 보이게 설정하였으며 시작페이지부터 끝페이지(5페이지)가 뜨도록 반복문을 통해 처리
					for(let i = pagination.startPage; i <= pagination.endPage; i++) {			
						
						// 매개변수로 받은 현재페이지번호(pageNum)와 i의 값이 같으면 class='num on'을 통해 현재 페이지 색깔 넣어줌  
	                    if(pageNum == i) {                    	
	                    	pageSB.append("<a href='#' class='num on'>" + i + "</a>");                    	
	                    } else { // 현재페이지가 아닌 번호에는 클릭시 카테고리와 페이지 번호를 page함수로 다시 전달하여 페이지 이동이 가능하도록 처리 
	                    	pageSB.append("<a href='#' class='num' onclick='page("+i+",\""+category+"\")'>" + i + "</a>");                                     	
	                    }   
	
					}
	                
	                // 끝페이지가 전체 페이지보다 작다면 다음 페이지 버튼이 작동하도록 처리 아닐경우 무반응
					if(pagination.endPage < pagination.totalPages) {					
	                	pageSB.append("<a href='#' class='bt' onclick='page("+(pagination.startPage + 5)+",\""+category+"\")'>다음 페이지</a>");
					} else {
						pageSB.append("<a href='#' class='bt disabled'>다음 페이지</a>");
					}
					
	                // 마지막 페이지로가기는 전체 페이지의 수를 넣어 마지막페이지로 가도록 처리 
	                pageSB.append("<a href='#' class='bt' onclick='page("+pagination.totalPages+",\""+category+"\")'>마지막 페이지</a>");
                
				}
				
				document.getElementById(category + "Paging").innerHTML = pageSB.toString();
	            
				$("#"+ category +"_board-size").text('Total : '+pagination.totalPost).css('color','orange').css('float','right');

			},
			error: function(error) { // 결과 에러 콜백함수
				console.log("AJAX 요청 실패");
			}
		});
	}
	
	/* ====================== 뉴스 & 소식 AJAX 끝 ======================= */
	
	
	
	
	
	
	
	
	/* ====================== 커뮤니티 AJAX 시작 ====================== */
	
	// 페이징 + 페이지별 뉴스 데이터 가져오기 ( 카테고리별 )
	function boardPage(pageNum, category, searchInput) {
		$.ajax({
			type:'GET', // 타입 ( GET, POST, PUT 등... )
			url:'/boardList.do', // 요청할 URL 서버
			async:true,	 // 비동기화 여부 ( default : true ) / true : 비동기 , false : 동기
			dataType:'json', // 데이터 타입 ( HTML, XML, JSON, TEXT 등 .. )
			data: { // 보낼 데이터 설정
				'currentPage' : pageNum,
				'category' : category,
				'searchInput' : searchInput
			},
			success: function(page) { // 결과 성공 콜백함수
				
				let postsPerPages = page.postsPerPage;
				
				let boardSB = new StringBuilder();
								
				postsPerPages.forEach(postsPerPage => {
					boardSB.append("<tr>");
					boardSB.append("<td>" + postsPerPage.board_id + "</td>");
					boardSB.append("<td class='tit'>");
					boardSB.append("<a href='/boardView.do?board_id=" + postsPerPage.board_id + "'>" + postsPerPage.subject + "</a>");
					boardSB.append("</td>");
					boardSB.append("<td>" + postsPerPage.writer + "</td>");
					boardSB.append("<td>" + postsPerPage.date + "</td>");
					boardSB.append("<td>" + postsPerPage.view_count + "</td>");
					boardSB.append("</tr>");
	            });
	            
				// 해당 페이지와 카테고리별 데이터를 가져온다.
	            document.getElementById(category + "TableBody").innerHTML = boardSB.toString();
	            				
				// 페이징
				let pagination = page.page;
				
				let pageSB = new StringBuilder();
				
				
				if(searchInput != null) {
					
					pageSB.append("<a href='#' class='bt' onclick='boardPage("+1+",\""+category+"\",\"" + searchInput + "\")'>첫 페이지</a>");
	                
	                // 시작 페이지가 1보다 클 경우에는 이전 페이지가 실행이 되지만 그러지 않을 경우에는 반응하지 않게 설정
					if(pagination.startPage > 1) {	
						pageSB.append("<a href='#' class='bt' onclick='boardPage("+(pagination.startPage - 5)+",\""+category+"\",\"" + searchInput + "\")'>이전 페이지</a>");
					} else {
	                	pageSB.append("<a href='#' class='bt disabled'>이전 페이지</a>");     
						
					}
	                
	                // 페이지가 5개씩 보이게 설정하였으며 시작페이지부터 끝페이지(5페이지)가 뜨도록 반복문을 통해 처리
					for(let i = pagination.startPage; i <= pagination.endPage; i++) {			
						
						// 매개변수로 받은 현재페이지번호(pageNum)와 i의 값이 같으면 class='num on'을 통해 현재 페이지 색깔 넣어줌  
	                    if(pageNum == i) {                    	
	                    	pageSB.append("<a href='#' class='num on'>" + i + "</a>");                    	
	                    } else { // 현재페이지가 아닌 번호에는 클릭시 카테고리와 페이지 번호를 page함수로 다시 전달하여 페이지 이동이 가능하도록 처리 
	                    	pageSB.append("<a href='#' class='num' onclick='boardPage("+i+",\""+category+"\",\"" + searchInput + "\")'>" + i + "</a>");                                     	
	                    }   

					}
	                
	                // 끝페이지가 전체 페이지보다 작다면 다음 페이지 버튼이 작동하도록 처리 아닐경우 무반응
					if(pagination.endPage < pagination.totalPages) {					
	                	pageSB.append("<a href='#' class='bt' onclick='boardPage("+(pagination.startPage + 5)+",\""+category+"\",\"" + searchInput + "\")'>다음 페이지</a>");
					} else {
						pageSB.append("<a href='#' class='bt disabled'>다음 페이지</a>");
					}
					
	                // 마지막 페이지로가기는 전체 페이지의 수를 넣어 마지막페이지로 가도록 처리 
	                pageSB.append("<a href='#' class='bt' onclick='boardPage("+pagination.totalPages+",\""+category+"\",\"" + searchInput + "\")'>마지막 페이지</a>");
					
				} else {
					
	                pageSB.append("<a href='#' class='bt' onclick='boardPage("+1+",\""+category+"\")'>첫 페이지</a>");
	                
	                // 시작 페이지가 1보다 클 경우에는 이전 페이지가 실행이 되지만 그러지 않을 경우에는 반응하지 않게 설정
					if(pagination.startPage > 1) {	
						pageSB.append("<a href='#' class='bt' onclick='boardPage("+(pagination.startPage - 5)+",\""+category+"\")'>이전 페이지</a>");
					} else {
	                	pageSB.append("<a href='#' class='bt disabled'>이전 페이지</a>");     
						
					}
	                
	                // 페이지가 5개씩 보이게 설정하였으며 시작페이지부터 끝페이지(5페이지)가 뜨도록 반복문을 통해 처리
					for(let i = pagination.startPage; i <= pagination.endPage; i++) {			
						
						// 매개변수로 받은 현재페이지번호(pageNum)와 i의 값이 같으면 class='num on'을 통해 현재 페이지 색깔 넣어줌  
	                    if(pageNum == i) {                    	
	                    	pageSB.append("<a href='#' class='num on'>" + i + "</a>");                    	
	                    } else { // 현재페이지가 아닌 번호에는 클릭시 카테고리와 페이지 번호를 page함수로 다시 전달하여 페이지 이동이 가능하도록 처리 
	                    	pageSB.append("<a href='#' class='num' onclick='boardPage("+i+",\""+category+"\")'>" + i + "</a>");                                     	
	                    }   
	
					}
	                
	                // 끝페이지가 전체 페이지보다 작다면 다음 페이지 버튼이 작동하도록 처리 아닐경우 무반응
					if(pagination.endPage < pagination.totalPages) {					
	                	pageSB.append("<a href='#' class='bt' onclick='boardPage("+(pagination.startPage + 5)+",\""+category+"\")'>다음 페이지</a>");
					} else {
						pageSB.append("<a href='#' class='bt disabled'>다음 페이지</a>");
					}
					
	                // 마지막 페이지로가기는 전체 페이지의 수를 넣어 마지막페이지로 가도록 처리 
	                pageSB.append("<a href='#' class='bt' onclick='boardPage("+pagination.totalPages+",\""+category+"\")'>마지막 페이지</a>");
                
				}
				
				document.getElementById(category + "Paging").innerHTML = pageSB.toString();
	            
				$("#"+ category +"-size").text('Total : '+pagination.totalPost).css('color','orange').css('float','right');
				
			},
			error: function(error) { // 결과 에러 콜백함수
				console.log("AJAX 요청 실패");
			}
		});
	}
	
	/* ====================== 커뮤니티 AJAX 끝 ======================= */
	
	
	
	
	
	/* ====================== 쇼핑 AJAX 시작 ====================== */
	
	// 페이징 + 페이지별 뉴스 데이터 가져오기 ( 카테고리별 )
	function shoppingPage(pageNum, category, searchInput) {
		$.ajax({
			type:'GET', // 타입 ( GET, POST, PUT 등... )
			url:'/shoppingList.do', // 요청할 URL 서버
			async:true,	 // 비동기화 여부 ( default : true ) / true : 비동기 , false : 동기
			dataType:'json', // 데이터 타입 ( HTML, XML, JSON, TEXT 등 .. )
			data: { // 보낼 데이터 설정
				'currentPage' : pageNum,
				'category' : category,
				'searchInput' : searchInput
			},
			success: function(page) { // 결과 성공 콜백함수
							
				let postsPerPages = page.postsPerPage;
				
				let shoppingSB = new StringBuilder();
				
				postsPerPages.forEach(postsPerPage => {
					shoppingSB.append("<div class='shopping_item'>");
					
					shoppingSB.append("<table>");
					
					shoppingSB.append("<tr>");
					shoppingSB.append("<td>상품번호 : " + postsPerPage.shopping_id + "</td>");
					shoppingSB.append("</tr>");
					
					shoppingSB.append("<tr>");
					shoppingSB.append("<td>");
					shoppingSB.append("<a href='/shoppingView.do?shopping_id="+postsPerPage.shopping_id+"'>");					
					shoppingSB.append("<img class='shopping_list_image' src='setting/shopping_image/" + postsPerPage.product_image + "'>");
					shoppingSB.append("</a>");
					shoppingSB.append("</td>");
					shoppingSB.append("</tr>");
					
					shoppingSB.append("<tr>");
					shoppingSB.append("<td>상품명 : ");
					shoppingSB.append("<a href='/shoppingView.do?shopping_id="+postsPerPage.shopping_id+"'</a>" + postsPerPage.product_name);
					shoppingSB.append("</td>");
					shoppingSB.append("</tr>");
					
					shoppingSB.append("<tr>");
					shoppingSB.append("<td>가격 : " + postsPerPage.product_price + "</td>");
					shoppingSB.append("</tr>");	
					
					shoppingSB.append("<tr>");
					shoppingSB.append("<td>");
					if(postsPerPage.product_status === true) {
					shoppingSB.append("판매상태 : <strong>판매중 ("+postsPerPage.product_count+"개)</strong>");			
					} else if(postsPerPage.product_status === false) {
						shoppingSB.append("판매상태 : <strong>품절</strong>");		
					}
					shoppingSB.append("</td>");
					shoppingSB.append("</tr>");
					
					shoppingSB.append("</table>");	
					
					shoppingSB.append("</div>");			

	            });
	            
				// 해당 페이지와 카테고리별 데이터를 가져온다.
	            document.getElementById(category + "TableBody").innerHTML = shoppingSB.toString();
	            				
				// 페이징
				let pagination = page.page;
				
				let pageSB = new StringBuilder();
				
				
				if(searchInput != null) {
					
					pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+1+",\""+category+"\",\"" + searchInput + "\")'>첫 페이지</a>");
	                
	                // 시작 페이지가 1보다 클 경우에는 이전 페이지가 실행이 되지만 그러지 않을 경우에는 반응하지 않게 설정
					if(pagination.startPage > 1) {	
						pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+(pagination.startPage - 5)+",\""+category+"\",\"" + searchInput + "\")'>이전 페이지</a>");
					} else {
	                	pageSB.append("<a href='#' class='bt disabled'>이전 페이지</a>");     
						
					}
	                
	                // 페이지가 5개씩 보이게 설정하였으며 시작페이지부터 끝페이지(5페이지)가 뜨도록 반복문을 통해 처리
					for(let i = pagination.startPage; i <= pagination.endPage; i++) {			
						
						// 매개변수로 받은 현재페이지번호(pageNum)와 i의 값이 같으면 class='num on'을 통해 현재 페이지 색깔 넣어줌  
	                    if(pageNum == i) {                    	
	                    	pageSB.append("<a href='#' class='num on'>" + i + "</a>");                    	
	                    } else { // 현재페이지가 아닌 번호에는 클릭시 카테고리와 페이지 번호를 page함수로 다시 전달하여 페이지 이동이 가능하도록 처리 
	                    	pageSB.append("<a href='#' class='num' onclick='shoppingPage("+i+",\""+category+"\",\"" + searchInput + "\")'>" + i + "</a>");                                     	
	                    }   

					}
	                
	                // 끝페이지가 전체 페이지보다 작다면 다음 페이지 버튼이 작동하도록 처리 아닐경우 무반응
					if(pagination.endPage < pagination.totalPages) {					
	                	pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+(pagination.startPage + 5)+",\""+category+"\",\"" + searchInput + "\")'>다음 페이지</a>");
					} else {
						pageSB.append("<a href='#' class='bt disabled'>다음 페이지</a>");
					}
					
	                // 마지막 페이지로가기는 전체 페이지의 수를 넣어 마지막페이지로 가도록 처리 
	                pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+pagination.totalPages+",\""+category+"\",\"" + searchInput + "\")'>마지막 페이지</a>");
					
				} else {
					
	                pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+1+",\""+category+"\")'>첫 페이지</a>");
	                
	                // 시작 페이지가 1보다 클 경우에는 이전 페이지가 실행이 되지만 그러지 않을 경우에는 반응하지 않게 설정
					if(pagination.startPage > 1) {	
						pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+(pagination.startPage - 5)+",\""+category+"\")'>이전 페이지</a>");
					} else {
	                	pageSB.append("<a href='#' class='bt disabled'>이전 페이지</a>");     
						
					}
	                
	                // 페이지가 5개씩 보이게 설정하였으며 시작페이지부터 끝페이지(5페이지)가 뜨도록 반복문을 통해 처리
					for(let i = pagination.startPage; i <= pagination.endPage; i++) {			
						
						// 매개변수로 받은 현재페이지번호(pageNum)와 i의 값이 같으면 class='num on'을 통해 현재 페이지 색깔 넣어줌  
	                    if(pageNum == i) {                    	
	                    	pageSB.append("<a href='#' class='num on'>" + i + "</a>");                    	
	                    } else { // 현재페이지가 아닌 번호에는 클릭시 카테고리와 페이지 번호를 page함수로 다시 전달하여 페이지 이동이 가능하도록 처리 
	                    	pageSB.append("<a href='#' class='num' onclick='shoppingPage("+i+",\""+category+"\")'>" + i + "</a>");                                     	
	                    }   
	
					}
	                
	                // 끝페이지가 전체 페이지보다 작다면 다음 페이지 버튼이 작동하도록 처리 아닐경우 무반응
					if(pagination.endPage < pagination.totalPages) {					
	                	pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+(pagination.startPage + 5)+",\""+category+"\")'>다음 페이지</a>");
					} else {
						pageSB.append("<a href='#' class='bt disabled'>다음 페이지</a>");
					}
					
	                // 마지막 페이지로가기는 전체 페이지의 수를 넣어 마지막페이지로 가도록 처리 
	                pageSB.append("<a href='#' class='bt' onclick='shoppingPage("+pagination.totalPages+",\""+category+"\")'>마지막 페이지</a>");
                
				}
				
				document.getElementById(category + "Paging").innerHTML = pageSB.toString();

				
			},
			error: function(error) { // 결과 에러 콜백함수
				console.log("AJAX 요청 실패");
			}
		});
	}
	
	/* ====================== 쇼핑 AJAX 끝 ======================= */
		
	// StringBuilder 유틸리티
	class StringBuilder {
	    constructor() {
	        this._stringArray = [];
	    }

	    append(string) {
	        this._stringArray.push(string);
	    }

	    toString() {
	        return this._stringArray.join("");
	    }
	}
	
	
	// 검색한 데이터
	function search(pageNum, category) {
		if(category === 'industry' || category === 'policy' || category === 'culture' || category === 'society' || category === 'veterinary_field' || category === 'welfare') {
			let searchInput = document.getElementById(category + "-input").value;
			page(pageNum, category, searchInput);
		} else if (category === 'all_board' || category === 'free_board' || category === 'share_board' || category === 'qna_board' || category === 'notice_board') {
			let searchInput = document.getElementById(category + "-input").value;
			boardPage(pageNum, category, searchInput);
		} else if (category === 'all_product' || category === 'food' || category === 'snack' || category === 'toy' || category === 'clothes' || category === 'furniture') {
			let searchInput = document.getElementById(category + "-input").value;
			shoppingPage(pageNum, category, searchInput);
		} 
	}
	
	
	// 검색창에 검색어 입력 후 엔터를 눌렀을 때 새로고침 방지
    function handleKeyDown(event, category) {
        if (event.key === "Enter") { // 엔터 키를 눌렀을 때
            event.preventDefault(); // 폼의 기본 동작인 페이지 새로고침을 막습니다.
            search(1, category); // 검색 함수를 호출합니다.
        }
    }
	
	
    function changeHash(tabId) {
        window.location.hash = tabId; // URL의 해시(#)를 클릭한 탭의 ID로 변경
    }
    
    window.onload = function() {
        // 페이지 로드 시 URL 해시(#) 확인하여 해당 탭 활성화
        var hash = window.location.hash;
        if (hash) {
            // URL에 해시(#)가 있는 경우
            // 해당 탭 활성화
            $('.nav-tabs a[href="' + hash + '"]').tab('show');

            // 해당 탭의 내용 보이기
            $(hash).addClass('active');
        } else {
            // URL에 해시(#)가 없는 경우
            // 기본 탭 활성화
            $('.nav-tabs a:first').tab('show');

            // 기본 탭의 내용 보이기
            $('#all_board').addClass('active');
        }
    };

    // 탭 클릭 시 처리
    $('.nav-tabs a').on('click', function (e) {
        e.preventDefault();
        var tabId = $(this).attr('href');

        // 다른 탭 내용 숨기기
        $('.tab-pane').removeClass('active');

        // 클릭한 탭 내용 보이기
        $(tabId).addClass('active');

        // URL 업데이트
        history.pushState(null, null, tabId);
    });

	</script>
	
</head>
<body>
    <!-- header 영역 -->
    <header>
        <div class="container">
            <img src="setting/image/logo.png" alt="이미지 준비중" class="mainimage">   
            <div>
                <a href="login.do">
                    <img src="setting/image/loginimage.png" class="loginimage">
                    <strong class="logintext">Login</strong>
                </a>
            </div>       
        </div> 
    </header>

    <!-- main 영역 -->
    <main>
        <div class="container mt-3">
            <br>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="#home" onclick="changeHash('home')">홈</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#news" onclick="changeHash('news')">뉴스 & 소식</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#board" onclick="changeHash('board')">커뮤니티</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#location" onclick="changeHash('location')">병원 & 용품점</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#shopping" onclick="changeHash('shopping')">쇼핑</a>
                </li>
            </ul>
            
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="home" class="container tab-pane active"><br>     
                    <!-- Carousel -->
                    <div id="demo" class="carousel slide" data-bs-ride="carousel">
                        
                        <!-- Indicators/dots -->
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
                            <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
                            <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
                        </div>
                        
                        <!-- The slideshow/carousel -->
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="setting/image/코코1.jpg" alt="Los Angeles" class="d-block" style="width:100%">
                            </div>
                            <div class="carousel-item">
                                <img src="setting/image/코코2.jpg" alt="Chicago" class="d-block" style="width:100%">
                            </div>
                            <div class="carousel-item">
                                <img src="setting/image/코코3.jpg" alt="New York" class="d-block" style="width:100%">
                            </div>
                        </div>
                        
                        <!-- Left and right controls/icons -->
                        <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </button>
                    </div>
                    
                    <br><br>

                    <!-- 중간을 나눠서 양쪽 여백에 news와 커뮤니티 Top10 리스트 설정 -->
                    <div class="d-flex mt-3">
                        <div class="left-text flex-grow-1 text-end">
                            <h5 class="topboard">뉴스 & 소식</h5>
                            <div class="board_list_wrap">
                                <table class="board_list">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th class="board_subject">제목</th>
                                            <th>글쓴이</th>
                                            <th>작성일</th>
                                            <th>조회</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%=newsSB %>                            
                                    </tbody>
                                </table>
                            </div> 
                        </div>
                        <div class="right-text flex-grow-1">
                            <h5 class="topboard">커뮤니티</h5>
                            <div class="board_list_wrap">
                                <table class="board_list">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th class="board_subject">제목</th>
                                            <th>글쓴이</th>
                                            <th>작성일</th>
                                            <th>조회</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<%=boardSB %>                                      
                                    </tbody>
                                </table>
                            </div> 
                        </div>
                    </div>
                    <p id="hometext">더 많은 정보를 원하시면 상단의 탭을 이용해주세요 !</p>
                </div>

                <!-- 뉴스 & 소식 탭 -->
                <div id="news" class="container tab-pane fade"><br>   
                    <ul class="nav" role="tablist">
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#industry" onclick="page(1, 'industry')">산업</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#policy" onclick="page(1, 'policy')">정책</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#society" onclick="page(1, 'society')">사회</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#culture" onclick="page(1, 'culture')">문화</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#welfare" onclick="page(1, 'welfare')">동물복지</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#veterinary_field" onclick="page(1, 'veterinary_field')">수의계</a>
                        </li>
                    </ul>    

                    <div id="industry" class="container tab-pane fade"><br>
						<form>
	                        <img src="setting/image/logo.png" class="searchlogo">
	                        <div class="search">
								<input class="searchinput" type="text" id="industry-input" placeholder="검색" onkeydown="handleKeyDown(event, 'industry')">
        						<img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'industry')">
	                        </div>
                        </form>

                        <div class="board_list_wrap">
                        	<strong class="category-name">산업</strong>
                        	<span id="industry_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="industryTableBody">
                            
                                </tbody>
                            </table>
                            <div class="paging" id="industryPaging">

                            </div>
                        </div>                  
                    </div>
                
                    <div id="policy" class="container tab-pane fade"><br>
                        <form>
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="policy-input" placeholder="검색" onkeydown="handleKeyDown(event, 'policy')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'policy')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">정책</strong>
                        	<span id="policy_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="policyTableBody">
                            
                                </tbody>
                            </table>
                            <div class="paging" id="policyPaging">

                            </div>
                        </div>                  
                    </div>

                    <div id="society" class="container tab-pane fade"><br>
                        <form>
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="society-input" placeholder="검색" onkeydown="handleKeyDown(event, 'society')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'society')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">사회</strong>
                        	<span id="society_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="societyTableBody">
                           
                                </tbody>
                            </table>
                            <div class="paging" id="societyPaging">

                            </div>
                        </div>
                    </div>

                    <div id="culture" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="culture-input" placeholder="검색" onkeydown="handleKeyDown(event, 'culture')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'culture')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">문화</strong>
                        	<span id="culture_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="cultureTableBody">
                            
                                </tbody>
                            </table>
                            <div class="paging" id="culturePaging">

                            </div>
                        </div>
                    </div>

                    <div id="welfare" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="welfare-input" placeholder="검색" onkeydown="handleKeyDown(event, 'welfare')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'welfare')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">동물복지</strong>
                        	<span id="welfare_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="welfareTableBody">
                            
                                </tbody>
                            </table>
                            <div class="paging" id="welfarePaging">

                            </div>
                        </div>
                    </div>

                    <div id="veterinary_field" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="veterinary_field-input" placeholder="검색" onkeydown="handleKeyDown(event, 'veterinary_field')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'veterinary_field')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">수의계</strong>
                        	<span id="veterinary_field_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="veterinary_fieldTableBody"> 
                                                         
                                </tbody>
                            </table>
                            <div class="paging" id="veterinary_fieldPaging">

                            </div>
                        </div>
                    </div>
                </div>

                <div id="board" class="container tab-pane fade"><br>
					<ul class="nav" role="tablist">
					    <li class="nav-item">
					        <a class="board-nav-link" data-bs-toggle="tab" href="#all_board" onclick="boardPage(1, 'all_board')">전체</a>
					    </li>
					    <li class="nav-item">
					        <a class="board-nav-link" data-bs-toggle="tab" href="#free_board" onclick="boardPage(1, 'free_board')">자유게시판</a>
					    </li>
					    <li class="nav-item">
					        <a class="board-nav-link" data-bs-toggle="tab" href="#share_board" onclick="boardPage(1, 'share_board')">나눔</a>
					    </li>
					    <li class="nav-item">
					        <a class="board-nav-link" data-bs-toggle="tab" href="#qna_board" onclick="boardPage(1, 'qna_board')">Q & A</a>
					    </li>
					    <li class="nav-item">
					        <a class="board-nav-link" data-bs-toggle="tab" href="#notice_board" onclick="boardPage(1, 'notice_board')">공지</a>
					    </li>
					</ul>  
					
                    <div id="all_board" class="container tab-pane fade"><br>
                        <form>
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="all_board-input" placeholder="검색" onkeydown="handleKeyDown(event, 'all_board')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'all_board')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">전체</strong>
                        	<span id="all_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="all_boardTableBody">

                                </tbody>
                            </table>
                            <a href="/boardWrite.do" class="button-write">글쓰기</a>
                            <div class="paging" id="all_boardPaging">

                            </div>
                        </div> 
                    </div>

                    <div id="free_board" class="container tab-pane fade"><br>
                        <form>
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="free_board-input" placeholder="검색" onkeydown="handleKeyDown(event, 'free_board')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'free_board')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">자유게시판</strong>
                        	<span id="free_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="free_boardTableBody">
                             
                                </tbody>
                            </table>
                            <a href="/boardWrite.do" class="button-write">글쓰기</a>
                            <div class="paging" id="free_boardPaging">

                            </div>
                        </div> 
                    </div>

                    <div id="share_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="share_board-input" placeholder="검색" onkeydown="handleKeyDown(event, 'share_board')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'share_board')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">나눔게시판</strong>
                        	<span id="share_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="share_boardTableBody">
                           
                                </tbody>
                            </table>
                            <a href="/boardWrite.do" class="button-write">글쓰기</a>
                            <div class="paging" id="share_boardPaging">

                            </div>
                        </div> 
                    </div>

                    <div id="qna_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="qna_board-input" placeholder="검색" onkeydown="handleKeyDown(event, 'qna_board')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'qna_board')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">Q&A게시판</strong>
                        	<span id="qna_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="qna_boardTableBody">
                          
                                </tbody>
                            </table>
                            <a href="/boardWrite.do" class="button-write">글쓰기</a>
                            <div class="paging" id="qna_boardPaging">

                            </div>
                        </div> 
                    </div>

                    <div id="notice_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
	                            <input class="searchinput" type="text" id="notice_board-input" placeholder="검색" onkeydown="handleKeyDown(event, 'notice_board')"/>
	                            <img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'notice_board')">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        	<strong class="category-name">공지사항</strong>
                        	<span id="notice_board-size"></span>
                            <table class="board_list">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th class="board_subject">제목</th>
                                        <th>글쓴이</th>
                                        <th>작성일</th>
                                        <th>조회</th>
                                    </tr>
                                </thead>
                                <tbody id="notice_boardTableBody">
                           
                                </tbody>
                            </table>
                            <a href="/boardWrite.do" class="button-write">글쓰기</a>
                            <div class="paging" id="notice_boardPaging">

                            </div>
                        </div> 
                    </div>
                </div>

                
                <!-- 동물병원 & 용품점 메뉴 -->
				<div id="location" class="container tab-pane fade"><br>
				    <h4 id="kakaoMap-search">원하는 키워드를 입력해주세요 !</h4>
				    <p>EX : 서울시 동물병원(행정구역명 + 장소) </p>
				    <strong>자세한 지역명을 적어주시면 더욱 자세한 정보를 제공해드릴 수 있습니다.</strong>
				    <div class="map_wrap">
				        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				    
				        <div id="menu_wrap" class="bg_white">
				            <div class="option">
				                <div>
				                    <form onsubmit="searchPlaces(); return false;">
				                        키워드 : <input type="text" value="서울시 동물병원" id="keyword" size="15"> 
				                        <button type="submit">검색하기</button> 
				                    </form>
				                </div>
				            </div>
				            <hr>
				            <ul id="placesList"></ul>
				            <div id="pagination"></div>
				        </div>
				    </div>
				</div>
				
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=848e8a4d23c8f6c19bca8a25d7d5f9e0&libraries=services"></script>
				<script>
				let mapContainer = document.getElementById('map'); // 지도를 표시할 div 
				let mapOption = {
				    center: new kakao.maps.LatLng(36.350412, 127.384548), // 지도의 중심좌표
				    level: 3 // 지도의 확대 레벨
				};  
				let map;
				let ps;
				let infowindow;
				let markers = [];
				
				function initMap() {
				    map = new kakao.maps.Map(mapContainer, mapOption);
				    ps = new kakao.maps.services.Places();  
				    infowindow = new kakao.maps.InfoWindow({zIndex:1});
				}
				
				// 키워드 검색을 요청하는 함수입니다
				function searchPlaces() {
				    let keyword = document.getElementById('keyword').value;
				
				    if (!keyword.replace(/^\s+|\s+$/g, '')) {
				        alert('키워드를 입력해주세요!');
				        return false;
				    }
				
				    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
				    ps.keywordSearch(keyword, placesSearchCB); 
				}
				
				// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
				function placesSearchCB(data, status, pagination) {
				    if (status === kakao.maps.services.Status.OK) {
				        // 정상적으로 검색이 완료됐으면
				        // 검색 목록과 마커를 표출합니다
				        displayPlaces(data);
				
				        // 페이지 번호를 표출합니다
				        displayPagination(pagination);
				    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
				        alert('검색 결과가 존재하지 않습니다.');
				        return;
				    } else if (status === kakao.maps.services.Status.ERROR) {
				        alert('검색 결과 중 오류가 발생했습니다.');
				        return;
				    }
				}
				
				// 검색 결과 목록과 마커를 표출하는 함수입니다
				function displayPlaces(places) {
				    let listEl = document.getElementById('placesList'), 
				    menuEl = document.getElementById('menu_wrap'),
				    fragment = document.createDocumentFragment(), 
				    bounds = new kakao.maps.LatLngBounds();
				
				    // 검색 결과 목록에 추가된 항목들을 제거합니다
				    removeAllChildNods(listEl);
				
				    // 지도에 표시되고 있는 마커를 제거합니다
				    removeMarker();
				    
				    for (let i=0; i<places.length; i++ ) {
				        // 마커를 생성하고 지도에 표시합니다
				        let placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
				            marker = addMarker(placePosition, i), 
				            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
				
				        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				        // LatLngBounds 객체에 좌표를 추가합니다
				        bounds.extend(placePosition);
				
				        // 마커와 검색결과 항목에 mouseover 했을때
				        // 해당 장소에 인포윈도우에 장소명을 표시합니다
				        // mouseout 했을 때는 인포윈도우를 닫습니다
				        (function(marker, title) {
				            kakao.maps.event.addListener(marker, 'mouseover', function() {
				                displayInfowindow(marker, title);
				            });
				
				            kakao.maps.event.addListener(marker, 'mouseout', function() {
				                infowindow.close();
				            });
				
				            itemEl.onmouseover =  function () {
				                displayInfowindow(marker, title);
				            };
				
				            itemEl.onmouseout =  function () {
				                infowindow.close();
				            };
				        })(marker, places[i].place_name);
				
				        fragment.appendChild(itemEl);
				    }
				
				    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
				    listEl.appendChild(fragment);
				    menuEl.scrollTop = 0;
				
				    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				    map.setBounds(bounds);
				}
				
				// 검색결과 항목을 Element로 반환하는 함수입니다
				function getListItem(index, places) {
				    let el = document.createElement('li'),
				    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
				                '<div class="info">' +
				                '   <h5>' + places.place_name + '</h5>';
				
				    if (places.road_address_name) {
				        itemStr += '    <span>' + places.road_address_name + '</span>' +
				                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
				    } else {
				        itemStr += '    <span>' +  places.address_name  + '</span>'; 
				    }
				                 
				      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
				                '</div>';           
				
				    el.innerHTML = itemStr;
				    el.className = 'item';
				
				    return el;
				}
				
				// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
				function addMarker(position, idx, title) {
				    let imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
				        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
				        imgOptions =  {
				            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
				        },
				        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
				        marker = new kakao.maps.Marker({
				        position: position, // 마커의 위치
				        image: markerImage 
				    });
				
				    marker.setMap(map); // 지도 위에 마커를 표출합니다
				    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
				
				    return marker;
				}
				
				// 지도 위에 표시되고 있는 마커를 모두 제거합니다
				function removeMarker() {
				    for (let i = 0; i < markers.length; i++ ) {
				        markers[i].setMap(null);
				    }   
				    markers = [];
				}
				
				// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
				function displayPagination(pagination) {
				    let paginationEl = document.getElementById('pagination'),
				        fragment = document.createDocumentFragment(),
				        i; 
				
				    // 기존에 추가된 페이지번호를 삭제합니다
				    while (paginationEl.hasChildNodes()) {
				        paginationEl.removeChild (paginationEl.lastChild);
				    }
				
				    for (i=1; i<=pagination.last; i++) {
				        let el = document.createElement('a');
				        el.href = "#";
				        el.innerHTML = i;
				
				        if (i===pagination.current) {
				            el.className = 'on';
				        } else {
				            el.onclick = (function(i) {
				                return function() {
				                    pagination.gotoPage(i);
				                }
				            })(i);
				        }
				
				        fragment.appendChild(el);
				    }
				    paginationEl.appendChild(fragment);
				}
				
				// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
				// 인포윈도우에 장소명을 표시합니다
				function displayInfowindow(marker, title) {
				    let content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
				
				    infowindow.setContent(content);
				    infowindow.open(map, marker);
				}
				
				// 검색결과 목록의 자식 Element를 제거하는 함수입니다
				function removeAllChildNods(el) {   
				    while (el.hasChildNodes()) {
				        el.removeChild (el.lastChild);
				    }
				}
				
				// 탭 클릭 이벤트 설정
				document.querySelectorAll('[data-bs-toggle="tab"]').forEach(tab => {
				    tab.addEventListener('shown.bs.tab', function (e) {
				        if (e.target.getAttribute('href') === '#location') {
				            setTimeout(() => {
				                initMap(); // 지도 초기화
				            }, 300);
				        }
				    });
				});
				
				window.onload = function() {
				    initMap(); // 페이지 로드 시 지도 초기화
				};
				</script>
   
                <div id="shopping" class="container tab-pane fade"><br>
                    <ul class="nav" role="tablist">
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#all_shopping" onclick="shoppingPage(1, 'all_product')">전체</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#food_shopping" onclick="shoppingPage(1, 'food')">밥</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#snack_shopping" onclick="shoppingPage(1, 'snack')">간식</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#toy_shopping" onclick="shoppingPage(1, 'toy')">장난감</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#clothes_shopping" onclick="shoppingPage(1, 'clothes')">의류</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#furniture_shopping" onclick="shoppingPage(1, 'furniture')">가구</a>
                        </li>
                    </ul> 

					<div id="all_shopping" class="container tab-pane fade"><br>
					    <form action="#" method="post">
					        <img src="setting/image/logo.png" class="searchlogo">
					        <div class="search">
					            <input class="searchinput" type="text" placeholder="검색" id="all_product-input" onkeydown="handleKeyDown(event, 'all_product')">
					            <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1,'all_product')">
					        </div>
					    </form>
					
						<div class="shopping_list_table" id="all_productTableBody">

			            </div>
			            
			            <div class="board_list_wrap">
		                    <div class="paging" id="all_productPaging">
		
		                    </div>   
                        </div>			
					</div>
				
                    <div id="food_shopping" class="container tab-pane fade"><br>                     
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" id="food-input" onkeydown="handleKeyDown(event, 'food')"/>
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1, 'food')">
                            </div>
                        </form>
						<div class="shopping_list_table" id="foodTableBody">

			            </div>
			            
			            <div class="board_list_wrap">
		                    <div class="paging" id="foodPaging">
		
		                    </div>   
                        </div>
                    </div>

                    <div id="snack_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" id="snack-input" onkeydown="handleKeyDown(event, 'snack')"/>
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1, 'snack')">
                            </div>
                        </form>
                        
                        <div class="shopping_list_table" id="snackTableBody">

			            </div>
			            
			            <div class="board_list_wrap">
		                    <div class="paging" id="snackPaging">
		
		                    </div>   
                        </div>
                    </div>

                    <div id="toy_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" id="toy-input" onkeydown="handleKeyDown(event, 'toy')"/>
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1, 'toy')">
                            </div>
                        </form>
                        <div class="shopping_list_table" id="toyTableBody">

			            </div>
			            
			            <div class="board_list_wrap">
		                    <div class="paging" id="toyPaging">
		
		                    </div>   
                        </div>
                    </div>

                    <div id="clothes_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" id="clothes-input" onkeydown="handleKeyDown(event, 'clothes')"/>
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1, 'clothes')">
                            </div>
                        </form>
                        <div class="shopping_list_table" id="clothesTableBody">

			            </div>
			            
			            <div class="board_list_wrap">
		                    <div class="paging" id="clothesPaging">
		
		                    </div>   
                        </div>
                    </div>

                    <div id="furniture_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" id="furniture-input" onkeydown="handleKeyDown(event, 'furniture')"/>
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" onclick="search(1, 'furniture')">
                            </div>
                        </form>
                        <div class="shopping_list_table" id="furnitureTableBody">

			            </div>
			            
			            <div class="board_list_wrap">
		                    <div class="paging" id="furniturePaging">
		
		                    </div>   
                        </div>
                    </div>
                </div>    
            </div>  
        </div>
    </main>

    <!-- footer 영역 -->
    <footer>
        <div class="container">
            <hr>
            <div class="row">
                <div class="col-sm-12 col-md-6">
                    <h6>About</h6>
                    <p class="text-justify">PetPark는 반려인들의 모임터로 다양한 소식과 서로간의 정보 공유를 통해 많은 정보를 얻어가며 반려동물과 반려인의
                        생활의 질을 향상시킬 수 있도록 노력하는 웹 사이트 입니다 !
                    </p>
                </div>
    
                <div class="col-xs-6 col-md-3">
                    <h6>Developer</h6>
                    <ul class="footer-links">
                        이동준 ( ehdwns977@gmail.com )
                    </ul>
                    <p>문의사항은 이메일로 부탁드립니다.</p>
                </div>
    
            </div>
            <hr>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-sm-6 col-xs-12">
                        <p class="copyright-text">Copyright &copy; 2017 All Rights Reserved by 
                            <a href="#">Scanfcode</a>.
                        </p>
                    </div>        
                </div>
            </div>
    </footer>
</body>
</html>
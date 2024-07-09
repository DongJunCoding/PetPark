<%@page import="com.petpark.dto.ShoppingDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	ShoppingDTO shoppingView = (ShoppingDTO)request.getAttribute("shoppingView");
	
	String shoppingId = shoppingView.getShopping_id();
	String category = shoppingView.getProduct_kind();
	String image = shoppingView.getProduct_image();
	String subject = shoppingView.getProduct_name();
	int price = shoppingView.getProduct_price();
	int productCount = shoppingView.getProduct_count();
	boolean status = shoppingView.isProduct_status();
	String content = shoppingView.getProduct_content();
	String date = shoppingView.getDate();
	int count = shoppingView.getCount();
	
	/*
	ArrayList<CommentDTO> boardComments = (ArrayList<CommentDTO>)request.getAttribute("boardComment");
	
	String commentId = "";
	String boardNo = "";
	String commentWriter = "";
	String commentContent = "";
	String commentDate = "";
	
	StringBuilder commentSB = new StringBuilder();
	
	if(boardComments != null) {
				
		for(CommentDTO boardComment : boardComments) {
			
			commentId = boardComment.getComment_id();
			boardNo = boardComment.getBoard_no();
			commentWriter = boardComment.getWriter();
			commentContent = boardComment.getContent();
			commentDate = boardComment.getDate();
			
			commentSB.append("<span class='author'>" + commentWriter + "</span>");
			commentSB.append("&nbsp;&nbsp;&nbsp;&nbsp;");
			commentSB.append("<span>"+commentDate+"</span>");
			commentSB.append("<p>" + commentContent + "</p>");
			commentSB.append("<div class='actions'>");
			commentSB.append("<a class='edit-btn' onclick='commentModify("+commentId+")'>수정</a> | <a href='/deleteComment.do?comment_id=" + commentId +"&board_no="+boardNo+"' class='delete-btn'>삭제</a>");
			commentSB.append("</div>");
			commentSB.append("<span class='reply-btn' onclick='commentReply("+commentId+")'>답글달기</span>");
			commentSB.append("<br>");
			
			// 답글 달기창(미완)
			commentSB.append("<div id='editForm_"+commentId+"' class='reply-form' style='display: none;'>");
			commentSB.append("<textarea class='reply-input' placeholder='답글 내용을 입력하세요'></textarea><br>");
			commentSB.append("<button class='reply-submit'>답글 작성</button>");
			commentSB.append("</div>");
			
			// 댓글 수정창
			commentSB.append("<div id='commentModify_"+commentId+"' style='display: none;'>");			
			commentSB.append("<form action='modifyComment.do' method='POST'>");
			commentSB.append("<input type='hidden' name='board-no' value='"+boardId+"' />");
			commentSB.append("<input type='hidden' name='comment-id' value='"+commentId+"' />");
			commentSB.append("<div class='form-inline mb-2'>");
			commentSB.append("<input type='text' name='comment-writer' id='replyId' value='댓글닉네임' readonly>"); // 로그인 구현시 수정
			commentSB.append("<label for='replyPassword' class='ml-4'><i class='fa fa-unlock-alt fa-2x'></i></label>");
			commentSB.append("</div>");
			commentSB.append("<textarea class='form-control' name='comment-content' id='exampleFormControlTextarea1' rows='3'>"+commentContent+"</textarea>");
			commentSB.append("<button type='submit' class='btn btn-dark mt-3' id='comment-btn'>댓글 수정</button>");
			commentSB.append("</form>");		
			commentSB.append("</div>");
			
			commentSB.append("<hr>");
		}		
	}	
	*/
	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PetPark</title> 
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <link rel="stylesheet" href="setting/css/board_view.css">
    <link rel="stylesheet" href="setting/css/summernote.css">
    
    <!--  
    <script>
		function commentReply(commentId) {
		   let editForm = document.getElementById('editForm_' + commentId);
		   console.log(editForm);
		   editForm.style.display = (editForm.style.display === 'none') ? 'block' : 'none';
		}
		
		function commentModify(commentId) {
			let editForm = document.getElementById('commentModify_' + commentId);
			console.log(editForm);
			editForm.style.display = (editForm.style.display === 'none') ? 'block' : 'none';
		}
			
	</script>  
	-->
	
	<script>
	
	    function validateAndSendPrice(input) {
	        let value = parseInt(input.value, 10);
	        if (isNaN(value) || value < 0) {
	            value = 0; // 유효하지 않은 값인 경우 기본값을 0으로 설정
	            input.value = 0;
	        } else if (value > 999) {
	            value = 999; // 값을 최대값으로 제한
	            input.value = 999;
	        }
	        price(value);
	    }	
	
		let shoppingId = '<%=shoppingId%>';
		function price( count) {
			$.ajax({
				type:'GET', // 타입 ( GET, POST, PUT 등... )
				url:'/price.do', // 요청할 URL 서버
				async:true,	 // 비동기화 여부 ( default : true ) / true : 비동기 , false : 동기
				dataType:'json', // 데이터 타입 ( HTML, XML, JSON, TEXT 등 .. )
				data: { // 보낼 데이터 설정
					'shoppingId' : shoppingId,
					'count' : count
				},
				success: function(response) {
					console.log(response.price);
					let formattedPrice = Number(response.price).toLocaleString();
					$('#money').text(formattedPrice);
				},
				error: function(error) {
					console.log(error);
				}
			});		
		}
	</script>
</head>

<body>
    <!-- header 영역 -->
    <header>
        <div class="container">
            <img src="setting/image/logo.png" alt="이미지 준비중" class="mainimage">       
        </div> 
    </header>
    
    <!-- main 영역 -->
    <main>
	    <div class="board_view_div">
	    	<div class="board_view_top">
		        <h1><%=subject %></h1>
		        <br>
		        <p id="board_view_p_date"><%=date %></p>
		        
		        <%if(category.equals("food")) {  %>
		        <strong>밥</strong>
		        <%} else if(category.equals("snack")) {%>
		        <strong>간식</strong>
		        <%} else if(category.equals("toy")) {%>
		        <strong>장난감</strong>
		        <%} else if(category.equals("clothes")) {%>
		        <strong>의류</strong>
		      	<%} else if(category.equals("furniture")) {%>
		        <strong>가구</strong>
		        <%}%>
		        
	        </div>
	    	<div class="board_content">
		        <hr>
				<!-- 실제 게시글 내용 -->
		        <div class="d-flex mt-3">
	            	<div class="left-text flex-grow-1 text-end">
						<img class="shopping-write-image" id="preview" src="setting/image/코코1.jpg">		
	                </div>
	                <div class="right-text flex-grow-1">
	                	<span class="product-setting">상품명 : </span>&nbsp;<input type="text" class="product-input" name="subject" id="product-name" placeholder="<%=subject %>" />    
	                	<br>           	
				        <span class="product-setting">수량 : </span><input type="number" class="product-input" name="select-count" id="count" placeholder="0" max="999" oninput="validateAndSendPrice(this)" />	  
				        <br>
				        <span class="product-setting">가격 : </span>&nbsp;<span id="money"></span><span>원</span>
				        <br>
				        <span class="product-setting">판매상태 : </span>
				        <%if(status == true) { %>
				        &nbsp;<input type="text" class="product-input" name="status" id="product-name" placeholder="판매중" /> 
				        <%} else if(status == false) {%>
				        &nbsp;<input type="text" class="product-input" name="status" id="product-name" placeholder="품절" /> 
				        <%} %>
	                </div>
	                
	                <div>
	                	<label>선택한 상품</label>
	                </div>
	            </div>
		    	<br><br>
		    	<div>
		    		<h3>상세내용</h3>
		    		<br><br>
		    		
		    		<span>
		    			<%=content %>
		    		</span>
		    	</div>
     	        
		        <br><br>
		        <div>
		        	<a id="board-modify-btn" href="boardModify.do?board_id=<%=shoppingId%>">수정</a>
		        	<a id="board-delete-btn" href="boardDelete.do?board_id=<%=shoppingId%>">삭제</a>
		        	<a id="board-list-btn" href="/petpark.do#shopping">목록</a>
		        </div>
		        <hr>
		        <br>
	        	
	        	<!-- 
	        	
	        	댓글이 필요하면 게시판 View에 가서 가져오기
	        	
	        	 -->	
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
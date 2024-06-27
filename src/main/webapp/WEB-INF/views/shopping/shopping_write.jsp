<%@page import="com.petpark.dto.CrawlingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PetPark</title> 
     
    <!-- Bootstrap 5.3.3 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="setting/css/board_view.css">
    <link rel="stylesheet" href="setting/css/summernote.css">

    <!-- Summernote CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
    <!-- Bootstrap 5.3.3 JS Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Summernote JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
    
    <script>
    	window.onload = function() {
    		document.getElementById('submit-button').onclick = function() {
				
    			// 이미지 alert
    			let image = document.getElementById('image-upload').value;
    			
    			console.log(image);
    			
    			if(image.trim() == '') {
    				alert('이미지 선택해주세요');
    				return false;
    			}
    			
    			// 상품명 alert
        		let product_name = document.getElementById("product-name").value;
    			
        		if(product_name.trim() == '') {
    				alert('상품명을 입력해주세요.');
    				return false;
    			}
    			
    			// 카테고리 alert
    			let category = document.getElementById('select-category').value;
    			    			
    			if(category.trim() == '선택해주세요') {
    				alert('상품종류를 선택해주세요');
    				return false;
    			}
    			
    			// 가격 alert
    			let price = document.getElementById('price').value;
    			
    			if(price.trim() == '') {
    				alert('가격을 입력해주세요');
    				return false;
    			}
    			
    			// 수량 alert
    			let count = document.getElementById('count').value;
    			
    			if(count.trim() == '') {
    				alert('수량을 입력해주세요');
    				return false;
    			}
    			
    			// 판매상태 alert
    			let status = document.getElementById('select-status').value;
    			
    			if(status.trim() == '선택해주세요') {
    				alert('판매상태를 선택해주세요');
    				return false;
    			}
	
        		// 입력한 내용 (summernote)
    			let contentValue = $('.summernote').summernote('code');
    		   		
    			if(contentValue.trim() == '<p><br></p>') {
    				alert('내용을 입력해주세요');
    				return false;
    			}		
    		};
    	};
    	    	
        function previewImage(event) {
            let reader = new FileReader();
            reader.onload = function() {
                let output = document.getElementById('preview');
                output.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
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
    <br><br>
    <!-- main 영역 -->
    <main>  	
        <div class="summernote-container">         	
            <form action="/shoppingWriteOk.do" method="POST" enctype="multipart/form-data">
		    	<div class="d-flex mt-3">
	            	<div class="left-text flex-grow-1 text-end">
						<img class="shopping-write-image" id="preview" src="setting/image/코코1.jpg">		
	                </div>
	                <div class="right-text flex-grow-1">
		                	<span class="product-setting">이미지 : </span>&nbsp;<input type="file" name="product-image" id="image-upload" value="" multiple="multiple" class="board_view_input" style="height:25px;" onchange="previewImage(event)" />    
		                	<br>
		                	<span class="product-setting">상품명 : </span>&nbsp;<input type="text" class="product-input" name="subject" id="product-name" placeholder="등록하실 상품명을 입력해주세요." />    
		                	<br>           	
					        <span class="product-setting">상품종류 : </span>
					        <select id="select-category" name="category">		        	
					        	<option id="select-choice" disabled selected>선택해주세요</option>
					        	<option value="free_board">자유게시판</option>
					        	<option value="share_board">나눔게시판</option>
					        	<option value="qna_board">Q&A게시판</option>
					        </select>	
					        <br>
					        <span class="product-setting">가격 : </span><input type="number" class="product-input" name="product-price" id="price" placeholder="상품의 가격을 입력해주세요." />
					        <br>
					        <span class="product-setting">수량 : </span><input type="number" class="product-input" name="product-price" id="count" placeholder="상품의 수량을 입력해주세요." />	  
					        <br>
					        <span class="product-setting">판매상태 : </span>
					        <select id="select-status" name="status">		        	
					        	<option id="select-choice" disabled selected>선택해주세요</option>
					        	<option value="free_board">판매중</option>
					        	<option value="share_board">품절</option>
					        </select>	
	                </div>
	            </div>
		    	<br><br>
		    	<div>
		    		<h3>상세내용</h3>
		    	</div>
			    <textarea class="summernote" name="content" id="content"></textarea>		    
				<button type="button" id="submit-button" class="submit-button">상품등록</button>
			</form>    	        		   	                        
		</div>		

        <script>
	        $(document).ready(function() {
	            $('.summernote').summernote({
	                height: 300, // 높이를 필요에 따라 조정합니다.
	                minHeight: 300, // 최소 높이
	                maxHeight: null, // 최대 높이 제한 없음
	                focus: true // 페이지 로딩 시 summernote에 포커스를 줍니다.
	            });
	        });
        </script>
    </main>
    
    <br>
    
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
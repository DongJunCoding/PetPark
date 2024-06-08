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
    <script src="setting/js/summernote-ko-KR.js"></script>
    
    <script>
    	window.onload = function() {
    		document.getElementById('submit-button').onclick = function() {
    			
    			let select = document.getElementById('select-category');
    			    			
    			if(select.value.trim() == '선택해주세요') {
    				alert('카테고리를 선택해주세요');
    				return false;
    			}
    			
    			let content = document.getElementById("content");
    			
    			if(content.value.trim() == '') {
    				alert('내용을 입력해주세요');
    				return false;
    			}
    			
    		};
			
    	};
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
    	<form action="boardWriteOk.do" method="POST">
	        <div class="summernote-container">        
	        	<div class="author-field">
		        <label>작성자: </label><input type="text" name="nickname" value="닉네임" readonly />
		        <label>카테고리: </label>
		        <select id="select-category" name="category">		        	
		        	<option id="select-choice" disabled selected>선택해주세요</option>
		        	<option value="free_board">자유게시판</option>
		        	<option value="share_board">나눔게시판</option>
		        	<option value="qna_board">Q&A게시판</option>
		        </select>
		    	</div>        
			    <textarea class="summernote" name="content" id="content"></textarea>		    
				<button type="submit" id="submit-button" class="submit-button">글쓰기</button>
			</div>		
		</form>

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
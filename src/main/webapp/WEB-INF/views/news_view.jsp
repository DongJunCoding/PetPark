<%@page import="com.petpark.dto.CrawlingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	CrawlingDTO newsView = (CrawlingDTO)request.getAttribute("newsView");
	
	String subject = newsView.getSubject();
	String writer = newsView.getWriter();
	String date = newsView.getDate();
	String content = newsView.getContent();
	int viewCount = newsView.getView_count();
	
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

    <link rel="stylesheet" href="setting/css/board_view.css">
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
		        <p><%=writer %></p>
		        <p id="board_view_p_date"><%=date %></p>
		        <span>조회: <%=viewCount %></span>
		        <br>
		        <hr id="board_view_hr">
	        </div>
	    	<div class="board-content-news">
				<!-- 실제 게시글 내용 -->
		        <span>
		        	<%=content %>
		    	원본출처 : <a href="https://www.pet-news.or.kr/">한국반려동물신문</a>
		        </span>
     	        
		        <br>
		        <hr>
		        <br>       
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
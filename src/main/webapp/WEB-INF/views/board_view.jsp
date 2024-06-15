<%@page import="com.petpark.dto.BoardDTO"%>
<%@page import="com.petpark.dto.CrawlingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	BoardDTO boardView = (BoardDTO)request.getAttribute("boardView");
	
	String boardId = boardView.getBoard_id();
	String subject = boardView.getSubject();
	String writer = boardView.getWriter();
	String date = boardView.getDate();
	String content = boardView.getContent();
	
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
		        <hr id="board_view_hr">
	        </div>
	    	<div class="board_content">
				<!-- 실제 게시글 내용 -->
		        <span>
		        	<%=content %>
		        </span>
     	        
		        <br><br>
		        <div>
		        	<button class="board-button-reply">답글달기</button>
		        	<button class="board-button"><a href="boardDelete.do?board_id=<%=boardId%>">삭제</a></button>
		        	<button class="board-button" onclick="history.back()">목록</button>
		        </div>
		        <hr>
		        <br>
	        			
				<div class="comment_list">
					<h2>댓글</h2>
					<div class="comment">
					    <span class="author">작성자명</span>
						<p>댓글 내용 Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
						<div class="actions">
							<a class="edit-btn">수정</a> | <a class="delete-btn">삭제</a>
						</div>
						    <span class="reply-btn">답글달기</span>
						<div class="reply-form" style="display: none;">
						    <textarea class="reply-input" placeholder="답글 내용을 입력하세요"></textarea><br>
						    <button class="reply-submit">답글 작성</button>
					    </div>
					</div>		
				</div>
				
				<div class="card mb-2 comment">
					<div class="card-header bg-light">
						<i class="fa fa-comment fa"></i> 댓글 쓰기
					</div>
					<div class="card-body">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">
						    	<!-- 댓글 form -->
								<form action="#" method="post">
									<div class="form-inline mb-2">
										<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
										<input type="text" class="form-control ml-2" placeholder="Enter yourId" id="replyId">
										<label for="replyPassword" class="ml-4"><i class="fa fa-unlock-alt fa-2x"></i></label>
									</div>
									<textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
									<button type="button" class="btn btn-dark mt-3" onClick="javascript:addReply();">댓글 달기</button>
								</form>
							</li>
						</ul>
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
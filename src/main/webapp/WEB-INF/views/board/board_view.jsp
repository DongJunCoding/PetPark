<%@page import="com.petpark.controller.BoardController"%>
<%@page import="com.petpark.dto.CommentDTO"%>
<%@page import="com.petpark.dto.BoardDTO"%>
<%@page import="com.petpark.dto.CrawlingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	BoardDTO boardView = (BoardDTO)request.getAttribute("boardView");
	
	String boardId = boardView.getBoard_id();
	String category = boardView.getCategories();
	String subject = boardView.getSubject();
	String writer = boardView.getWriter();
	String date = boardView.getDate();
	String content = boardView.getContent();
	
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
		        
		        <%if(category.equals("free_board")) {  %>
		        <strong>자유게시판</strong>
		        <%} else if(category.equals("share_board")) {%>
		        <strong>나눔게시판</strong>
		        <%} else if(category.equals("qna_board")) {%>
		        <strong>Q & A게시판</strong>
		        <%} else if(category.equals("notice_board")) {%>
		        <strong>공지사항</strong>
		        <%}%>
		        
	        </div>
	    	<div class="board_content">
		        <hr>
				<!-- 실제 게시글 내용 -->
		        <span>
		        	<%=content %>
		        </span>
     	        
		        <br><br>
		        <div>
		        	<button class="board-button-reply">답글달기</button>
		        	<a id="board-modify-btn" href="boardModify.do?board_id=<%=boardId%>">수정</a>
		        	<a id="board-delete-btn" href="boardDelete.do?board_id=<%=boardId%>">삭제</a>
		        	<a id="board-list-btn" href="/petpark.do#board">목록</a>
		        </div>
		        <hr>
		        <br>
	        			
				<div class="comment_list">
					<h2>댓글</h2>
					<br>
					<div class="comment">
					<%if(boardComments != null) { %>
					    <%=commentSB %>
					<%} else {%>
							<span>댓글을 작성해주세요 !</span>
					<%} %>	
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
								<form action="commentWrite.do" method="POST">
									<input type="hidden" name="board-no" value="<%=boardId %>" />
									<div class="form-inline mb-2">
										<input type="text" class="form-control" name="comment-writer" id="replyId" value="댓글닉네임" readonly>
										<label for="replyPassword" class="ml-4"><i class="fa fa-unlock-alt fa-2x"></i></label>
									</div>
									<textarea class="form-control" name="comment-content" id="exampleFormControlTextarea1" rows="3"></textarea>
									<button type="submit" class="btn btn-dark mt-3" id="comment-btn">댓글 달기</button>
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
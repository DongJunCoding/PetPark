<%@page import="com.petpark.dto.PageDTO"%>
<%@page import="java.io.Console"%>
<%@page import="com.petpark.dto.CrawlingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
ArrayList<CrawlingDTO> recentNews = new ArrayList<CrawlingDTO>();
//ArrayList<CrawlingDTO> veterinaryFields = new ArrayList<CrawlingDTO>();

recentNews = (ArrayList<CrawlingDTO>)request.getAttribute("news");
//veterinaryFields = (ArrayList<CrawlingDTO>)request.getAttribute("veterinaryFields");

String newsId = "";
String subject = "";
String writer = "";
String date = "";
String image = "";
int viewCount = 0;

// int veterinaryFieldsSize = veterinaryFields.size();

StringBuilder newsSB = new StringBuilder();

for(CrawlingDTO news : recentNews) {
	
	newsId = news.getNewsId();
	subject = news.getSubject();
	writer = news.getWriter();
	date = news.getDate();
	viewCount = news.getView_count();
	
	newsSB.append("<tr>");
	newsSB.append("<td>" + newsId + "</td>");
	newsSB.append("<td class='tit'>");
	newsSB.append("<a href='/newsView.do?newsId=" + newsId + "'>" + subject + "</a>");
	newsSB.append("</td>");
	newsSB.append("<td>" + writer + "</td>");
	newsSB.append("<td>" + date + "</td>");
	newsSB.append("<td>" + viewCount + "</td>");
	newsSB.append("<tr>");
	
}

/* 
StringBuilder veterinaryFieldSB = new StringBuilder();

for(CrawlingDTO veterinaryField : veterinaryFields) {
	
	newsId = veterinaryField.getNewsId();
	subject = veterinaryField.getSubject();
	writer = veterinaryField.getWriter();
	date = veterinaryField.getDate();
	viewCount = veterinaryField.getView_count();
	image = veterinaryField.getMain_image();
		
	veterinaryFieldSB.append("<tr>");
	veterinaryFieldSB.append("<td>" + newsId + "</td>");
	veterinaryFieldSB.append("<td class='tit'>");
	veterinaryFieldSB.append("<a href='/newsView.do?newsId=" + newsId + "'><img class='board_list_image' src='" + image + "'>" + subject + "</a>");
	veterinaryFieldSB.append("</td>");
	veterinaryFieldSB.append("<td>" + writer + "</td>");
	veterinaryFieldSB.append("<td>" + date + "</td>");
	veterinaryFieldSB.append("<td>" + viewCount + "</td>");
	veterinaryFieldSB.append("</tr>");
	
}
*/

// Paging

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
		
	function page(pageNum) {
		$.ajax({
			type:'GET',
			url:'/newsList.do',
			async:true,	
			dataType:'json',
			data: {
				'currentPage':pageNum
			},
			success: function(page) {
				
				let veterinaryFields = page.veterinaryFields;
				
				let veterinaryFieldSB = new StringBuilder();
				
	            veterinaryFields.forEach(veterinaryField => {
	                veterinaryFieldSB.append("<tr>");
	                veterinaryFieldSB.append("<td>" + veterinaryField.newsId + "</td>");
	                veterinaryFieldSB.append("<td class='tit'>");
	                veterinaryFieldSB.append("<a href='/newsView.do?newsId=" + veterinaryField.newsId + "'><img class='board_list_image' src='" + veterinaryField.main_image + "'>" + veterinaryField.subject + "</a>");
	                veterinaryFieldSB.append("</td>");
	                veterinaryFieldSB.append("<td>" + veterinaryField.writer + "</td>");
	                veterinaryFieldSB.append("<td>" + veterinaryField.date + "</td>");
	                veterinaryFieldSB.append("<td>" + veterinaryField.view_count + "</td>");
	                veterinaryFieldSB.append("</tr>");
	            });
	            
	            document.getElementById("veterinaryFieldsTableBody").innerHTML = veterinaryFieldSB.toString();
			},
			error: function(error) {
				console.log("AJAX 요청 실패");
			}
		});
	}
	
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
                    <a class="nav-link active" data-bs-toggle="tab" href="#home">홈</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#news">뉴스 & 소식</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#board">커뮤니티</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#location">병원 & 용품점</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#shopping">쇼핑</a>
                </li>
            </ul>
            
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="home" class="container tab-pane active"><br>     
                    <form action="#" method="post">
                        <img src="setting/image/logo.png" class="searchlogo">
                        <div class="search">
                            <input class="searchinput" type="text" placeholder="통합검색" />
                            <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                        </div>
                    </form>
                    
                    
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
                                        <tr>
                                            <td>1</td>
                                            <td class="tit">
                                                <a href="#">반려동물 사진들 !</a>
                                            </td>
                                            <td>이동준</td>
                                            <td>2024-03-23</td>
                                            <td>216</td>
                                        </tr>                                          
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
                            <a class="board-nav-link" data-bs-toggle="tab" href="#industry">산업</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#policy">정책</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#society">사회</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#culture">문화</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#welfare">동물복지</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#veterinary_field">수의계</a>
                        </li>
                    </ul>    

                    <div id="industry" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#">산업</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>

                            </div>
                        </div>                  
                    </div>
                
                    <div id="policy" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#">정책</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div>                  
                    </div>

                    <div id="society" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#">사회</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>

                            </div>
                        </div>
                    </div>

                    <div id="culture" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#">문화</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div>
                    </div>

                    <div id="welfare" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#">동물복지</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>

                            </div>
                        </div>
                    </div>

                    <div id="veterinary_field" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
                        <div class="board_list_wrap">
                        <span id="board-size">게시글 :  개</span>
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
                                <tbody id="veterinaryFieldsTableBody"> 
                                                         
                                </tbody>
                            </table>
                            <div class="paging">
                                <a class="bt" onclick="page(1)" id="">첫 페이지</a>
                                <a class="bt" onclick="page()">이전 페이지</a>
                                <a class="num on" onclick="page(1)">1</a>
                                <a class="num" onclick="page(2)">2</a>
                                <a class="num" onclick="page(3)">3</a>
                                <a class="bt" onclick="page()">다음 페이지</a>
                                <a class="bt">마지막 페이지</a>

                            </div>
                        </div>
                    </div>
                </div>

                <div id="board" class="container tab-pane fade"><br>
                    <ul class="nav" role="tablist">
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#all_board">전체</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#free_board">자유게시판</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#share_board">나눔</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#qna_board">Q & A</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#notice_board">공지</a>
                        </li>
                    </ul>  

                    <div id="all_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#"><img class="board_list_image" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">전체 게시판 글</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>

                            </div>
                        </div> 
                    </div>

                    <div id="free_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#"><img class="board_list_image" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">자유게시판 글</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>

                            </div>
                        </div> 
                    </div>

                    <div id="share_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#"><img class="board_list_image" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">나눔게시판 글</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div> 
                    </div>

                    <div id="qna_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#">Q & A게시판 글</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>

                            </div>
                        </div> 
                    </div>

                    <div id="notice_board" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
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
                                    <tr>
                                        <td>1</td>
                                        <td class="tit">
                                            <a href="#">공지사항 글</a>
                                        </td>
                                        <td>이동준</td>
                                        <td>2024-03-23</td>
                                        <td>216</td>
                                    </tr>                             
                                </tbody>
                            </table>
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div> 
                    </div>
                </div>
                
                <!-- 동물병원 & 용품점 메뉴 -->
                <div id="location" class="container tab-pane fade"><br>
					<div class="map_wrap">
						<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
						<div id="menu_wrap" class="bg_white">
							<div class="option">
								<div>
									<form onsubmit="searchPlaces(); return false;">
										<div class="search">
											<input class="searchinput" type="text" id="keyword" placeholder="원하시는 장소를 입력해주세요." /> 
											<button type="submit"><img class="searchimage" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></button>
										</div>
									</form>
								</div>
							</div>
							<hr>
							<ul id="placesList"></ul>
							<div id="pagination"></div>
						</div>
					</div>
					<hr>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
					<div id="map" style="width:500px;height:400px;"></div>   
					
					<!-- 지도 띄우기 -->
    				<!-- 탭이 클릭될 때 해당 지도를 초기화하는 JavaScript -->
    				<!-- services 라이브러리 불러오기 -->
    				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df2361dc8911f546f03ef92bd8553c08"></script>
   
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df2361dc8911f546f03ef92bd8553c08&libraries=services"></script>
					<script>
					
						// 마커를 담을 배열
						var markers = [];
						
					    document.addEventListener('DOMContentLoaded', function() {
					        var tabs = document.querySelectorAll('.nav-link');
					        tabs.forEach(function(tab) {
					            tab.addEventListener('click', function() {					            	
					                initializeMap(); // 해당 탭이 클릭되었을 때 지도를 초기화하는 함수 호출
					            });
					        });
					    });
					
					    function initializeMap() {
					        var mapContainer = document.getElementById('map');
					        var mapOption = {
					            center: new kakao.maps.LatLng(37.65445926976924, 127.3029472503813), // 초기 중심 좌표 설정
					            level: 3 // 초기 확대 레벨 설정
					        };
					
					     	// 지도를 생성합니다    
					        var map = new kakao.maps.Map(mapContainer, mapOption); 

					        // 장소 검색 객체를 생성합니다
					        var ps = new kakao.maps.services.Places();  

					        // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
					        var infowindow = new kakao.maps.InfoWindow({zIndex:1});

					        // 키워드로 장소를 검색합니다
					        searchPlaces();

					        // 키워드 검색을 요청하는 함수입니다
					        function searchPlaces() {

					            var keyword = document.getElementById('keyword').value;

					            if (!keyword.replace(/^\s+|\s+$/g, '')) {
					                alert('키워드를 입력해주세요!');
					                return false;
					            }

					            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
					            ps.keywordSearch( keyword, placesSearchCB); 
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

					            var listEl = document.getElementById('placesList'), 
					            menuEl = document.getElementById('menu_wrap'),
					            fragment = document.createDocumentFragment(), 
					            bounds = new kakao.maps.LatLngBounds(), 
					            listStr = '';
					            
					            // 검색 결과 목록에 추가된 항목들을 제거합니다
					            removeAllChildNods(listEl);

					            // 지도에 표시되고 있는 마커를 제거합니다
					            removeMarker();
					            
					            for ( var i=0; i<places.length; i++ ) {

					                // 마커를 생성하고 지도에 표시합니다
					                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
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

					            var el = document.createElement('li'),
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
					            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
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
					            for ( var i = 0; i < markers.length; i++ ) {
					                markers[i].setMap(null);
					            }   
					            markers = [];
					        }

					        // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
					        function displayPagination(pagination) {
					            var paginationEl = document.getElementById('pagination'),
					                fragment = document.createDocumentFragment(),
					                i; 

					            // 기존에 추가된 페이지번호를 삭제합니다
					            while (paginationEl.hasChildNodes()) {
					                paginationEl.removeChild (paginationEl.lastChild);
					            }

					            for (i=1; i<=pagination.last; i++) {
					                var el = document.createElement('a');
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
					            var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

					            infowindow.setContent(content);
					            infowindow.open(map, marker);
					        }

					        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
					        function removeAllChildNods(el) {   
					            while (el.hasChildNodes()) {
					                el.removeChild (el.lastChild);
					            }
					        }
					    }					   	    		    
					</script>
                </div>
                            
                <div id="shopping" class="container tab-pane fade"><br>
                    <ul class="nav" role="tablist">
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#all_shopping">전체</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#food_shopping">밥</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#snack_shopping">간식</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#toy_shopping">장난감</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#clothes_shopping">의류</a>
                        </li>
                        <li class="nav-item">
                            <a class="board-nav-link" data-bs-toggle="tab" href="#furniture_shopping">가구</a>
                        </li>
                    </ul> 

                    <div id="all_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
                        <table class="shopping_list_table">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>                                         
                            </tr>
                        </table>
                        <div class="board_list_wrap">
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div>
                    </div>

                    <div id="food_shopping" class="container tab-pane fade"><br>                     
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
                        <table class="shopping_list_table">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>                                         
                            </tr>
                        </table>
                        <div class="board_list_wrap">
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div>
                    </div>

                    <div id="snack_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
                        <table class="shopping_list_table">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>                                         
                            </tr>
                        </table>
                        <div class="board_list_wrap">
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div>
                    </div>

                    <div id="toy_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
                        <table class="shopping_list_table">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>                                         
                            </tr>
                        </table>
                        <div class="board_list_wrap">
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div>
                    </div>

                    <div id="clothes_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
                        <table class="shopping_list_table">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>                                         
                            </tr>
                        </table>
                        <div class="board_list_wrap">
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
                            </div>
                        </div>
                    </div>

                    <div id="furniture_shopping" class="container tab-pane fade"><br>
                        <form action="#" method="post">
                            <img src="setting/image/logo.png" class="searchlogo">
                            <div class="search">
                                <input class="searchinput" type="text" placeholder="검색" />
                                <img class="searchimage" type="submit" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                            </div>
                        </form>
                        <table class="shopping_list_table">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td><img class="shopping_list_image" src="setting/image/코코2.jpg"></td>
                                        </tr>
                                        <tr>
                                            <td>상품명</td><br>
                                        </tr>
                                        <tr>
                                            <td>가격</td>
                                        </tr>
                                    </table>
                                </td>                                         
                            </tr>
                        </table>
                        <div class="board_list_wrap">
                            <div class="paging">
                                <a href="#" class="bt">첫 페이지</a>
                                <a href="#" class="bt">이전 페이지</a>
                                <a href="#" class="num on">1</a>
                                <a href="#" class="num">2</a>
                                <a href="#" class="num">3</a>
                                <a href="#" class="bt">다음 페이지</a>
                                <a href="#" class="bt">마지막 페이지</a>
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
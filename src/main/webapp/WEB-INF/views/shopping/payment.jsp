<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String storeId = (String)request.getAttribute("storeId");
	String identificationCode = (String)request.getAttribute("identificationCode");
	String portOneAPIKEY = (String)request.getAttribute("portOneAPIKEY");
	String portOneSecretKey = (String)request.getAttribute("portOneSecretKey");
	
	String shoppingId = (String)request.getAttribute("shoppingId");
	String productImage = (String)request.getAttribute("productImage");
	String productName = (String)request.getAttribute("productName");
	String productCount = (String)request.getAttribute("productCount");
	String productPriceString = (String)request.getAttribute("productPrice");
	
	int productPrice = Integer.parseInt(productPriceString.replace(",", ""));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PetPark</title> 
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    
    <link rel="stylesheet" href="setting/css/payment.css">

    <script>  
    /*
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수
    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
    
                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("sample6_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
 	*/
        IMP.init('<%=identificationCode%>');
        function requestPay() {        	  
        	let merchant_uid  = "O" + new Date().getTime()
        	console.log(payment_uid);
        	IMP.request_pay(
       		  {
       		    pg: "html5_inicis",
       		    pay_method: "card",
       		    merchant_uid: merchant_uid , // 주문 고유 번호
       		    name: "<%=productName%>",
       		    amount: 1000,
       		    buyer_email: "gildong@gmail.com",
       		    buyer_name: "홍길동",
       		    buyer_tel: "010-4242-4242",
       		    buyer_addr: "서울특별시 강남구 신사동",
       		    buyer_postcode: "01181",
       		  },
       		  function (response) {  			  
       			  if(response.success) {
       		          console.log("결제 성공");
       			  } else {
       				  console.log("결제 실패");
       			  }
       		  },
       		);
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
        <fieldset id="fieldset">
            <a href="petpark.do"><img id="logo_home" src="setting/image/home.png"></a>
            <form class="joinForm">        

				<h2>배송지</h2>

                <div class="textForm">
                    <input name="zip_code" type="text" class="input_text" id="sample6_postcode" placeholder="우편번호" value="">
                    <input type="button" class="address_btn on" onclick="sample6_execDaumPostcode()" value="배송지 변경"><br>
                </div>     

                <div class="textForm">
                    <input name="address" type="text" class="input_text"  id="sample6_address" placeholder="주소" value=""><br>
                </div>  
                
                <div class="textForm">
                    <input name="extra_address" type="text" class="input_text" id="sample6_extraAddress" placeholder="참고항목" value="">
                </div>   
                
                <div class="textForm">
                    <input name="detail_address" type="text" class="input_text"  id="sample6_detailAddress" placeholder="상세주소" value="">
                </div>   
				
				<br><br>
				
				<h2>결제상품</h2>
				
				<div class="textFormImage">
                    <img id="product-image" src="setting/shopping_image/<%=productImage%>" /><br>
                </div>
                
				<div class="textForm">
                    <h5>상품명</h5><input name="product-name" type="text" class="input_text"  id="sample6_address" value="<%=productName%>" readonly><br>
                </div>
                
                <div class="textForm">
                    <h5>수량</h5><input name="product-count" type="text" class="input_text"  id="sample6_address" value="<%=productCount%>" readonly><br>
                </div>
                
                <div class="textForm">
                    <h5>가격</h5><input name="product-price" type="text" class="input_text"  id="sample6_address" value="<%=productPrice%>" readonly><br>
                </div>  

                <input type="button" class="btn on" value="결제" onclick="requestPay()"/>
            </form>
        </fieldset>
    </main>
</body>
</html>
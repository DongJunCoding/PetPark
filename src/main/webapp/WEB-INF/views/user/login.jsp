<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>PetPark</title> 
    
    <link rel="stylesheet" href="setting/css/login.css">

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
        <div class="login-wrapper">
            <h2>Login</h2>
            <a href="signup.do" class="login_link">회원가입</a>
            <a href="petpark.do" class="login_link">홈으로</a>
            <form method="post" action="#" id="login-form">
                <input type="text" name="login_email" placeholder="Email">
                <input type="password" name="login_password" placeholder="Password">
                <label for="remember-check">
                    <input type="checkbox" id="remember-check">아이디 저장하기
                </label>
                <input type="submit" value="Login">
            </form>

            <br>

            <div class="text-between-lines">
                <span>소셜로그인</span>
            </div>
            
            <div id="div_social">
                <img class="image_social" src="setting/image/login_kakao.png">
                <img class="image_social" src="setting/image/login_naver.png">
                <img class="image_social" src="setting/image/login_google.png">
            </div>
        </div>
    </main>
</body>
</html>
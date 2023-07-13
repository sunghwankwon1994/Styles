<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 가입 성공</title>
</head>
<body>
	<h1>회원 가입이 성공적으로 처리되었습니다!</h1>
	<button class="goToLogin" onclick="goToLogin()">로그인화면으로 돌아가기</button>
	<button class="goToHome" onclick="goToHome()">홈화면으로 돌아가기</button>

	<script>
		function goToLogin() {
			window.location.href = "/login";
		}

		function goToHome() {
			window.location.href = "/";
		}
	</script>
</body>
</html>
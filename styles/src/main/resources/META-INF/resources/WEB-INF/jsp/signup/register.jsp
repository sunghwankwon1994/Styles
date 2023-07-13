<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<meta charset="UTF-8">
<link href="../../css/signup.css" rel="stylesheet" type="text/css">
<title>Sign-up Page</title>
</head>
<body>
	<div class="nav-bar"></div>
	<div class="container">
		<form id="form" class="form" action="/signup" method="post">
			<div>
				<h2 class="title">Create Account</h2>
				<p class="sub-title">Discover and Share your favorite styles</p>
			</div>
			<div class="form-control">
				<label for="username">Name</label> <input type="text" id="username"
					name="username" placeholder="이름을 입력해주세요" /> <small>Error
					message</small>
			</div>
			<div class="form-control">
				<label for="phone_number">Phone#</label> <input type="tel"
					id="phone_number" name="phone_number" placeholder="전화번호를 입력해주세요" />
				<small>Error message</small>
			</div>
			<div class="form-control">
				<label for="email">Email</label> <input type="text" id="email"
					name="email" placeholder="이메일을 입력해주세요" /> <small>Error
					message</small>
			</div>
			<div class="form-control">
				<label for="address">Address</label> <input type="text" id="address"
					name="address" placeholder="주소를 입력해주세요" />
				<button type="button" onclick="searchAddress()">주소 검색</button>
				<small>Error message</small>
			</div>
			<div class="form-control">
				<label for="password">Password</label> <input type="password"
					name="password" id="password" placeholder="비밀번호를 입력해주세요" /> <small>Error
					message</small>
			</div>
			<div class="form-control">
				<label for="password2">Confirm password</label> <input
					type="password" id="password2" placeholder="다시 비밀번호를 입력해주세요" /> <small>Error
					message</small>
			</div>
			<button type="submit">회원가입</button>
		</form>
	</div>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="../../js/signup.js"></script>
</body>
<!DOCTYPE html>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<meta charset="UTF-8">
<title>User Form</title>
</head>
<body>
	<h2>User Form</h2>

	<form action="/admin/users/add" method="post">
		<input type="hidden" name="id" value="${user.id}" /> <label
			for="username">Username:</label> <input type="text" name="username"
			value="${user.username}" required /> <label for="email">Email:</label>
		<input type="email" name="email" value="${user.email}" required /> <label
			for="password">Password:</label> <input type="password"
			name="password" value="${user.password}" required /> <label
			for="address">Address:</label> <input type="text" name="address"
			value="${user.address}" /> <label for="phone_number">Phone
			Number:</label> <input type="text" name="phone_number"
			value="${user.phone_number}" /> <label for="isAdmin">Admin:</label>
		<input type="checkbox" name="admin" ${user.admin ? 'checked' : ''} />

		<button type="submit">Save</button>
	</form>
</body>
</html>

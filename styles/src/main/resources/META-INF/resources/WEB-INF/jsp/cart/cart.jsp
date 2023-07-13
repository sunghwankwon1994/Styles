<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="webjars/bootstrap/5.3.0/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
.total-price {
	font-weight: bold;
	font-size: 18px;
	color: #333;
	margin-top: 10px;
}
</style>

<title>Cart</title>
</head>
<body>
	<%@ include file="../common/navbar.jspf"%>
	<div class="container">
		<h1 class="mt-4">Cart</h1>
		<table class="table table-striped">
			<thead>
				<tr>
					<th scope="col">상품</th>
					<th scope="col">상품명</th>
					<th scope="col">수량</th>
					<th scope="col">가격</th>
					<th scope="col">합계</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
				<c:set var="totalPrice" value="0" />
				<c:forEach var="cartItem" items="${cartItems}">
					<tr>
						<td><img src="${cartItem.product.imageUrl}"
							class="img-thumbnail" width="80" height="80" alt="상품 이미지"></td>
						<td>${cartItem.product.name}</td>
						<td>${cartItem.quantity}</td>
						<td>${cartItem.product.price}원</td>
						<td>${cartItem.quantity * cartItem.product.price}원</td>
						<td>
							<form action="/cart/remove/${cartItem.id}" method="post">
								<button type="submit" class="btn btn-danger">삭제</button>
							</form>
						</td>
					</tr>
					<c:set var="totalPrice"
						value="${totalPrice + (cartItem.quantity * cartItem.product.price)}" />
				</c:forEach>
			</tbody>
		</table>

		<div class="row">
			<div class="col-md-6">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">구매자 정보</h5>
						<form id="buyerForm">
							<div class="mb-3">
								<label for="buyer_name" class="form-label">이름</label> <input
									type="text" id="buyer_name" name="buyer_name"
									value="${cartItems[0].user.username}" class="form-control">
							</div>
							<div class="mb-3">
								<label for="buyer_email" class="form-label">이메일</label> <input
									type="text" id="buyer_email" name="buyer_email"
									value="${cartItems[0].user.email}" class="form-control">
							</div>
							<div class="mb-3">
								<label for="buyer_tel" class="form-label">전화번호</label> <input
									type="text" id="buyer_tel" name="buyer_tel"
									value="${cartItems[0].user.phone_number}" class="form-control">
							</div>
							<div class="mb-3">
								<label for="buyer_addr" class="form-label">주소</label> <input
									type="text" id="buyer_addr" name="buyer_addr"
									value="${fn:substringAfter(cartItems[0].user.address, ',')}"
									class="form-control">
							</div>

							<div class="mb-3">
								<label for="buyer_postcode" class="form-label">우편번호</label> <input
									type="text" id="buyer_postcode" name="buyer_postcode"
									value="${fn:substringBefore(cartItems[0].user.address, ',')}"
									class="form-control">
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">총 결제 금액</h5>
						<div class="total-price mb-4">${totalPrice}원</div>
						<h5 class="card-title">결제방법</h5>
						<div class="mb-3">
							<label class="form-check-label" for="samsung"> <input
								type="radio" id="samsung" name="payMethod" value="samsung"
								class="form-check-input"> 삼성페이
							</label>
						</div>
						<div class="mb-3">
							<label class="form-check-label" for="card"> <input
								type="radio" id="card" name="payMethod" value="card"
								class="form-check-input" checked> 신용카드
							</label>
						</div>
						<div class="mb-3">
							<label class="form-check-label" for="trans"> <input
								type="radio" id="trans" name="payMethod" value="trans"
								class="form-check-input"> 실시간계좌이체
							</label>
						</div>
						<div class="mb-3">
							<label class="form-check-label" for="vbank"> <input
								type="radio" id="vbank" name="payMethod" value="vbank"
								class="form-check-input"> 가상계좌
							</label>
						</div>
						<div class="mb-3">
							<label class="form-check-label" for="phone"> <input
								type="radio" id="phone" name="payMethod" value="phone"
								class="form-check-input"> 휴대폰소액결제
							</label>
						</div>
						<button id="check_module" type="button" class="btn btn-dark">결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$("#check_module")
				.click(
						function() {
							var IMP = window.IMP;
							IMP.init('imp68263707');
							var totalPrice = $
							{
								totalPrice
							}
							;
							var payMethod = $("input[name='payMethod']:checked")
									.val();
							var payMethodName = $(
									"input[name='payMethod']:checked").next()
									.text();

							// 구매자 정보 입력 폼에서 변경된 정보 가져오기
							var buyer_email = $('#buyer_email').val();
							var buyer_name = $('#buyer_name').val();
							var buyer_tel = $('#buyer_tel').val();
							var buyer_addr = $('#buyer_addr').val();
							var buyer_postcode = $('#buyer_postcode').val();

							IMP
									.request_pay(
											{
												pg : 'html5_inicis',
												pay_method : payMethod,
												merchant_uid : 'merchant_'
														+ new Date().getTime(),
												name : '주문명:결제테스트',
												amount : ${totalPrice},
												buyer_email : buyer_email,
												buyer_name : buyer_name,
												buyer_tel : buyer_tel,
												buyer_addr : buyer_addr,
												buyer_postcode : buyer_postcode,
												m_redirect_url : 'https://www.yourdomain.com/payments/complete'
											},
											function(rsp) {
												console.log(rsp);
												if (rsp.success) {
													var msg = '결제가 완료되었습니다.';
													msg += '고유ID : '
															+ rsp.imp_uid;
													msg += '상점 거래ID : '
															+ rsp.merchant_uid;
													msg += '결제 금액 : '
															+ rsp.paid_amount;
													msg += '카드 승인번호 : '
															+ rsp.apply_num;
													alert(msg);
												} else {
													var msg = '결제에 실패하였습니다.';
													msg += '에러내용 : '
															+ rsp.error_msg;
													alert(msg);
												}

												// 결제 완료 또는 실패 후에 버튼의 텍스트를 "결제하기"로 변경
												$("#check_module").text("결제하기");
											});

							// 결제 진행 중에도 버튼의 텍스트를 "결제 중..."으로 변경
							$("#check_module").text("결제 중...");
						});
	</script>
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript"
		src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script src="../../js/logout.js"></script>
</body>
</html>

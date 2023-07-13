// home.js

// 서버에서 데이터를 가져와서 화면에 표시하는 함수
function fetchAndDisplayData() {
	fetch('/api/products') // 데이터를 가져올 API 엔드포인트 주소
		.then(response => response.json()) // JSON 형태로 응답 변환
		.then(data => {
			// 데이터를 받아서 화면에 표시하는 로직
			const productContainer = document.getElementById('productList');

			// 데이터를 순회하면서 화면에 추가
			data.forEach(product => {
				const productItem = document.createElement('div');
				productItem.classList.add('col');

				const card = document.createElement('div');
				card.classList.add('card');

				const productLink = document.createElement('a');
				productLink.href = '/products/' + product.id;
				productLink.style.textDecoration = 'none';

				const productImage = document.createElement('img');
				productImage.classList.add('card-img-top');
				productImage.src = product.imageUrl;
				productImage.alt = 'Product Image';
				productImage.style.width = '200px';
				productImage.style.height = '300px';

				const cardBody = document.createElement('div');
				cardBody.classList.add('card-body');

				const productName = document.createElement('h5');
				productName.classList.add('card-title');
				productName.textContent = product.name;

				cardBody.appendChild(productName);
				card.appendChild(productImage);
				productLink.appendChild(card);
				productItem.appendChild(productLink);

				productContainer.appendChild(productItem);

				cardBody.appendChild(productName);
				card.appendChild(productImage);
				productLink.appendChild(card);
				productItem.appendChild(productLink);

				productContainer.appendChild(productItem);
			});
		})
		.catch(error => {
			console.error('Error:', error);
		});
}

// 페이지 로드 시 데이터 가져오기
fetchAndDisplayData();

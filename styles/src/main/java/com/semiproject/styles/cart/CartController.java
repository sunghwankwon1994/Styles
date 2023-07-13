package com.semiproject.styles.cart;

import com.semiproject.styles.admin.User;
import com.semiproject.styles.admin.UserRepository;
import com.semiproject.styles.product.Product;
import com.semiproject.styles.product.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {

	private final CartRepository cartRepository;
	private final UserRepository userRepository;
	private final ProductRepository productRepository;

	@Autowired
	public CartController(CartRepository cartRepository, UserRepository userRepository,
			ProductRepository productRepository) {
		this.cartRepository = cartRepository;
		this.userRepository = userRepository;
		this.productRepository = productRepository;
	}

	@GetMapping("/cart")
	public String viewCart(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");

		if (user == null) {
			// 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
			return "redirect:/login";
		}

		List<Cart> cartItems = cartRepository.findByUser(user);
		for (Cart cartItem : cartItems) {
			Product product = cartItem.getProduct();
			String imageFileName = product.getId() + ".jpg";
			String imageUrl = "../static/" + imageFileName;
			product.setImageUrl(imageUrl);
		}
		model.addAttribute("cartItems", cartItems);
		return "cart/cart";
	}

	@PostMapping("/api/cart/add/{productId}")
	public ResponseEntity<String> addToCart(@PathVariable("productId") Long productId, HttpSession session) {
		User user = (User) session.getAttribute("user");

		if (user == null) {
			// 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User is not logged in");
		}

		Product product = productRepository.findById(productId).orElse(null);
		if (product == null) {
			// 상품을 찾을 수 없는 경우, 에러 응답
			return ResponseEntity.notFound().build();
		}

		// 동일한 상품이 이미 카트에 있는지 확인
		Cart existingCartItem = cartRepository.findByUserAndProduct(user, product);
		if (existingCartItem != null) {
			// 이미 카트에 있는 경우, quantity 증가
			existingCartItem.setQuantity(existingCartItem.getQuantity() + 1);
			cartRepository.save(existingCartItem);
			return ResponseEntity.ok().body("Product quantity increased in cart");
		}

		// 카트에 없는 경우, 새로운 카트 아이템 생성
		Cart cartItem = new Cart();
		cartItem.setUser(user);
		cartItem.setProduct(product);
		cartItem.setQuantity(1); // 임의로 수량 1로 설정

		cartRepository.save(cartItem);

		return ResponseEntity.ok().body("Product added to cart");
	}

	@PostMapping("/cart/remove/{cartItemId}")
	public String removeFromCart(@PathVariable("cartItemId") Long cartItemId, HttpSession session) {
		User user = (User) session.getAttribute("user");

		if (user == null) {
			// 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
			return "redirect:/login";
		}

		cartRepository.deleteById(cartItemId);

		return "redirect:/cart";
	}
}

package com.semiproject.styles.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.semiproject.styles.product.Product;
import com.semiproject.styles.product.ProductService;

import java.util.List;

@Controller
public class HomeController {
	private final ProductService productService;

	@Autowired
	public HomeController(ProductService productService) {
		this.productService = productService;
	}

	@GetMapping("/")
	public String showHome(Model model) {
		List<Product> randomProducts = productService.getRandomProducts(9);
		model.addAttribute("products", randomProducts);
		return "home/home";
	}
}
package com.semiproject.styles.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
	private final ProductRepository productRepository;

	@Autowired
	public ProductService(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}

	public Product getProductById(Long id) {
		return productRepository.findById(id).orElse(null);
	}

	public List<Product> getAllProducts() {
		return productRepository.findAll();
	}

	public List<Product> getRandomProducts(int count) {
	    return productRepository.findRandomProducts(count);
	}

}

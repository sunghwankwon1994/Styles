package com.semiproject.styles.product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
	@Query(value = "SELECT * FROM products ORDER BY RAND() LIMIT :count", nativeQuery = true)
	List<Product> findRandomProducts(@Param("count") int count);
}

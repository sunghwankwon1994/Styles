package com.semiproject.styles.cart;

import com.semiproject.styles.admin.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    private final CartRepository cartItemRepository;

    @Autowired
    public CartService(CartRepository cartItemRepository) {
        this.cartItemRepository = cartItemRepository;
    }

    public List<Cart> getCartItemsByUser(User user) {
        return cartItemRepository.findByUser(user);
    }

    public void addCartItem(Cart cart) {
        cartItemRepository.save(cart);
    }

    public void removeCartItem(Long cartId) {
        cartItemRepository.deleteById(cartId);
    }
}

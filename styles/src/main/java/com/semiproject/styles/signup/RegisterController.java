package com.semiproject.styles.signup;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.semiproject.styles.admin.User;
import com.semiproject.styles.admin.UserService;

@Controller
@RequestMapping("/signup")
public class RegisterController {
    private final UserService userService;

    @GetMapping
    public String registerPage() {
        return "signup/register";
    }

    @Autowired
    public RegisterController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/success")
    public String signUp(@RequestBody User user) {
        userService.saveUser(user);
        return "redirect:/signup/success";
    }

    @GetMapping("/success")
    public String successPage() {
        return "signup/success";
    }
}
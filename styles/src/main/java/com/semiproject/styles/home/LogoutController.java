package com.semiproject.styles.home;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션을 만료시킴
        return "redirect:/login"; // 로그아웃 후 로그인 페이지로 리다이렉트
    }

}
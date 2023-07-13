package com.semiproject.styles.security;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

        String errorMessage = getErrorMessage(exception);

        // 로그인 페이지로 리다이렉트하며 에러 메시지 전달
        String redirectUrl = "/login?error=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8);
        response.sendRedirect(redirectUrl);
    }

    private String getErrorMessage(AuthenticationException exception) {
        String errorMessage;
        if (exception instanceof BadCredentialsException) {
            errorMessage = "올바르지 않은 유저 정보입니다. 다시 입력해주세요.";
        } else if (exception instanceof DisabledException) {
            errorMessage = "계정이 비활성화되었습니다.";
        } else {
            errorMessage = "인증에 실패했습니다.";
        }
        return errorMessage;
    }
}


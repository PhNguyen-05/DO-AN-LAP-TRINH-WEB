// File: src/main/java/vn/iotstar/starshop/security/CustomLoginSuccessHandler.java
package vn.iotstar.starshop.security;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_Admin"))) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_Vendor"))) {
            response.sendRedirect(request.getContextPath() + "/vendor/home");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}

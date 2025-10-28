package vn.iotstar.starshop.config;

import jakarta.servlet.DispatcherType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;
import vn.iotstar.starshop.security.CustomUserDetailsService;
import vn.iotstar.starshop.security.CustomLoginSuccessHandler;

@Configuration
public class SecurityConfig {

    // Cho phép các ký tự đặc biệt trong URL (nếu cần)
    @Bean
    public HttpFirewall allowDoubleSlashFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true);
        firewall.setAllowSemicolon(true);
        firewall.setAllowBackSlash(true);
        firewall.setAllowUrlEncodedPercent(true);
        firewall.setAllowUrlEncodedSlash(true);
        return firewall;
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer(HttpFirewall firewall) {
        return (web) -> web.httpFirewall(firewall);
    }

    // Password encoder (BCrypt)
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Cấu hình provider để lấy user từ DB
    @Bean
    public DaoAuthenticationProvider authProvider(CustomUserDetailsService userDetailsService, PasswordEncoder encoder) {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(encoder);
        return provider;
    }

    // Cấu hình security chính
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, DaoAuthenticationProvider authProvider) throws Exception {
        http
            .csrf(AbstractHttpConfigurer::disable)
            .authenticationProvider(authProvider)
            .authorizeHttpRequests(auth -> auth
                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                .requestMatchers("/", "/home", "/index", "/auth/**", "/css/**", "/js/**", "/images/**", "/webjars/**", "/WEB-INF/views/**").permitAll()
                .requestMatchers("/user/**", "/orders/**").authenticated() // chỉ user login mới vào
                .anyRequest().authenticated()
            )
            .formLogin(login -> login
                .loginPage("/auth/login")                   // Trang login (GET)
                .loginProcessingUrl("/auth/login")          // Form POST action
                .usernameParameter("identifier")            // name của input (email/sdt)
                .passwordParameter("password")
                .successHandler(customLoginSuccessHandler)
                .failureUrl("/auth/login?error")            // Nếu sai pass
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/auth/logout")
                .logoutSuccessUrl("/auth/login?logout")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            );

        return http.build();
    }

    // Cần cho AuthenticationManager (nếu dùng @Autowired ở nơi khác)
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }
    
    @Autowired
    private CustomLoginSuccessHandler customLoginSuccessHandler;
}


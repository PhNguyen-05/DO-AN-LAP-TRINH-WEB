package vn.iotstar.starshop.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.MacAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.Map;

/**
 * Tiện ích tạo và xác thực JWT (chuẩn cho JJWT 0.12.6)
 */
@Component
public class JwtUtil {

    private final SecretKey key;
    private final long validityMs;
    private final MacAlgorithm algorithm = Jwts.SIG.HS256; // ✅ thuật toán mới

    public JwtUtil(
            @Value("${app.jwt.secret}") String secret,
            @Value("${app.jwt.expiration-ms}") long validityMs) {
        this.key = Keys.hmacShaKeyFor(secret.getBytes());
        this.validityMs = validityMs;
    }

    /**
     * Sinh JWT token kèm claims.
     */
    public String generateToken(String subject, Map<String, Object> claims) {
        long now = System.currentTimeMillis();
        return Jwts.builder()
                .claims(claims)
                .subject(subject)
                .issuedAt(new Date(now))
                .expiration(new Date(now + validityMs))
                .signWith(key, algorithm) // ✅ API mới yêu cầu SecretKey + MacAlgorithm
                .compact();
    }

    /**
     * Kiểm tra và parse token.
     */
    public Jws<Claims> validateToken(String token) throws JwtException {
        return Jwts.parser()     // ✅ API mới
                .verifyWith(key) // ✅ cần SecretKey
                .build()
                .parseSignedClaims(token);
    }
}

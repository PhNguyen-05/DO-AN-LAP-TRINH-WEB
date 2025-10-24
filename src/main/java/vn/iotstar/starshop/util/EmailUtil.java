package vn.iotstar.starshop.util;

import org.springframework.stereotype.Component;

@Component
public class EmailUtil {

    /**
     * Thay vì gửi email thật, in link reset ra console
     */
    public void sendPasswordResetEmail(String to, String resetLink) {
        System.out.println("=== [Fake Email Sent] ===");
        System.out.println("To: " + to);
        System.out.println("Reset link: " + resetLink);
        System.out.println("=========================");
    }
}

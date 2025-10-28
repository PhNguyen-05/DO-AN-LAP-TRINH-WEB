//package vn.iotstar.starshop.util;
//
//import org.springframework.stereotype.Component;
//
//@Component
//public class EmailUtil {
//
//    /**
//     * Thay vì gửi email thật, in link reset ra console
//     */
//    public void sendPasswordResetEmail(String to, String resetLink) {
//        System.out.println("=== [Fake Email Sent] ===");
//        System.out.println("To: " + to);
//        System.out.println("Reset link: " + resetLink);
//        System.out.println("=========================");
//    }
//}


package vn.iotstar.starshop.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;

@Component
public class EmailUtil {

    @Autowired(required = false)
    private JavaMailSender mailSender; // có thể null khi test local

    private static final SecureRandom random = new SecureRandom();

    /** 
     * ✅ Sinh mã OTP ngẫu nhiên 6 chữ số 
     */
    public String generateOtp() {
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * ✅ Gửi mã OTP kích hoạt (fake hoặc thật)
     */
    public void sendOtpEmail(String to, String otp) {
        if (mailSender == null) {
            System.out.println("=== [Fake OTP Email Sent] ===");
            System.out.println("To: " + to);
            System.out.println("Your OTP: " + otp);
            System.out.println("==============================");
            return;
        }

        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(to);
        msg.setSubject("StarShop - Mã OTP Kích Hoạt Tài Khoản");
        msg.setText("Mã OTP của bạn là: " + otp + "\nHiệu lực trong 5 phút.");
        mailSender.send(msg);
    }

    /**
     * ✅ Gửi link reset mật khẩu (fake hoặc thật)
     */
    public void sendPasswordResetEmail(String to, String resetLink) {
        if (mailSender == null) {
            System.out.println("=== [Fake Reset Email Sent] ===");
            System.out.println("To: " + to);
            System.out.println("Reset link: " + resetLink);
            System.out.println("==============================");
            return;
        }

        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(to);
        msg.setSubject("StarShop - Đặt Lại Mật Khẩu");
        msg.setText("Click liên kết để đặt lại mật khẩu: " + resetLink);
        mailSender.send(msg);
    }
}


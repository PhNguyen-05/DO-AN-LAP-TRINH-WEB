package vn.iotstar.starshop.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import jakarta.servlet.annotation.WebFilter;

@WebFilter("/*")
public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder
            // 👑 Trang admin dùng layout admin.jsp
            .addDecoratorPath("/admin/*", "/admin.jsp")

        //  Vendor layout
            .addDecoratorPath("/vendor/*", "/vendor.jsp")
            
            // 🏠 Trang người dùng dùng layout main.jsp
            .addDecoratorPath("/home", "/main.jsp")
            .addDecoratorPath("/shop", "/main.jsp")
            .addDecoratorPath("/shop/category/*", "/main.jsp")

            .addDecoratorPath("/product/*", "/main.jsp")  // 🩷 Thêm dòng này
            .addDecoratorPath("/user/wishlist", "/main.jsp")
            .addDecoratorPath("/shop/promotions", "/main.jsp")

            .addDecoratorPath("/user/cart", "/main.jsp")
            .addDecoratorPath("/", "/main.jsp")
            .addDecoratorPath("/about", "/main.jsp")
            .addDecoratorPath("/contact", "/main.jsp")
            // 🚫 Loại trừ các trang không cần layout
            .addExcludedPath("/login")
            .addExcludedPath("/register")
            .addExcludedPath("/api/*")
            .addExcludedPath("/static/*");
    }
}

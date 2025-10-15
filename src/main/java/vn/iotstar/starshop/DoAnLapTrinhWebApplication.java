package vn.iotstar.starshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

import vn.iotstar.starshop.config.CustomSiteMeshFilter;

@SpringBootApplication
public class DoAnLapTrinhWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(DoAnLapTrinhWebApplication.class, args);
	}

	// Đăng ký SiteMesh Filter cho toàn bộ ứng dụng
	@Bean
	public FilterRegistrationBean<CustomSiteMeshFilter> siteMeshFilter() {
		FilterRegistrationBean<CustomSiteMeshFilter> filter = new FilterRegistrationBean<>();
		filter.setFilter(new CustomSiteMeshFilter());
		filter.addUrlPatterns("/*");
		return filter;
	}
}

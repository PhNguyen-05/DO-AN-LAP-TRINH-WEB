package vn.iotstar.starshop.service;

import vn.iotstar.starshop.entity.Vendor;
import java.util.List;
import java.util.Map;

public interface RevenueService {
    // Doanh thu trong 1 tháng cụ thể
    double getMonthlyRevenue(Vendor vendor, int month, int year);

    // Doanh thu của 6 tháng gần nhất
    List<Double> getLast6MonthsRevenue(Vendor vendor);

    // Thông tin chi tiết hơn (chart, tổng,...)
    Map<String, Object> getRevenueData(Vendor vendor);
}

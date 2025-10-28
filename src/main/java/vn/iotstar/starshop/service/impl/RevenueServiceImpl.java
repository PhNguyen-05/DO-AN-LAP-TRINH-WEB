package vn.iotstar.starshop.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.iotstar.starshop.entity.Vendor;
import vn.iotstar.starshop.repository.OrderRepository;
import vn.iotstar.starshop.service.RevenueService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RevenueServiceImpl implements RevenueService {

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public double getMonthlyRevenue(Vendor vendor, int month, int year) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.with(TemporalAdjusters.lastDayOfMonth()).withHour(23).withMinute(59).withSecond(59);
        // Giả sử tính tổng totalAmount từ orders có status 'Completed'
        // Thực tế cần query sum
        return 0.0; // Thay bằng query thực
    }

    @Override
    public List<Double> getLast6MonthsRevenue(Vendor vendor) {
        List<Double> revenues = new ArrayList<>();
        LocalDate now = LocalDate.now();
        for (int i = 5; i >= 0; i--) {
            LocalDate month = now.minusMonths(i);
            revenues.add(getMonthlyRevenue(vendor, month.getMonthValue(), month.getYear()));
        }
        return revenues;
    }

    @Override
    public Map<String, Object> getRevenueData(Vendor vendor) {
        Map<String, Object> data = new HashMap<>();
        LocalDate now = LocalDate.now();
        data.put("totalRevenue", 0.0); // Tính tổng
        data.put("monthlyRevenue", getMonthlyRevenue(vendor, now.getMonthValue(), now.getYear()));
        data.put("successfulOrders", 0L); // Đếm orders completed
        data.put("months", new ArrayList<>()); // Các tháng
        data.put("revenues", getLast6MonthsRevenue(vendor));
        return data;
    }
}
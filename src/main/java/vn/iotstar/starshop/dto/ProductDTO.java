package vn.iotstar.starshop.dto;

public class ProductDTO {
    private int id;
    private String name;
    private double price;
    private String imageUrl;
    private ShopDTO shop;
    private int discountPercent; // phần trăm giảm giá
    private int soldQuantity;    // số lượng đã bán

    // Constructor mặc định
    public ProductDTO() {}

    // Constructor đầy đủ dùng trong HomeController
    public ProductDTO(int id, String name, double price, String imageUrl, ShopDTO shop, int discount, int sold) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.shop = shop;
        this.discountPercent = discountPercent;
        this.soldQuantity = soldQuantity;
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public ShopDTO getShop() {
        return shop;
    }

    public void setShop(ShopDTO shop) {
        this.shop = shop;
    }

    public int getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(int discountPercent) {
        this.discountPercent = discountPercent;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    // ✅ Thêm tiện ích tính giá sau giảm
    public double getDiscountedPrice() {
        if (discountPercent > 0) {
            return price * (100 - discountPercent) / 100.0;
        }
        return price;
    }
}

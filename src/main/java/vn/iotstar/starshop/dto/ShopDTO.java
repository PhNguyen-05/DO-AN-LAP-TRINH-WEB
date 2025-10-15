package vn.iotstar.starshop.dto;

public class ShopDTO {
    private int id;
    private String name;
    private String logo;
    private String description;

    public ShopDTO() {}

    public ShopDTO(int id, String name, String logo, String description) {
        this.id = id;
        this.name = name;
        this.logo = logo;
        this.description = description;
    }

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

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

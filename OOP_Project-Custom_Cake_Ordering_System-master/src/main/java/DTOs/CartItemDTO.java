package DTOs;

import java.util.List;

/**
 * Data Transfer Object for Cart Items.
 * Demonstrates the OOP principle of Encapsulation.
 */
public class CartItemDTO {
    private int id;
    private int userId;
    private int productId;
    private int quantity;

    // Joined fields for display
    private String productName;
    private String productImage;
    private long productPrice;
    private String categoryName;
    private List<CustomOrderInfoDTO> customDetails;

    public CartItemDTO() {}

    public CartItemDTO(int id, int userId, int productId, int quantity) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public long getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(long productPrice) {
        this.productPrice = productPrice;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<CustomOrderInfoDTO> getCustomDetails() {
        return customDetails;
    }

    public void setCustomDetails(List<CustomOrderInfoDTO> customDetails) {
        this.customDetails = customDetails;
    }
}

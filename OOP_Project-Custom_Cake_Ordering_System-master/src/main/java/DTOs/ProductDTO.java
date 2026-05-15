package DTOs;

import com.example.jooq.tables.records.TblProductsRecord;
import org.jooq.types.UInteger;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ProductDTO {
    private int id;
    private String name;
    private int quantity;
    private String image;
    private String description;
    private Long price;
    private int stockQuantity;
    private int productCategory;
    private String categoryName;
    private boolean customCake;
    
    public ProductDTO() {
    }

    public ProductDTO(int id, String name, int quantity, String image, String description, Long price, int stockQuantity, int productCategory, boolean customCake) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.image = image;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.productCategory = productCategory;
        this.customCake = customCake;
    }

    public ProductDTO(int id, String name, int quantity, String image, String description, Long price, int stockQuantity, int productCategory, String categoryName, boolean customCake) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.image = image;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.productCategory = productCategory;
        this.categoryName = categoryName;
        this.customCake = customCake;
    }

    public ProductDTO(TblProductsRecord x) {
        this.id = x.getProductId();
        this.name = x.getProductName();
        this.quantity = x.getStockQuantity();
        this.image = x.getProductImage();
        this.description = x.getProductDescription();
        this.price = x.getProductPrice();
        this.stockQuantity = x.getStockQuantity();
        this.productCategory = x.getProductCategory();
        this.customCake = x.getCustomCake();
    }

    public TblProductsRecord getRecord() {
        return getRecord(false);
    }

    public TblProductsRecord getRecord(boolean includeID) {
        TblProductsRecord productsRecord =  new TblProductsRecord();
        if(includeID){
            productsRecord.setProductId(id);
        }
        productsRecord.setProductName(name);
        productsRecord.setStockQuantity(stockQuantity);
        productsRecord.setProductImage(image);
        productsRecord.setProductDescription(description);
        productsRecord.setProductCategory(productCategory);
        productsRecord.setProductPrice(price);
        productsRecord.setCustomCake(customCake);
        return productsRecord;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(int productCategory) {
        this.productCategory = productCategory;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public boolean isCustomCake() {
        return customCake;
    }

    public void setCustomCake(boolean customCake) {
        this.customCake = customCake;
    }
}

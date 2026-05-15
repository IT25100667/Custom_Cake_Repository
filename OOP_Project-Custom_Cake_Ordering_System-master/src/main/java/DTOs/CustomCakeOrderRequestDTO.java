package DTOs;

import java.util.Map;

public class CustomCakeOrderRequestDTO {

    private Integer cakeId;

    private Map<Integer, Object> modifiers;

    private String text;

    private Long totalPrice;

    public CustomCakeOrderRequestDTO() {
    }

    public Integer getCakeId() {
        return cakeId;
    }

    public void setCakeId(Integer cakeId) {
        this.cakeId = cakeId;
    }

    public Map<Integer, Object> getModifiers() {
        return modifiers;
    }

    public void setModifiers(Map<Integer, Object> modifiers) {
        this.modifiers = modifiers;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Long totalPrice) {
        this.totalPrice = totalPrice;
    }
}
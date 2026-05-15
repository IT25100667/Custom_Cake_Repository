package models;

import DTOs.CartItemDTO;
import java.util.List;

public class CheckoutState {
    private int currentStep = 1;
    private String firstName;
    private String lastName;
    private String address1;
    private String address2;
    private String city;
    private String phone;
    private String email;
    private String paymentMethod = "cod";
    private List<CartItemDTO> cartItems;
    private double subtotal;
    private double total;

    public void calculateTotals() {
        if (cartItems != null) {
            subtotal = cartItems.stream().mapToDouble(item -> item.getProductPrice() * item.getQuantity()).sum();
            total = subtotal;
        }
    }

    // Getters and Setters
    public int getCurrentStep() { return currentStep; }
    public void setCurrentStep(int currentStep) { this.currentStep = currentStep; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getAddress1() { return address1; }
    public void setAddress1(String address1) { this.address1 = address1; }
    public String getAddress2() { return address2; }
    public void setAddress2(String address2) { this.address2 = address2; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public List<CartItemDTO> getCartItems() { return cartItems; }
    public void setCartItems(List<CartItemDTO> cartItems) { this.cartItems = cartItems; }
    public double getSubtotal() { return subtotal; }
    public double getTotal() { return total; }
}

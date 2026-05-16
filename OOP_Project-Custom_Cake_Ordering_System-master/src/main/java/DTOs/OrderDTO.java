package DTOs;

import com.example.jooq.tables.records.TblCakeOrdersRecord;
import com.example.jooq.tables.records.TblCustomOrderInfoRecord;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.jooq.Record2;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


public class OrderDTO {
    private int orderId;
    private int customerId;
    private int productId;
    private int quantity;
    private LocalDateTime dateOfOrder;
    private String orderStatus;
    private List<CustomOrderInfoDTO> customOrderInfo;
    private UserDTO userInfo;
    private Long totalPrice;

    public OrderDTO() {}

    public OrderDTO(int order_id, int customer_id, int productId, int quantity, LocalDateTime dateOfOrder, String orderStatus, List<CustomOrderInfoDTO> customOrderInfo, Long totalPrice) {
        this.setOrderId(order_id);
        this.setCustomerId(customer_id);
        this.setProductId(productId);
        this.setQuantity(quantity);
        this.setDateOfOrder(dateOfOrder);
        this.setOrderStatus(orderStatus);
        this.setCustomOrderInfo(customOrderInfo);
        this.setTotalPrice(totalPrice);
    }

    public OrderDTO(int order_id, int customer_id, int productId, int quantity, LocalDateTime dateOfOrder, String orderStatus, List<CustomOrderInfoDTO> customOrderInfo, Long totalPrice, UserDTO userInfo) {
        this.setOrderId(order_id);
        this.setCustomerId(customer_id);
        this.setProductId(productId);
        this.setQuantity(quantity);
        this.setDateOfOrder(dateOfOrder);
        this.setOrderStatus(orderStatus);
        this.setCustomOrderInfo(customOrderInfo);
        this.setUserInfo(userInfo);
        this.setTotalPrice(totalPrice);
    }

    public OrderDTO(TblCakeOrdersRecord record){
        this.setOrderId(record.getOrderId());
        this.setCustomerId(record.getCustomerId());
        this.setProductId(record.getProductId());
        this.setQuantity(record.getQuantity());
        this.setTotalPrice(record.getTotalPrice());
        this.setDateOfOrder(record.getDateOfOrder());
        this.setOrderStatus(record.getOrderStatus());
    }

    public OrderDTO(Record2<TblCakeOrdersRecord, TblCustomOrderInfoRecord> tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2) {
        this.setOrderId(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component1().getOrderId());
        this.setCustomerId(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component1().getCustomerId());
        this.setProductId(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component1().getProductId());
        this.setQuantity(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component1().getQuantity());
        this.setDateOfOrder(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component1().getDateOfOrder());
        this.setOrderStatus(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component1().getOrderStatus());

        if (tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component2() != null) {
            ArrayList<CustomOrderInfoDTO> customOrderInfoDTOS = new ArrayList<>();
            customOrderInfoDTOS.add(new CustomOrderInfoDTO(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component2()));
            this.setCustomOrderInfo(customOrderInfoDTOS);
        }
        this.setTotalPrice(tblCakeOrdersRecordTblCustomOrderInfoRecordRecord2.component1().getTotalPrice());

    }

    @JsonIgnore
    public TblCakeOrdersRecord getRecord(){
        return new TblCakeOrdersRecord(getOrderId(), getCustomerId(), getProductId(), getQuantity(), getDateOfOrder(), getOrderStatus(), getTotalPrice());
    }


    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
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

    public LocalDateTime getDateOfOrder() {
        return dateOfOrder;
    }

    public void setDateOfOrder(LocalDateTime dateOfOrder) {
        this.dateOfOrder = dateOfOrder;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<CustomOrderInfoDTO> getCustomOrderInfo() {
        return customOrderInfo;
    }

    public void setCustomOrderInfo(List<CustomOrderInfoDTO> customOrderInfo) {
        this.customOrderInfo = customOrderInfo;
    }

    public UserDTO getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserDTO userInfo) {
        this.customerId = userInfo.id;
        this.userInfo = userInfo;
    }

    public Long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Long totalPrice) {
        this.totalPrice = totalPrice;
    }
}

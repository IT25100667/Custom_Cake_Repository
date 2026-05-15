package com.example.custom_cake_system.data_access;

import DTOs.OrderDTO;

import static com.example.jooq.Tables.TBL_CUSTOM_ORDER_INFO;
import static com.example.jooq.tables.TblCakeOrders.TBL_CAKE_ORDERS;
import com.example.jooq.tables.records.TblCakeOrdersRecord;
import com.example.jooq.tables.records.TblCustomOrderInfoRecord;

import models.Response;
import org.jooq.DSLContext;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.stream.Collectors;

@Repository
public class OrdersRepository extends AbstractRepository {

    public OrdersRepository(DSLContext context) {
        super(context);
    }

    public Response createOrders(List<OrderDTO> orders){
        try{
            int firstOrderId = -1;
            for(OrderDTO order: orders){
                TblCakeOrdersRecord orderRecord = order.getRecord();
                _context.attach(orderRecord);
                orderRecord.store();
                if (firstOrderId == -1) firstOrderId = orderRecord.getOrderId();
                
                if (order.getCustomOrderInfo() != null) {
                    try {
                        TblCustomOrderInfoRecord customRecord = order.getCustomOrderInfo().getRecord();
                        _context.attach(customRecord);
                        customRecord.setOrderId(orderRecord.getOrderId());
                        customRecord.store();
                    } catch (Exception ex) {
                        System.err.println("Warning: Could not save custom order details: " + ex.getMessage());
                        // We allow the order to proceed even if custom details fail, 
                        // to avoid blocking the user.
                    }
                }

            }
            return new Response(true, String.valueOf(firstOrderId));
        }
        catch (Exception ex){
            ex.printStackTrace();
            return new Response(false, "Order failed: " + ex.getMessage());
        }
    }

    public List<OrderDTO> getOrders() {
        return _context.select(TBL_CAKE_ORDERS, TBL_CUSTOM_ORDER_INFO)
                .from(TBL_CAKE_ORDERS)
                .leftJoin(TBL_CUSTOM_ORDER_INFO).on(TBL_CUSTOM_ORDER_INFO.ORDER_ID.eq(TBL_CAKE_ORDERS.ORDER_ID))
                .stream().map(OrderDTO::new).collect(Collectors.toList());
    }

    public List<OrderDTO> getOrdersWithoutCustomOrderDetails() {
        return _context.selectFrom(TBL_CAKE_ORDERS)
                .stream().map(OrderDTO::new).collect(Collectors.toList());
    }

    public List<OrderDTO> getOrders(int userID) {
        return _context.select(TBL_CAKE_ORDERS, TBL_CUSTOM_ORDER_INFO)
                .from(TBL_CAKE_ORDERS)
                .leftJoin(TBL_CUSTOM_ORDER_INFO).on(TBL_CUSTOM_ORDER_INFO.ORDER_ID.eq(TBL_CAKE_ORDERS.ORDER_ID))
                .where(TBL_CAKE_ORDERS.CUSTOMER_ID.eq(userID))

                .stream().map(OrderDTO::new).collect(Collectors.toList());
    }

    public Response deleteOrder(int order_id) {
        try {
            _context.delete(TBL_CUSTOM_ORDER_INFO).where(TBL_CUSTOM_ORDER_INFO.ORDER_ID.eq(order_id)).execute();
            _context.delete(TBL_CAKE_ORDERS).where(TBL_CAKE_ORDERS.ORDER_ID.eq(order_id)).execute();
            return new Response();
        } catch (Exception ex) {
            return new Response(false, ex.getMessage());
        }
    }

    public void updateOrderStatus(int orderId, String orderStatus) {
        _context.update(TBL_CAKE_ORDERS).set(TBL_CAKE_ORDERS.ORDER_STATUS, orderStatus).where(TBL_CAKE_ORDERS.ORDER_ID.eq(orderId)).execute();
    }
}

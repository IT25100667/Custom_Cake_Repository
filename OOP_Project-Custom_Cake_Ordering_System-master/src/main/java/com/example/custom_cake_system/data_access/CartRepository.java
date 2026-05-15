package com.example.custom_cake_system.data_access;

import DTOs.CartItemDTO;
import com.example.jooq.tables.records.TblShoppingCartItemsRecord;
import models.Response;
import org.jooq.DSLContext;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.stream.Collectors;

import static com.example.jooq.tables.TblShoppingCartItems.TBL_SHOPPING_CART_ITEMS;
import static com.example.jooq.tables.TblProducts.TBL_PRODUCTS;
import static com.example.jooq.tables.TblProdCategories.TBL_PROD_CATEGORIES;

/**
 * Repository for Cart management.
 * Extends AbstractRepository to inherit shared database access functionality.
 */
@Repository
public class CartRepository extends AbstractRepository {

    public CartRepository(DSLContext context) {
        super(context);
    }

    public List<CartItemDTO> getCartItems(int userId) {
        return _context.select(
                    TBL_SHOPPING_CART_ITEMS.asterisk(),
                    TBL_PRODUCTS.PRODUCT_NAME,
                    TBL_PRODUCTS.PRODUCT_IMAGE,
                    TBL_PRODUCTS.PRODUCT_PRICE,
                    TBL_PROD_CATEGORIES.CATEGORY_NAME
                )
                .from(TBL_SHOPPING_CART_ITEMS)
                .join(TBL_PRODUCTS).on(TBL_SHOPPING_CART_ITEMS.PRODUCT_ID.eq(TBL_PRODUCTS.PRODUCT_ID))
                .leftJoin(TBL_PROD_CATEGORIES).on(TBL_PRODUCTS.PRODUCT_CATEGORY.eq(TBL_PROD_CATEGORIES.CATEGEORY_ID))
                .where(TBL_SHOPPING_CART_ITEMS.USER_ID.eq(userId))
                .fetch().stream()
                .map(r -> {
                    CartItemDTO dto = new CartItemDTO();
                    dto.setId(r.get(TBL_SHOPPING_CART_ITEMS.ID));
                    dto.setUserId(r.get(TBL_SHOPPING_CART_ITEMS.USER_ID));
                    dto.setProductId(r.get(TBL_SHOPPING_CART_ITEMS.PRODUCT_ID));
                    dto.setQuantity(r.get(TBL_SHOPPING_CART_ITEMS.QUANTITY_ORDERED));
                    dto.setProductName(r.get(TBL_PRODUCTS.PRODUCT_NAME));
                    dto.setProductImage(r.get(TBL_PRODUCTS.PRODUCT_IMAGE));
                    dto.setProductPrice(r.get(TBL_PRODUCTS.PRODUCT_PRICE));
                    dto.setCategoryName(r.get(TBL_PROD_CATEGORIES.CATEGORY_NAME));
                    return dto;
                }).collect(Collectors.toList());
    }

    public Response addItem(int userId, int productId, int quantity) {
        try {
            // Check if item already exists
            TblShoppingCartItemsRecord existing = _context.selectFrom(TBL_SHOPPING_CART_ITEMS)
                    .where(TBL_SHOPPING_CART_ITEMS.USER_ID.eq(userId))
                    .and(TBL_SHOPPING_CART_ITEMS.PRODUCT_ID.eq(productId))
                    .fetchOne();

            if (existing != null) {
                existing.setQuantityOrdered(existing.getQuantityOrdered() + quantity);
                existing.store();
            } else {
                _context.insertInto(TBL_SHOPPING_CART_ITEMS)
                        .set(TBL_SHOPPING_CART_ITEMS.USER_ID, userId)
                        .set(TBL_SHOPPING_CART_ITEMS.PRODUCT_ID, productId)
                        .set(TBL_SHOPPING_CART_ITEMS.QUANTITY_ORDERED, quantity)
                        .execute();
            }
            return new Response(true);
        } catch (Exception ex) {
            return new Response(false, ex.getMessage());
        }
    }

    public Response updateQuantity(int itemId, int quantity) {
        try {
            _context.update(TBL_SHOPPING_CART_ITEMS)
                    .set(TBL_SHOPPING_CART_ITEMS.QUANTITY_ORDERED, quantity)
                    .where(TBL_SHOPPING_CART_ITEMS.ID.eq(itemId))
                    .execute();
            return new Response(true);
        } catch (Exception ex) {
            return new Response(false, ex.getMessage());
        }
    }

    public Response removeItem(int itemId) {
        try {
            _context.delete(TBL_SHOPPING_CART_ITEMS)
                    .where(TBL_SHOPPING_CART_ITEMS.ID.eq(itemId))
                    .execute();
            return new Response(true);
        } catch (Exception ex) {
            return new Response(false, ex.getMessage());
        }
    }

    public void clearCart(int userId) {
        _context.delete(TBL_SHOPPING_CART_ITEMS)
                .where(TBL_SHOPPING_CART_ITEMS.USER_ID.eq(userId))
                .execute();
    }
}

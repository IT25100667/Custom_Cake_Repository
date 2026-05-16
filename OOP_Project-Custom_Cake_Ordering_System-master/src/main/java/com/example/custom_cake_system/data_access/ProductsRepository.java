package com.example.custom_cake_system.data_access;

import DTOs.CustomCakeModifierDTO;
import DTOs.CustomModifierValueDTO;
import models.Response;
import DTOs.ProductDTO;
import org.jooq.DSLContext;
import org.jooq.exception.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.stream.Collectors;

import static com.example.jooq.tables.TblProducts.TBL_PRODUCTS;
import static com.example.jooq.tables.TblProdCategories.TBL_PROD_CATEGORIES;
import static com.example.jooq.tables.TblModifierValues.TBL_MODIFIER_VALUES;
import static com.example.jooq.tables.TblCustomModifiers.TBL_CUSTOM_MODIFIERS;

@Repository
public class ProductsRepository extends AbstractRepository {

    public ProductsRepository(DSLContext context) {
        super(context);
    }

    public Response createProduct(ProductDTO productDTO) {
        try {
            _context.executeInsert(productDTO.getRecord());
            return new Response(true);
        } catch (Exception ex) {
            return new Response(false, ex.getMessage());
        }
    }

    public Response updateProduct(ProductDTO productDTO) {
        try {
            _context.update(TBL_PRODUCTS)
                    .set(productDTO.getRecord(false))
                    .where(TBL_PRODUCTS.PRODUCT_ID.eq(productDTO.getId()))
                    .execute();
            return new Response(true);
        } catch (Exception ex) {
            return new Response(false, ex.getMessage());
        }
    }

    public Response deleteProduct(int id){
        try {
            _context.delete(TBL_PRODUCTS).where(TBL_PRODUCTS.PRODUCT_ID.eq(id)).execute();
            return new Response(true);
        } catch (Exception ex) {
            return new Response(false, ex.getMessage());
        }
    }

    public ProductDTO getProductById(int id) {
        var record = _context.select(TBL_PRODUCTS.asterisk(), TBL_PROD_CATEGORIES.CATEGORY_NAME)
                .from(TBL_PRODUCTS)
                .leftJoin(TBL_PROD_CATEGORIES).on(TBL_PRODUCTS.PRODUCT_CATEGORY.eq(TBL_PROD_CATEGORIES.CATEGEORY_ID))
                .where(TBL_PRODUCTS.PRODUCT_ID.eq(id))
                .fetchOne();
        
        if (record == null) return null;
        
        ProductDTO dto = new ProductDTO(record.into(TBL_PRODUCTS));
        dto.setCategoryName(record.get(TBL_PROD_CATEGORIES.CATEGORY_NAME));
        return dto;
    }

    public List<ProductDTO> getProducts() {
        return _context.select(TBL_PRODUCTS.asterisk(), TBL_PROD_CATEGORIES.CATEGORY_NAME)
                .from(TBL_PRODUCTS)
                .leftJoin(TBL_PROD_CATEGORIES).on(TBL_PRODUCTS.PRODUCT_CATEGORY.eq(TBL_PROD_CATEGORIES.CATEGEORY_ID))
                .fetch().stream()
                .map(r -> {
                    ProductDTO dto = new ProductDTO(r.into(TBL_PRODUCTS));
                    dto.setCategoryName(r.get(TBL_PROD_CATEGORIES.CATEGORY_NAME));
                    return dto;
                }).collect(Collectors.toList());
    }

    public List<ProductDTO> getProducts(String searchTerm) {
        return _context.select(TBL_PRODUCTS.asterisk(), TBL_PROD_CATEGORIES.CATEGORY_NAME)
                .from(TBL_PRODUCTS)
                .leftJoin(TBL_PROD_CATEGORIES).on(TBL_PRODUCTS.PRODUCT_CATEGORY.eq(TBL_PROD_CATEGORIES.CATEGEORY_ID))
                .where(TBL_PRODUCTS.PRODUCT_DESCRIPTION.contains(searchTerm))
                .or(TBL_PRODUCTS.PRODUCT_NAME.contains(searchTerm))
                .fetch().stream()
                .map(r -> {
                    ProductDTO dto = new ProductDTO(r.into(TBL_PRODUCTS));
                    dto.setCategoryName(r.get(TBL_PROD_CATEGORIES.CATEGORY_NAME));
                    return dto;
                }).collect(Collectors.toList());
    }

    public List<ProductDTO> getProductsByCategory(String categoryName) {
        return _context.select(TBL_PRODUCTS.asterisk(), TBL_PROD_CATEGORIES.CATEGORY_NAME)
                .from(TBL_PRODUCTS)
                .leftJoin(TBL_PROD_CATEGORIES).on(TBL_PRODUCTS.PRODUCT_CATEGORY.eq(TBL_PROD_CATEGORIES.CATEGEORY_ID))
                .where(TBL_PROD_CATEGORIES.CATEGORY_NAME.equalIgnoreCase(categoryName))
                .fetch().stream()
                .map(r -> {
                    ProductDTO dto = new ProductDTO(r.into(TBL_PRODUCTS));
                    dto.setCategoryName(r.get(TBL_PROD_CATEGORIES.CATEGORY_NAME));
                    return dto;
                }).collect(Collectors.toList());
    }

    public List<CustomCakeModifierDTO> getAllCustomCakesModifiers() {
        List<CustomCakeModifierDTO> customModifiersRecords = _context.selectFrom(TBL_CUSTOM_MODIFIERS).fetch().stream()
                        .map(CustomCakeModifierDTO::new).toList();

        for(CustomCakeModifierDTO dto: customModifiersRecords){
            List<CustomModifierValueDTO> customCakeModifierDTOS = _context.selectFrom(TBL_MODIFIER_VALUES).where(TBL_MODIFIER_VALUES.MODIFIER_ID.eq(dto.getModifierId()))
                    .fetch().stream()
                    .map(x->{
                        return new CustomModifierValueDTO(x);
                    }).toList();

            dto.setModifierList(customCakeModifierDTOS);
        }
        return customModifiersRecords;
    }

    public List<ProductDTO> getAllCustomCakes() {
        try{
            return _context.selectFrom(TBL_PRODUCTS).where(TBL_PRODUCTS.CUSTOM_CAKE.eq(Boolean.TRUE)).fetch().stream()
                    .map(ProductDTO::new).toList();
        } catch (DataAccessException e) {
            throw new RuntimeException(e);
        }

    }
}

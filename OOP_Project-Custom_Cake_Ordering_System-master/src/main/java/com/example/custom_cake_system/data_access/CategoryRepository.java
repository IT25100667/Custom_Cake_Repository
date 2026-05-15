package com.example.custom_cake_system.data_access;
import DTOs.CategoryDTO;
import models.Response;
import org.jooq.DSLContext;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.stream.Collectors;

import static com.example.jooq.tables.TblProdCategories.TBL_PROD_CATEGORIES;

@Repository
public class CategoryRepository extends AbstractRepository {

    public CategoryRepository(DSLContext context) {
        super(context);
    }

    public Response addNewCategory(String name){
        try{
            _context.insertInto(TBL_PROD_CATEGORIES).columns(TBL_PROD_CATEGORIES.CATEGORY_NAME).values(name).execute();
            return new Response();
        }
        catch (Exception ex){
            return new Response(false, ex.getMessage());
        }
    }

    public Response updateCategory(int id, String name){
        try{
            _context.update(TBL_PROD_CATEGORIES).set(TBL_PROD_CATEGORIES.CATEGORY_NAME,name)
                    .where(TBL_PROD_CATEGORIES.CATEGEORY_ID.eq(id)).execute();
            return new Response();
        }
        catch (Exception ex){
            return new Response(false, ex.getMessage());
        }
    }

    public Response deleteCategory(int id){
        try{
            _context.delete(TBL_PROD_CATEGORIES).where(TBL_PROD_CATEGORIES.CATEGEORY_ID.eq(id)).execute();
            return new Response();
        }
        catch (Exception ex){
            return new Response(false, ex.getMessage());
        }
    }

    public Response deleteCategory(String name){
        try{
            _context.delete(TBL_PROD_CATEGORIES).where(TBL_PROD_CATEGORIES.CATEGORY_NAME.eq(name)).execute();
            return new Response();
        }
        catch (Exception ex){
            return new Response(false, ex.getMessage());
        }
    }

    public List<CategoryDTO> getCategories(){
        return _context.selectFrom(TBL_PROD_CATEGORIES)
                .stream().toList().stream()
                .map(x->new CategoryDTO(x)).collect(Collectors.toList());
    }

    public List<CategoryDTO> getCategories(int id){
        return _context.selectFrom(TBL_PROD_CATEGORIES)
                .where(TBL_PROD_CATEGORIES.CATEGEORY_ID.eq(id))
                .stream()
                .map(CategoryDTO::new).collect(Collectors.toList());
    }

    public List<CategoryDTO> getCategories(String name){
        return _context.selectFrom(TBL_PROD_CATEGORIES)
                .where(TBL_PROD_CATEGORIES.CATEGORY_NAME.eq(name))
                .stream()
                .map(CategoryDTO::new).collect(Collectors.toList());
    }
}

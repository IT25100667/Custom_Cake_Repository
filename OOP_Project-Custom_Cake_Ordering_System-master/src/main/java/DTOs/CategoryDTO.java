package DTOs;

import com.example.jooq.tables.records.TblProdCategoriesRecord;

public class CategoryDTO {
    public Integer id;
    public String name;

    public CategoryDTO(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    public CategoryDTO(TblProdCategoriesRecord x) {
        this.id = x.getCategeoryId();
        this.name = x.getCategoryName();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

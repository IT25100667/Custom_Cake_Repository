package com.example.custom_cake_system.utlity;

import DTOs.CategoryDTO;
import com.example.custom_cake_system.data_access.CategoryRepository;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalModelAttributes {

    private final CategoryRepository categoryRepository;

    public GlobalModelAttributes(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @ModelAttribute("categories")
    public List<CategoryDTO> categories(){
        return categoryRepository.getCategories().stream()
                .filter(c -> !c.name.equalsIgnoreCase("Add-ons") && !c.name.equalsIgnoreCase("Addons"))
                .toList();
    }
}

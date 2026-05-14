package com.example.custom_cake_system.services;

import DTOs.CategoryDTO;
import DTOs.ProductDTO;
import com.example.custom_cake_system.data_access.CategoryRepository;
import com.example.custom_cake_system.data_access.ProductsRepository;
import models.Response;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service layer for Product-related business logic.
 * Follows the OOP principle of Layered Architecture and Encapsulation.
 */
@Service
public class ProductService {

    private final ProductsRepository productsRepository;
    private final CategoryRepository categoryRepository;

    public ProductService(ProductsRepository productsRepository, CategoryRepository categoryRepository) {
        this.productsRepository = productsRepository;
        this.categoryRepository = categoryRepository;
    }

    public List<ProductDTO> getAllProducts() {
        return productsRepository.getProducts();
    }

    public ProductDTO getProductById(int id) {
        return productsRepository.getProductById(id);
    }

    public List<CategoryDTO> getAvailableCategories() {
        return categoryRepository.getCategories().stream()
                .filter(c -> !c.name.equalsIgnoreCase("Add-ons") && !c.name.equalsIgnoreCase("Addons"))
                .collect(Collectors.toList());
    }

    public Response saveProduct(ProductDTO productDTO, MultipartFile image) {
        if (image != null && !image.isEmpty()) {
            String imagePath = saveImage(image);
            if (!imagePath.isEmpty()) {
                productDTO.setImage(imagePath);
            }
        }

        if (productDTO.getId() > 0) {
            return productsRepository.updateProduct(productDTO);
        } else {
            return productsRepository.createProduct(productDTO);
        }
    }

    public Response deleteProduct(int id) {
        return productsRepository.deleteProduct(id);
    }

    private String saveImage(MultipartFile image) {
        try {
            String uploadDir = "images/products/";
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            String fileName = System.currentTimeMillis() + "_" + image.getOriginalFilename();
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(image.getInputStream(), filePath);
            return "/images/products/" + fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
    }
}

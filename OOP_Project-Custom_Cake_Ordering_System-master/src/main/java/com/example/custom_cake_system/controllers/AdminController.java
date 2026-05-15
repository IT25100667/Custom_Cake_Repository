package com.example.custom_cake_system.controllers;

import DTOs.ProductDTO;
import com.example.custom_cake_system.services.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/admin")
@Controller()
public class AdminController {

    private final com.example.custom_cake_system.services.OrderService orderService;
    private final ProductService productService;

    public AdminController(com.example.custom_cake_system.services.OrderService orderService, ProductService productService) {
        this.orderService = orderService;
        this.productService = productService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model){
        var orders = orderService.getAllOrders();
        var products = productService.getAllProducts();
        
        model.addAttribute("orders", orders);
        model.addAttribute("products", products);
        model.addAttribute("totalPrice", orders.stream()
                .mapToDouble(obj -> obj.getTotalPrice() != null ? obj.getTotalPrice() : 0.0)
                .sum());
        return "admin/dashboard";
    }

    @PostMapping("/order/delete")
    public String deleteOrder(@RequestParam("orderId") int orderId) {
        orderService.deleteOrder(orderId);
        return "redirect:/admin/dashboard";
    }


    @GetMapping("/product/add")
    public String addProduct(Model model) {
        model.addAttribute("categories", productService.getAvailableCategories());
        return "admin/product-add";
    }

    @PostMapping("/product/add")
    public String saveProduct(
            @RequestParam("name") String name,
            @RequestParam("category") int categoryId,
            @RequestParam("price") double price,
            @RequestParam("stock") int stock,
            @RequestParam("description") String description,
            @RequestParam("image") MultipartFile image) {
        
        ProductDTO productDTO = new ProductDTO(0, name, stock, "", description, (long) price, stock, categoryId, false);
        productService.saveProduct(productDTO, image);

        return "redirect:/admin/dashboard";
    }

    @GetMapping("/product/edit")
    public String editProduct(@RequestParam("id") int id, Model model) {
        ProductDTO product = productService.getProductById(id);
        if (product == null) {
            return "redirect:/admin/dashboard";
        }
        model.addAttribute("product", product);
        model.addAttribute("categories", productService.getAvailableCategories());
        return "admin/product-edit";
    }

    @PostMapping("/product/edit")
    public String updateProduct(
            @RequestParam("productId") int id,
            @RequestParam("name") String name,
            @RequestParam("category") int categoryId,
            @RequestParam("price") double price,
            @RequestParam("stock") int stock,
            @RequestParam("description") String description,
            @RequestParam(value = "image", required = false) MultipartFile image) {

        ProductDTO productDTO = productService.getProductById(id);
        if (productDTO != null) {
            productDTO.setName(name);
            productDTO.setProductCategory(categoryId);
            productDTO.setPrice((long) price);
            productDTO.setStockQuantity(stock);
            productDTO.setDescription(description);
            
            productService.saveProduct(productDTO, image);
        }

        return "redirect:/admin/dashboard";
    }

    @GetMapping({"/products", "/orders"})
    public String adminRedirect() {
        return "redirect:/admin/dashboard";
    }
}

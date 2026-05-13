package com.example.custom_cake_system.controllers;
import com.example.custom_cake_system.data_access.ProductsRepository;
import DTOs.ProductDTO;
import com.example.custom_cake_system.data_access.UsersRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;

@RequestMapping({"","/"})
@Controller
public class HomeController {


    private ProductsRepository productsRepository;
    private UsersRepository usersRepository;

    public HomeController(ProductsRepository productsRepository, UsersRepository usersRepository) {
        this.productsRepository = productsRepository;
        this.usersRepository = usersRepository;
    }

    @GetMapping({"/home","","/"})
    public String Home(Model model){
        model.addAttribute("birthdayCakes", productsRepository.getProductsByCategory("birthday"));
        model.addAttribute("weddingCakes", productsRepository.getProductsByCategory("wedding"));
        model.addAttribute("anniversaryCakes", productsRepository.getProductsByCategory("anniversary"));
        model.addAttribute("sweets", productsRepository.getProductsByCategory("sweets"));
        
        // Limit total products for the hero/featured section
        List<ProductDTO> allProducts = productsRepository.getProducts();
        model.addAttribute("products", allProducts.size() > 8 ? allProducts.subList(0, 8) : allProducts);
        
        return "home/index";
    }

    @GetMapping({"/about","/about/"})
    public String About(Model model){
        return "home/about";
    }

    @GetMapping({"/contact","/contact/"})
    public String Contact(Model model){
        return "home/contact";
    }

    @GetMapping({"/cart","/cart/"})
    public String Cart(Model model){
        return "home/cart";
    }

    @GetMapping({"/search","/search/"})
    public String Search(
            @org.springframework.web.bind.annotation.RequestParam(value = "category", required = false) String category,
            @org.springframework.web.bind.annotation.RequestParam(value = "q", required = false) String query,
            Model model){
        List<ProductDTO> products;
        
        if (query != null && !query.isEmpty()) {
            products = productsRepository.getProducts(query);
            model.addAttribute("searchTerm", query);
        } else if (category != null && !category.isEmpty() && !category.equals("all")) {
            products = productsRepository.getProductsByCategory(category);
        } else {
            products = productsRepository.getProducts();
        }
        
        model.addAttribute("products", products);
        model.addAttribute("selectedCategory", category != null ? category : "all");
        return "home/search";
    }

    @GetMapping("/order-confirmation")
    public String orderConfirmation(@org.springframework.web.bind.annotation.RequestParam(value = "orderId", required = false) String orderId, Model model){
        model.addAttribute("orderId", orderId);
        return "home/order-confirmation";
    }
}

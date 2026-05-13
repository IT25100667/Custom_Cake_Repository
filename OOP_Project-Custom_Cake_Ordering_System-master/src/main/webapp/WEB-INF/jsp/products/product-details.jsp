<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>\${product.name} | Sweet Pan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/styles.css">
    <style>
        .product-details-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            margin: 8rem auto 5rem;
            align-items: start;
        }

        .product-image-container {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            background: hsl(var(--clr-surface-dim));
            position: sticky;
            top: 100px;
        }

        .product-main-image {
            width: 100%;
            height: auto;
            display: block;
            object-fit: cover;
            aspect-ratio: 1 / 1;
        }

        .product-info-container {
            padding: 1rem 0;
        }

        .product-category {
            color: hsl(var(--clr-primary));
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            display: block;
        }

        .product-title {
            font-family: var(--font-serif);
            font-size: 3rem;
            line-height: 1.2;
            margin-bottom: 1rem;
            color: hsl(var(--clr-text-dark));
        }

        .product-price {
            font-size: 2rem;
            font-weight: 700;
            color: hsl(var(--clr-primary));
            margin-bottom: 2rem;
        }

        .product-description {
            font-size: 1.1rem;
            line-height: 1.8;
            color: hsl(var(--clr-text-dark) / 0.7);
            margin-bottom: 2.5rem;
        }

        .add-to-cart-form {
            background: hsl(var(--clr-surface));
            padding: 2rem;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            gap: 1rem;
        }

        .quantity-label {
            font-weight: 600;
            color: hsl(var(--clr-text-dark));
        }

        .qty-control {
            display: flex;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 50px;
            overflow: hidden;
            width: fit-content;
        }

        .qty-btn {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            background: hsl(var(--clr-surface-dim));
            border: none;
            transition: background var(--transition-fast);
        }

        .qty-btn:hover {
            background: rgba(0,0,0,0.1);
        }

        .qty-val {
            width: 50px;
            text-align: center;
            border: none;
            font-family: var(--font-sans);
            font-weight: 600;
            font-size: 1.1rem;
            outline: none;
            background: transparent;
        }

        .btn-add-cart {
            width: 100%;
            padding: 1.2rem;
            font-size: 1.2rem;
            justify-content: center;
            gap: 0.5rem;
        }

        .product-features {
            margin-top: 3rem;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .feature-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: hsl(var(--clr-primary) / 0.1);
            color: hsl(var(--clr-primary));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        @media (max-width: 992px) {
            .product-details-layout {
                grid-template-columns: 1fr;
                gap: 2rem;
                margin-top: 6rem;
            }
            .product-image-container {
                position: relative;
                top: 0;
            }
        }
    </style>
</head>

<body>

    <!-- Fixed Navbar -->
    <nav class="navbar">
        <div class="container nav-container">
            <a href="/home" class="nav-logo">Sweet Pan.</a>
            <ul class="nav-links">
                <li><a href="/home" class="nav-link">Home</a></li>
                <li class="nav-item-dropdown">
                    <a href="#" class="nav-link">Categories <i class="fa-solid fa-chevron-down" style="font-size: 0.8rem; margin-left: 4px;"></i></a>
                    <div class="dropdown-menu">
                        <a href="/search?category=birthday" class="dropdown-item">Birthday Cakes</a>
                        <a href="/search?category=wedding" class="dropdown-item">Wedding Cakes</a>
                        <a href="/search?category=anniversary" class="dropdown-item">Anniversary</a>
                    </div>
                </li>
                <li><a href="/products/custom-cakes" class="nav-link">Custom Cakes</a></li>
            </ul>
            <div class="nav-actions">
                <a href="/user/profile" class="icon-btn" title="Profile">
                    <i class="fa-solid fa-user"></i>
                </a>
                <sec:authorize access="!hasRole('1')">
                    <a href="/cart" class="icon-btn" title="Cart">
                        <i class="fa-solid fa-bag-shopping"></i>
                    </a>
                </sec:authorize>
            </div>
        </div>
    </nav>

    <main class="container">
        <div class="product-details-layout">
            <!-- Left: Image -->
            <div class="product-image-container">
                <img src="${product.image != null ? product.image : 'https://placehold.co/800x800?text=Sweet+Treat'}" alt="${product.name}" class="product-main-image">
            </div>

            <!-- Right: Details -->
            <div class="product-info-container">
                <span class="product-category">${product.categoryName}</span>
                <h1 class="product-title">${product.name != null ? product.name : 'Delicious Signature Cake'}</h1>
                
                <div class="product-price">
                    <fmt:setLocale value="en_LK"/>
                    <fmt:formatNumber value="\${product.price != null ? product.price : 0.00}" type="currency" currencySymbol="LKR "/>
                </div>

                <p class="product-description">
                    \${product.description != null ? product.description : 'Indulge in our beautifully crafted premium cake, made with the finest ingredients and baked to perfection. Perfect for making any celebration memorable and sweet.'}
                </p>

                <div class="add-to-cart-form">
                    <form action="/cart/add" method="POST">
                        <input type="hidden" name="productId" value="\${product.id}">
                        
                        <div class="quantity-selector">
                            <span class="quantity-label">Quantity:</span>
                            <div class="qty-control">
                                <button type="button" class="qty-btn" onclick="decreaseQty()">-</button>
                                <input type="number" id="qty" name="quantity" class="qty-val" value="1" min="1" max="10" readonly>
                                <button type="button" class="qty-btn" onclick="increaseQty()">+</button>
                            </div>
                            <span style="color: hsl(var(--clr-text-dark) / 0.5); font-size: 0.9rem; margin-left: auto;">
                                ${product.stockQuantity > 0 ? 'In Stock' : 'Out of Stock'}
                            </span>
                        </div>

                        <button type="submit" class="btn btn-primary btn-add-cart" ${product.stockQuantity <= 0 ? 'disabled' : ''}>
                            <i class="fa-solid fa-cart-plus"></i> Add to Cart
                        </button>
                    </form>
                </div>

                <div class="product-features">
                    <div class="feature-item">
                        <div class="feature-icon"><i class="fa-solid fa-leaf"></i></div>
                        <div>
                            <h4 style="font-size: 1rem; margin-bottom: 0.2rem;">Fresh Ingredients</h4>
                            <p style="font-size: 0.85rem; color: #666;">Locally sourced & premium</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <div class="feature-icon"><i class="fa-solid fa-truck-fast"></i></div>
                        <div>
                            <h4 style="font-size: 1rem; margin-bottom: 0.2rem;">Fast Delivery</h4>
                            <p style="font-size: 0.85rem; color: #666;">Within 24 hours available</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <h3>Sweet Pan.</h3>
                    <p>Baking happiness and premium quality treats for every special occasion.</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 Sweet Pan. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        function increaseQty() {
            let input = document.getElementById('qty');
            if (parseInt(input.value) < parseInt(input.max)) {
                input.value = parseInt(input.value) + 1;
            }
        }

        function decreaseQty() {
            let input = document.getElementById('qty');
            if (parseInt(input.value) > parseInt(input.min)) {
                input.value = parseInt(input.value) - 1;
            }
        }
    </script>
</body>
</html>

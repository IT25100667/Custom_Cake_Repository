<!DOCTYPE html>
<html lang="en">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:styles />
<t:header />
<!--Simply importing all the tags(templates) stored in the tags folder into the main jsp file--!>


<section class="hero">
    <div class="hero-bg"></div>
    <div class="container hero-grid">
        <div class="hero-content">
            <h1>Crafting Sweet Memories</h1>
            <p>Indulge in our exquisite collection of premium cakes, or design your own masterpiece tailored for your perfect moment.</p>
            <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                <a href="#popular" class="btn btn-primary">
                    Shop Signature Cakes <i class="fa-solid fa-arrow-right"></i>
                </a>
                <a href="/products/custom-cakes" class="btn btn-outline">
                    Design a Custom Cake
                </a>
            </div>
        </div>
        <div class="hero-image-wrapper">
            <!-- Fallback to a nice unsplash image since we don't have local assets yet -->
            <img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?ixlib=rb-4.0.3&auto=format&fit=crop&w=1089&q=80" alt="Exquisite Chocolate Layer Cake" class="hero-image">
            <div class="hero-decoration"></div>
        </div>
    </div>
</section>

<!-- Popular Items Section (Featured) -->
<section id="popular" class="container">
    <div class="text-center">
        <h2 class="section-title">Most Loved Creations</h2>
        <p class="section-subtitle">Our handpicked selection of signature cakes.</p>
    </div>

    <div class="product-grid" id="popular-grid">
        <c:forEach var="product" items="${products}">
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${product.image}" alt="${product.name}" class="product-img">
                </div>
                <div class="product-info">
                    <span class="product-category">${product.categoryName}</span>
                    <h3 class="product-title"> ${product.name} </h3>
                    <p class="product-price">LKR ${product.price}</p>
                    <div class="product-actions">
                        <button class="btn btn-outline" style="flex: 1;"
                            onclick="addToCart({id: '${product.id}', title: '${product.name}', price: ${product.price}, image: '${product.image}'})">
                            Add to Cart
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<!-- Birthday Cakes Section -->
<c:if test="${not empty birthdayCakes}">
    <section class="container">
        <div class="text-center">
            <h2 class="section-title">Birthday Collection</h2>
            <p class="section-subtitle">Make their special day even sweeter.</p>
        </div>
        <div class="product-grid">
            <c:forEach var="product" items="${birthdayCakes}">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <img src="${product.image}" alt="${product.name}" class="product-img">
                    </div>
                    <div class="product-info">
                        <span class="product-category">${product.categoryName}</span>
                        <h3 class="product-title"> ${product.name} </h3>
                        <p class="product-price">LKR ${product.price}</p>
                        <div class="product-actions">
                            <button class="btn btn-outline" style="flex: 1;"
                                onclick="addToCart({id: '${product.id}', title: '${product.name}', price: ${product.price}, image: '${product.image}'})">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</c:if>

<!-- Wedding & Anniversary Cakes Section -->
<c:if test="${not empty weddingCakes or not empty anniversaryCakes}">
    <section class="container">
        <div class="text-center">
            <h2 class="section-title">Celebration Cakes</h2>
            <p class="section-subtitle">Elegant designs for weddings and anniversaries.</p>
        </div>
        <div class="product-grid">
            <c:forEach var="product" items="${weddingCakes}">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <img src="${product.image}" alt="${product.name}" class="product-img">
                    </div>
                    <div class="product-info">
                        <span class="product-category">${product.categoryName}</span>
                        <h3 class="product-title"> ${product.name} </h3>
                        <p class="product-price">LKR ${product.price}</p>
                        <div class="product-actions">
                            <button class="btn btn-outline" style="flex: 1;"
                                onclick="addToCart({id: '${product.id}', title: '${product.name}', price: ${product.price}, image: '${product.image}'})">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:forEach var="product" items="${anniversaryCakes}">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <img src="${product.image}" alt="${product.name}" class="product-img">
                    </div>
                    <div class="product-info">
                        <span class="product-category">${product.categoryName}</span>
                        <h3 class="product-title"> ${product.name} </h3>
                        <p class="product-price">LKR ${product.price}</p>
                        <div class="product-actions">
                            <button class="btn btn-outline" style="flex: 1;"
                                onclick="addToCart({id: '${product.id}', title: '${product.name}', price: ${product.price}, image: '${product.image}'})">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</c:if>

<!-- Sweets & Treats Section -->
<c:if test="${not empty sweets}">
    <section class="container" style="background-color: hsl(var(--clr-surface)); padding: 6rem 2rem; border-radius: 40px; margin-bottom: 4rem;">
        <div class="text-center">
            <h2 class="section-title">Sweets & Treats</h2>
            <p class="section-subtitle">Macarons, cupcakes, and delightful assortments.</p>
        </div>
        <div class="product-grid">
            <c:forEach var="product" items="${sweets}">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <img src="${product.image}" alt="${product.name}" class="product-img">
                    </div>
                    <div class="product-info">
                        <span class="product-category">${product.categoryName}</span>
                        <h3 class="product-title"> ${product.name} </h3>
                        <p class="product-price">LKR ${product.price}</p>
                        <div class="product-actions">
                            <button class="btn btn-outline" style="flex: 1;"
                                onclick="addToCart({id: '${product.id}', title: '${product.name}', price: ${product.price}, image: '${product.image}'})">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</c:if>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-brand">
                <h3>Sweet Pan.</h3>

                <p>Baking happiness and premium quality treats for every special occasion. Design your own, or choose from our signature collections.</p>
                <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                    <a href="#" style="color: white; font-size: 1.5rem;"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" style="color: white; font-size: 1.5rem;"><i class="fa-brands fa-facebook"></i></a>
                    <a href="#" style="color: white; font-size: 1.5rem;"><i class="fa-brands fa-pinterest"></i></a>
                </div>
            </div>
            <div>
                <h4 class="footer-title">Shop</h4>
                <div class="footer-links">
                    <a href="/search?category=all">All Products</a>
                    <a href="/products/custom-cakes">Custom Cakes</a>
                    <a href="/search?category=wedding">Wedding Collection</a>
                    <a href="/search?category=sweets">Sweets</a>
                </div>
            </div>
            <div>
                <h4 class="footer-title">Company</h4>
                <div class="footer-links">
                    <a href="/about">About Us</a>
                    <a href="/contact">Contact</a>

                </div>
            </div>

            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 Sweet Pan. All rights reserved.</p>

        </div>
    </div>
</footer>

<script src="/js/main.js"></script>

</body>
</html>

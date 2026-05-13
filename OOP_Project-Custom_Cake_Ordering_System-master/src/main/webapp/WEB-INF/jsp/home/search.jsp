<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop Collection | Sweet Pan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/styles.css">
    <style>
        .page-header {
            background: linear-gradient(135deg, hsl(var(--clr-primary)) 0%, #4a1538 100%);
            color: white;
            padding: 8rem 0 4rem;
            text-align: center;
            border-radius: 0 0 50px 50px;
            margin-bottom: 4rem;
        }

        .filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .filter-tags {
            display: flex;
            gap: 0.8rem;
            overflow-x: auto;
            padding-bottom: 0.5rem;
        }

        .filter-tag {
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            background: hsl(var(--clr-surface));
            border: 1px solid rgba(0, 0, 0, 0.1);
            color: hsl(var(--clr-text-dark));
            cursor: pointer;
            white-space: nowrap;
            transition: all var(--transition-fast);
        }

        .filter-tag:hover,
        .filter-tag.active {
            background: hsl(var(--clr-primary));
            color: hsl(var(--clr-text-light));
            border-color: hsl(var(--clr-primary));
        }

        .search-results {
            min-height: 50vh;
        }

        .no-results {
            text-align: center;
            padding: 4rem 2rem;
            color: hsl(var(--clr-text-dark) / 0.6);
            grid-column: 1 / -1;
        }
    </style>
</head>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:styles />
<t:header />
<body>

    <header class="page-header">
        <div class="container">
            <h1 id="page-title" style="color: white; font-size: clamp(2.5rem, 4vw, 4rem); margin-bottom: 0.5rem;">
                <c:choose>
                    <c:when test="${not empty searchTerm}">Results for "${searchTerm}"</c:when>
                    <c:when test="${selectedCategory == 'birthday'}">Birthday Cakes</c:when>
                    <c:when test="${selectedCategory == 'wedding'}">Wedding Cakes</c:when>
                    <c:when test="${selectedCategory == 'anniversary'}">Anniversary Cakes</c:when>
                    <c:when test="${selectedCategory == 'sweets'}">Sweets & Treats</c:when>
                    <c:otherwise>All Products</c:otherwise>
                </c:choose>
            </h1>
            <p style="font-size: 1.2rem; opacity: 0.9;">Discover the perfect treat for any occasion.</p>
            
            <sec:authorize access="hasRole('1')">
                <div style="margin-top: 2rem;">
                    <a href="/admin/product/add" class="btn btn-accent" style="display: inline-flex; align-items: center; gap: 0.5rem; background: #fff; color: hsl(var(--clr-primary));">
                        <i class="fa-solid fa-plus"></i> Add New Product
                    </a>
                </div>
            </sec:authorize>
        </div>
    </header>

    <main class="container search-results">

        <div class="filter-bar">
            <div class="filter-tags" id="filter-tags">
                <a href="/search?category=all" class="filter-tag ${selectedCategory == 'all' ? 'active' : ''}">All Items</a>
                <c:forEach var="cat" items="${categories}">
                    <a href="/search?category=${cat.name}" class="filter-tag ${selectedCategory == cat.name ? 'active' : ''}">${cat.name}</a>
                </c:forEach>
            </div>

        </div>

        <div class="product-grid" id="search-grid">
            <c:forEach var="product" items="${products}">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <img src="${product.image}" alt="${product.name}" class="product-img">
                    </div>
                    <div class="product-info">
                        <span class="product-category">${product.categoryName}</span>
                        <h3 class="product-title">${product.name}</h3>
                        <p class="product-price">LKR ${product.price}</p>
                        <div class="product-actions">
                            <button
                                class="btn btn-outline"
                                style="flex: 1;"
                                onclick="addToCart({id: '${product.id}', title: '${product.name}', price: ${product.price}, image: '${product.image}'})">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty products}">
                <div class="no-results">
                    <i class="fa-solid fa-cake-candles" style="font-size: 3rem; opacity: 0.3; margin-bottom: 1rem;"></i>
                    <h3>No products found in this category.</h3>
                    <p>Try exploring our other delicious collections!</p>
                </div>
            </c:if>
        </div>

    </main>

    <!-- Footer -->
    <footer class="footer">
        <!-- Kept consistent footer -->
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

    <script src="/js/main.js"></script>
    <script src="/js/search.js"></script>
</body>

</html>
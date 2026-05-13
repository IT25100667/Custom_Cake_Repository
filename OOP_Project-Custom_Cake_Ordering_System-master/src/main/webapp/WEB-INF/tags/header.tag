<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!-- Fixed Navbar -->
<nav class="navbar">
    <div class="container nav-container">
        <a href="/" class="nav-logo">Sweet Pan.</a>


        <ul class="nav-links">
            <sec:authorize access="hasRole('0')">
               <li><a href="/" class="nav-link active">Home</a></li>
            </sec:authorize>
            <li class="nav-item-dropdown">
                <a href="#" class="nav-link">Categories <i class="fa-solid fa-chevron-down" style="font-size: 0.8rem; margin-left: 4px;"></i></a>
                <div class="dropdown-menu">
                    <c:forEach var="category" items="${categories}">
                           <a href="/search?category=${category.name}" class="dropdown-item" data-category="${category.name}">
                               ${category.name}
                           </a>
                    </c:forEach>

                </div>
            </li>
            <sec:authorize access="hasRole('0')">
                <li><a href="/products/custom-cakes" class="nav-link">Custom Cakes</a></li>
                <li><a href="/about" class="nav-link">About</a></li>
                <li><a href="/contact" class="nav-link">Contact</a></li>
            </sec:authorize>
            <sec:authorize access="hasRole('1')">
                <li><a href="/admin/dashboard" class="nav-link">Admin</a></li>
                <li><a href="/admin/product/add" class="nav-link">Upload Cake</a></li>
            </sec:authorize>


            <sec:authorize access="!isAuthenticated()">
                <li><a href="/user/login" class="nav-link">Login</a></li>
                <li><a href="/user/signup" class="nav-link">Sign Up</a></li>
            </sec:authorize>
            <sec:authorize access="hasRole('0')">
                <li><a href="/user/profile" class="nav-link">My Profile</a></li>
                <li><a href="/logout" class="nav-link" style="color: #ef4444;">Logout</a></li>
            </sec:authorize>

        </ul>

        <div class="nav-actions">
            <form action="/search" method="get" class="search-form" style="display: flex; align-items: center; background: hsl(var(--clr-surface)); padding: 0.4rem 0.8rem; border-radius: 50px; border: 1px solid rgba(0,0,0,0.1);">
                <input type="text" name="q" placeholder="Search cakes..." style="border: none; background: transparent; outline: none; font-size: 0.9rem; width: 120px;">
                <button type="submit" style="background: transparent; border: none; cursor: pointer; color: hsl(var(--clr-text-dark) / 0.5);">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </form>
            <a href="/user/profile" class="icon-btn" title="Profile">
                <i class="fa-regular fa-user"></i>
            </a>
            <sec:authorize access="!hasRole('1')">
                <a href="/cart" class="icon-btn" title="Cart">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <span class="cart-badge" style="display: none;">0</span>
                </a>
            </sec:authorize>
        </div>

        <!-- Mobile Menu Toggle -->
        <button class="mobile-toggle">
            <i class="fa-solid fa-bars"></i>
        </button>
    </div>
</nav>
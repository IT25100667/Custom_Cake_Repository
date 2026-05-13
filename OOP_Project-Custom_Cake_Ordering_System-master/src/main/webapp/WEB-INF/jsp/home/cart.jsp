<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart | Sweet Pan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/styles.css">
    <style>
        .page-header {
            background: hsl(var(--clr-surface-dim));
            padding: 8rem 0 3rem;
            text-align: center;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            margin-bottom: 3rem;
        }

        .cart-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 3rem;
            align-items: start;
            margin-bottom: 5rem;
        }

        /* Cart Items */
        .cart-items {
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            padding: 2rem;
        }

        .cart-item {
            display: flex;
            gap: 1.5rem;
            padding: 1.5rem 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
        }

        .cart-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .cart-item-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 12px;
            background: hsl(var(--clr-surface-dim));
        }

        .cart-item-details {
            flex-grow: 1;
        }

        .cart-item-title {
            font-size: 1.25rem;
            font-family: var(--font-sans);
            margin-bottom: 0.2rem;
        }

        .cart-item-category {
            font-size: 0.85rem;
            color: hsl(var(--clr-text-dark) / 0.6);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }

        .cart-item-custom-props {
            font-size: 0.9rem;
            color: hsl(var(--clr-primary));
            background: hsl(var(--clr-primary) / 0.05);
            padding: 0.5rem;
            border-radius: 6px;
            margin-top: 0.5rem;
            display: inline-block;
        }

        .cart-item-price {
            font-weight: 700;
            font-size: 1.2rem;
            color: hsl(var(--clr-primary));
            margin-top: 0.5rem;
        }

        .cart-item-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-top: 1rem;
        }

        .qty-control {
            display: flex;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 50px;
            overflow: hidden;
            background: hsl(var(--clr-surface));
        }

        .qty-btn {
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background var(--transition-fast);
        }

        .qty-btn:hover {
            background: hsl(var(--clr-surface-dim));
        }

        .qty-val {
            width: 40px;
            text-align: center;
            border: none;
            font-family: var(--font-sans);
            font-weight: 500;
            outline: none;
            background: transparent;
        }

        .btn-remove {
            color: hsl(var(--clr-text-dark) / 0.4);
            font-size: 1.2rem;
            transition: color var(--transition-fast);
        }

        .btn-remove:hover {
            color: #ef4444;
            /* red */
        }

        /* Order Summary */
        .order-summary {
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            padding: 2rem;
            position: sticky;
            top: 100px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: hsl(var(--clr-text-dark) / 0.8);
        }

        .summary-total {
            font-size: 1.5rem;
            font-weight: 700;
            color: hsl(var(--clr-primary));
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
        }

        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-icon {
            font-size: 4rem;
            color: hsl(var(--clr-primary) / 0.2);
            margin-bottom: 1.5rem;
        }

        @media (max-width: 992px) {
            .cart-layout {
                grid-template-columns: 1fr;
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
                    <a href="#" class="nav-link">Categories <i class="fa-solid fa-chevron-down"
                            style="font-size: 0.8rem; margin-left: 4px;"></i></a>
                    <div class="dropdown-menu">
                        <a href="/search?category=birthday" class="dropdown-item">Birthday Cakes</a>
                        <a href="/search?category=wedding" class="dropdown-item">Wedding Cakes</a>
                        <a href="/search?category=anniversary" class="dropdown-item">Anniversary</a>
                        <a href="/search?category=sweets" class="dropdown-item">Sweets & Treats</a>
                    </div>
                </li>
                <li><a href="/products/custom-cakes" class="nav-link">Custom Cakes</a></li>
                <li><a href="/about" class="nav-link">About</a></li>
                <li><a href="/contact" class="nav-link">Contact</a></li>
                <li><a href="/user/login" class="nav-link">Login</a></li>
            </ul>

            <div class="nav-actions">
                <a href="#" class="icon-btn" title="Profile">
                    <i class="fa-regular fa-user"></i>
                </a>
                <a href="/cart" class="icon-btn active" title="Cart">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <span class="cart-badge" style="display: none;">0</span>
                </a>
            </div>

            <button class="mobile-toggle"><i class="fa-solid fa-bars"></i></button>
        </div>
    </nav>

    <header class="page-header">
        <div class="container">
            <h1
                style="font-size: 2.5rem; margin-bottom: 0.5rem; font-family: var(--font-serif); color: hsl(var(--clr-primary));">
                Your Shopping Cart</h1>
            <p style="color: hsl(var(--clr-text-dark) / 0.7);">Review your items and proceed to checkout.</p>
        </div>
    </header>

    <main class="container">
        <div id="cart-content" class="cart-layout" style="display: none;">

            <!-- Items Area -->
            <div class="cart-items" id="cart-item-container">
                <!-- Javascript will inject items here -->
            </div>

            <!-- Summary Area -->
            <div class="order-summary">
                <h3 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 1.5rem;">Order Summary</h3>
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span id="subtotal-val">$0.00</span>
                </div>
                <div class="summary-row">
                    <span>Shipping</span>
                    <span>Free</span>
                </div>
                <div class="summary-total">
                    <span>Total</span>
                    <span id="total-val">$0.00</span>
                </div>

                <button id="checkout-btn" class="btn btn-primary"
                    style="width: 100%; margin-top: 2rem; justify-content: center; font-size: 1.1rem; padding: 1rem;">
                    Proceed to Checkout <i class="fa-solid fa-arrow-right"></i>
                </button>
                <div style="text-align: center; margin-top: 1rem;">
                    <i class="fa-brands fa-cc-visa" style="font-size: 1.5rem; color: #ccc; margin: 0 5px;"></i>
                    <i class="fa-brands fa-cc-mastercard" style="font-size: 1.5rem; color: #ccc; margin: 0 5px;"></i>
                    <i class="fa-brands fa-cc-paypal" style="font-size: 1.5rem; color: #ccc; margin: 0 5px;"></i>
                </div>
            </div>

        </div>

        <div id="empty-cart-state" class="empty-cart" style="display: none;">
            <i class="fa-solid fa-basket-shopping empty-icon"></i>
            <h2
                style="font-family: var(--font-serif); font-size: 2rem; color: hsl(var(--clr-primary)); margin-bottom: 1rem;">
                Your Cart is Empty</h2>
            <p style="color: hsl(var(--clr-text-dark) / 0.7); margin-bottom: 2rem;">Looks like you haven't added any
                sweet treats yet.</p>
            <a href="/home" class="btn btn-primary">Start Shopping</a>
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
    <script src="/js/cart.js"></script>
</body>

</html>
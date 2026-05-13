<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout | Sweet Pan</title>
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

        .checkout-layout {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 3rem;
            align-items: start;
            margin-bottom: 5rem;
        }

        .checkout-form-container {
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            padding: 3rem;
        }

        .section-title {
            font-family: var(--font-serif);
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: hsl(var(--clr-primary));
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.2rem;
            margin-bottom: 2rem;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: hsl(var(--clr-text-dark) / 0.8);
        }

        .form-input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            font-family: var(--font-sans);
            transition: all var(--transition-fast);
        }

        .form-input:focus {
            outline: none;
            border-color: hsl(var(--clr-primary));
            box-shadow: 0 0 0 3px hsl(var(--clr-primary) / 0.1);
        }

        /* Order Summary Sidebar */
        .order-summary {
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            padding: 2rem;
            position: sticky;
            top: 100px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .summary-item-img {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            object-fit: cover;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: hsl(var(--clr-text-dark) / 0.8);
            font-size: 0.95rem;
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

        /* Payment Methods */
        .payment-methods {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .payment-card {
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 1rem;
            text-align: center;
            cursor: pointer;
            transition: all var(--transition-fast);
        }

        .payment-card.selected {
            border-color: hsl(var(--clr-primary));
            background: hsl(var(--clr-primary) / 0.05);
        }

        /* Stepper */
        .stepper {
            display: flex;
            justify-content: center;
            margin-bottom: 3rem;
            gap: 2rem;
        }

        .step {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #ccc;
            font-weight: 600;
        }

        .step.active {
            color: hsl(var(--clr-primary));
        }

        .step-num {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: #eee;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
        }

        .step.active .step-num {
            background: hsl(var(--clr-primary));
            color: white;
        }

        @media (max-width: 992px) {
            .checkout-layout {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar">
        <div class="container nav-container">
            <a href="/home" class="nav-logo">Sweet Pan.</a>
            <div class="nav-actions">
                <a href="/checkout/back" class="btn btn-outline" style="padding: 0.5rem 1rem;">Back</a>
            </div>
        </div>
    </nav>

    <header class="page-header">
        <div class="container">
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem; font-family: var(--font-serif); color: hsl(var(--clr-primary));">
                Secure Checkout</h1>
            <p style="color: hsl(var(--clr-text-dark) / 0.7);">Step ${state.currentStep} of 3</p>
        </div>
    </header>

    <main class="container">
        
        <div class="stepper">
            <div class="step ${state.currentStep == 1 ? 'active' : ''}">
                <div class="step-num">1</div> Shipping
            </div>
            <div class="step ${state.currentStep == 2 ? 'active' : ''}">
                <div class="step-num">2</div> Payment
            </div>
            <div class="step ${state.currentStep == 3 ? 'active' : ''}">
                <div class="step-num">3</div> Review
            </div>
        </div>

        <div class="checkout-layout">
            
            <!-- Left: Forms -->
            <div class="checkout-form-container">
                
                <c:choose>
                    <c:when test="${state.currentStep == 1}">
                        <form action="/checkout/step1" method="POST">
                            <h3 class="section-title"><i class="fa-solid fa-truck"></i> Shipping Information</h3>
                            <div class="form-grid">
                                <div class="form-group">
                                    <label class="form-label">First Name</label>
                                    <input type="text" name="firstName" class="form-input" value="${state.firstName}" required>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Last Name</label>
                                    <input type="text" name="lastName" class="form-input" value="${state.lastName}" required>
                                </div>
                                <div class="form-group full">
                                    <label class="form-label">Address Line 1</label>
                                    <input type="text" name="address1" class="form-input" value="${state.address1}" required>
                                </div>
                                <div class="form-group full">
                                    <label class="form-label">Address Line 2 (Optional)</label>
                                    <input type="text" name="address2" class="form-input" value="${state.address2}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">City</label>
                                    <input type="text" name="city" class="form-input" value="${state.city}" required>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Phone Number</label>
                                    <input type="tel" name="phone" class="form-input" value="${state.phone}" required>
                                </div>
                                <div class="form-group full">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" name="email" class="form-input" value="${state.email}" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">Continue to Payment</button>
                        </form>
                    </c:when>

                    <c:when test="${state.currentStep == 2}">
                        <form action="/checkout/step2" method="POST">
                            <h3 class="section-title"><i class="fa-solid fa-credit-card"></i> Payment Method</h3>
                            <div class="payment-methods">
                                <div class="payment-card selected">
                                    <i class="fa-solid fa-money-bill" style="font-size: 2rem; color: #10b981; margin-bottom: 0.5rem;"></i>
                                    <div style="font-weight: 500;">Cash on Delivery</div>
                                    <input type="radio" name="paymentMethod" value="cod" checked style="display:none">
                                </div>
                                <div class="payment-card" style="opacity: 0.5; cursor: not-allowed;">
                                    <i class="fa-brands fa-cc-visa" style="font-size: 2rem; color: #1a1f71; margin-bottom: 0.5rem;"></i>
                                    <div style="font-weight: 500;">Credit Card</div>
                                    <small>(Coming Soon)</small>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">Review Order</button>
                        </form>
                    </c:when>

                    <c:when test="${state.currentStep == 3}">
                        <h3 class="section-title"><i class="fa-solid fa-clipboard-check"></i> Order Review</h3>
                        <div style="margin-bottom: 2rem;">
                            <div style="font-weight: 600; margin-bottom: 0.5rem;">Shipping To:</div>
                            <p>${state.firstName} ${state.lastName}</p>
                            <p>${state.address1}, ${state.address2 != null ? state.address2 : ''}</p>
                            <p>${state.city}</p>
                            <p>Phone: ${state.phone}</p>
                        </div>
                        <div style="margin-bottom: 2rem;">
                            <div style="font-weight: 600; margin-bottom: 0.5rem;">Payment Method:</div>
                            <p>${state.paymentMethod == 'cod' ? 'Cash on Delivery' : state.paymentMethod}</p>
                        </div>
                        
                        <form action="/checkout/place" method="POST">
                            <button type="submit" class="btn btn-primary btn-place-order" style="width: 100%; justify-content: center; font-size: 1.2rem; padding: 1.2rem;">
                                <i class="fa-solid fa-lock" style="margin-right: 8px;"></i> Place Order Now
                            </button>
                        </form>
                    </c:when>
                </c:choose>

            </div>

            <!-- Right: Summary (Always Visible) -->
            <div class="order-summary">
                <h3 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 1.5rem;">Your Order</h3>
                
                <c:forEach var="item" items="${state.cartItems}">
                    <div class="summary-item">
                        <div style="display: flex; gap: 1rem; align-items: center;">
                            <img src="${item.productImage}" alt="${item.productName}" class="summary-item-img">
                            <div>
                                <div style="font-weight: 600;">${item.productName}</div>
                                <div style="font-size: 0.85rem; color: #666;">Qty: ${item.quantity}</div>
                            </div>
                        </div>
                        <div style="font-weight: 600;">
                            <fmt:formatNumber value="${item.productPrice * item.quantity}" type="currency" currencySymbol="LKR "/>
                        </div>
                    </div>
                </c:forEach>

                <div style="margin-top: 2rem;">
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span><fmt:formatNumber value="${state.subtotal}" type="currency" currencySymbol="LKR "/></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span style="color: #10b981;">Free</span>
                    </div>
                    <div class="summary-total">
                        <span>Total</span>
                        <span><fmt:formatNumber value="${state.total}" type="currency" currencySymbol="LKR "/></span>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-bottom" style="border-top: none; text-align: center; padding: 2rem 0;">
                <p>&copy; 2026 Sweet Pan. All rights reserved.</p>
            </div>
        </div>
    </footer>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed | Sweet Pan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/styles.css">
    <style>
        .confirmation-container {
            max-width: 600px;
            margin: 8rem auto 5rem;
            background: hsl(var(--clr-surface));
            border-radius: 20px;
            padding: 4rem 3rem;
            text-align: center;
            box-shadow: var(--shadow-md);
            border-top: 8px solid #10b981;
        }

        .success-icon {
            width: 100px;
            height: 100px;
            background: #dcfce7;
            color: #10b981;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            margin: 0 auto 2rem;
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes popIn {
            0% { transform: scale(0); }
            100% { transform: scale(1); }
        }

        .order-number {
            background: hsl(var(--clr-surface-dim));
            padding: 1rem 2rem;
            border-radius: 12px;
            display: inline-block;
            margin: 1.5rem 0 2.5rem;
            font-family: var(--font-sans);
            font-weight: 700;
            font-size: 1.2rem;
            letter-spacing: 1px;
            color: hsl(var(--clr-primary));
        }

        .next-steps {
            text-align: left;
            background: #f8fafc;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }

        .step-item {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .step-item:last-child {
            margin-bottom: 0;
        }

        .step-icon {
            color: hsl(var(--clr-primary));
            font-size: 1.2rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

    </style>
</head>

<body>

    <nav class="navbar">
        <div class="container nav-container">
            <a href="/home" class="nav-logo">Sweet Pan.</a>
            <ul class="nav-links">
                <li><a href="/home" class="nav-link">Home</a></li>
                <li><a href="/products/custom-cakes" class="nav-link">Custom Cakes</a></li>
            </ul>
        </div>
    </nav>

    <main class="container">
        <div class="confirmation-container">
            <div class="success-icon">
                <i class="fa-solid fa-check"></i>
            </div>
            
            <h1 style="font-family: var(--font-serif); font-size: 2.5rem; color: hsl(var(--clr-text-dark)); margin-bottom: 1rem;">Thank you for your order!</h1>
            <p style="color: hsl(var(--clr-text-dark) / 0.7); font-size: 1.1rem;">Your delicious treats are being prepared with love.</p>
            <div class="next-steps">
                <h3 style="margin-bottom: 1.5rem; font-size: 1.1rem;">What happens next?</h3>
                
                <div class="step-item">
                    <i class="fa-solid fa-envelope step-icon"></i>
                    <div>
                        <div style="font-weight: 600;">Order Confirmation</div>
                        <div style="font-size: 0.9rem; color: #666;">We'll send an email confirmation shortly.</div>
                    </div>
                </div>
                
                <div class="step-item">
                    <i class="fa-solid fa-cake-candles step-icon"></i>
                    <div>
                        <div style="font-weight: 600;">Preparation</div>
                        <div style="font-size: 0.9rem; color: #666;">Our bakers start crafting your sweet pan.</div>
                    </div>
                </div>
                
                <div class="step-item">
                    <i class="fa-solid fa-truck-fast step-icon"></i>
                    <div>
                        <div style="font-weight: 600;">Delivery</div>
                        <div style="font-size: 0.9rem; color: #666;">You'll be notified when your order is out for delivery.</div>
                    </div>
                </div>
            </div>

            <div class="action-buttons">
                <a href="/home" class="btn btn-primary">Continue Shopping</a>
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

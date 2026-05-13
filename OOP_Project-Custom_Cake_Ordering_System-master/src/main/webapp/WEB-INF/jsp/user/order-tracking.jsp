<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Your Order | Sweet Pan</title>
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

        .tracking-container {
            max-width: 800px;
            margin: 0 auto 5rem;
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            padding: 3rem;
            box-shadow: var(--shadow-sm);
        }

        .search-box {
            display: flex;
            gap: 1rem;
            margin-bottom: 4rem;
        }

        .search-input {
            flex-grow: 1;
            padding: 1rem 1.5rem;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 50px;
            font-family: var(--font-sans);
            font-size: 1.1rem;
            outline: none;
            transition: border-color var(--transition-fast);
        }

        .search-input:focus {
            border-color: hsl(var(--clr-primary));
        }

        /* Timeline Styles */
        .timeline {
            position: relative;
            padding-left: 3rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 0;
            height: 100%;
            width: 2px;
            background: rgba(0, 0, 0, 0.1);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 3rem;
        }

        .timeline-item:last-child {
            margin-bottom: 0;
        }

        .timeline-icon {
            position: absolute;
            left: -3rem;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            color: rgba(0, 0, 0, 0.4);
            z-index: 1;
            transform: translateX(-50%);
        }

        /* Active Timeline States */
        .timeline-item.completed .timeline-icon {
            background: #10b981;
            border-color: #10b981;
            color: white;
        }

        .timeline-item.active .timeline-icon {
            background: hsl(var(--clr-primary));
            border-color: hsl(var(--clr-primary));
            color: white;
            box-shadow: 0 0 0 4px hsl(var(--clr-primary) / 0.2);
        }

        .timeline-content {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }

        .timeline-title {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            color: hsl(var(--clr-text-dark));
        }

        .timeline-desc {
            color: hsl(var(--clr-text-dark) / 0.7);
            font-size: 0.95rem;
        }

        .timeline-date {
            font-size: 0.85rem;
            color: #888;
            margin-top: 0.5rem;
            display: block;
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
                <li><a href="/user/profile" class="nav-link">My Account</a></li>
            </ul>
        </div>
    </nav>

    <header class="page-header">
        <div class="container">
            <h1>Track Your Order</h1>
            <p style="font-size: 1.1rem; opacity: 0.9; margin-top: 0.5rem;">Enter your Order ID to see real-time updates.</p>
        </div>
    </header>

    <main class="container">
        <div class="tracking-container">
            
            <form action="/user/order-tracking" method="GET" class="search-box">
                <input type="text" name="orderId" class="search-input" placeholder="e.g. ORD-10492" value="\${param.orderId != null ? param.orderId : ''}" required>
                <button type="submit" class="btn btn-primary" style="border-radius: 50px; padding: 0 2rem;">Track</button>
            </form>

            <div class="order-status-visual">
                <h3 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 2rem;">Status for: \${param.orderId != null ? param.orderId : 'ORD-10492'}</h3>
                
                <div class="timeline">
                    
                    <div class="timeline-item completed">
                        <div class="timeline-icon"><i class="fa-solid fa-check"></i></div>
                        <div class="timeline-content">
                            <div class="timeline-title">Order Placed</div>
                            <div class="timeline-desc">We have received your order and payment.</div>
                            <span class="timeline-date">Oct 24, 2026 - 10:30 AM</span>
                        </div>
                    </div>

                    <div class="timeline-item active">
                        <div class="timeline-icon"><i class="fa-solid fa-cake-candles"></i></div>
                        <div class="timeline-content">
                            <div class="timeline-title">Processing / Baking</div>
                            <div class="timeline-desc">Our chefs are currently preparing your delicious custom cake.</div>
                            <span class="timeline-date">Oct 24, 2026 - 11:45 AM</span>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-icon"><i class="fa-solid fa-truck"></i></div>
                        <div class="timeline-content">
                            <div class="timeline-title">Out for Delivery</div>
                            <div class="timeline-desc">Your order is on the way to the delivery address.</div>
                            <span class="timeline-date">Pending</span>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-icon"><i class="fa-solid fa-house-chimney"></i></div>
                        <div class="timeline-content">
                            <div class="timeline-title">Delivered</div>
                            <div class="timeline-desc">Order has been successfully delivered. Enjoy!</div>
                            <span class="timeline-date">Pending</span>
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

</body>
</html>

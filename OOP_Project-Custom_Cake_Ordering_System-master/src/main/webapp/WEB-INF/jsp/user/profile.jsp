<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Sweet Pan</title>
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

        .profile-layout {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 3rem;
            margin-bottom: 5rem;
        }

        .profile-sidebar {
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            height: fit-content;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: hsl(var(--clr-primary) / 0.1);
            color: hsl(var(--clr-primary));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            margin: 0 auto 1.5rem;
        }

        .profile-name {
            text-align: center;
            font-family: var(--font-serif);
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }

        .profile-nav {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .profile-nav-btn {
            padding: 0.8rem 1rem;
            border-radius: 8px;
            text-align: left;
            transition: all var(--transition-fast);
            color: hsl(var(--clr-text-dark) / 0.8);
            font-weight: 500;
        }

        .profile-nav-btn:hover,
        .profile-nav-btn.active {
            background: hsl(var(--clr-primary) / 0.05);
            color: hsl(var(--clr-primary));
        }

        .profile-content {
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            padding: 3rem;
            box-shadow: var(--shadow-sm);
        }

        .order-history-item {
            border: 1px solid rgba(0, 0, 0, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-status {
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-completed {
            background: #dcfce7;
            color: #166534;
        }

        .status-processing {
            background: #fdf6b2;
            color: #723b13;
        }

        @media (max-width: 768px) {
            .profile-layout {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:styles />
<t:header />

    <header class="page-header">
        <div class="container">
            <h1>My Account</h1>
        </div>
    </header>

    <main class="container">

        <div class="profile-layout">
            <div class="profile-sidebar">
                <div class="profile-avatar">
                    <i class="fa-solid fa-user"></i>
                </div>
                <h3 class="profile-name">${user.username}</h3>

                <div class="profile-nav">
                    <button class="btn profile-nav-btn active"><i class="fa-solid fa-box"
                            style="margin-right:10px; width:20px;"></i> Orders</button>
                    <button class="btn profile-nav-btn"><i class="fa-solid fa-gear"
                            style="margin-right:10px; width:20px;"></i> Settings</button>
                    <button class="btn profile-nav-btn" style="color: #ef4444;"
                        onclick="window.location.href='/logout'"><i class="fa-solid fa-arrow-right-from-bracket"
                            style="margin-right:10px; width:20px;"></i> Logout</button>
                </div>
            </div>

            <div class="profile-content">
                <h2 style="font-family: var(--font-serif); font-size: 2rem; margin-bottom: 2rem;">Order History</h2>

                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-history-item">
                                <div>
                                    <h4 style="font-family: var(--font-sans); margin-bottom: 0.3rem;">Order #ORD-${order.orderId}</h4>
                                    <p style="color: hsl(var(--clr-text-dark) / 0.6); font-size: 0.9rem;">Placed on ${order.dateOfOrder}</p>
                                </div>
                                <div>
                                    <p style="font-weight: 600; text-align: right; margin-bottom: 0.3rem;">
                                        <fmt:setLocale value="en_LK"/>
                                        <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="LKR "/>
                                    </p>
                                    <span class="order-status ${order.orderStatus == 'Delivered' ? 'status-completed' : (order.orderStatus == 'Pending' ? 'status-pending' : 'status-processing')}">
                                        ${order.orderStatus}
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 3rem;">
                            <p style="color: #666;">You haven't placed any orders yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <div style="text-align: center; margin-top: 3rem;">
                    <a href="/home" class="btn btn-outline">Continue Shopping</a>
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

    <script src="/js/main.js"></script>
</body>

</html>
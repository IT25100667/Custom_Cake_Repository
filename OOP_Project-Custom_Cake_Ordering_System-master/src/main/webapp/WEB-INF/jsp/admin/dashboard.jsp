<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Sweet Pan</title>
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/styles.css">
    <style>
        .dashboard-header {
            background: linear-gradient(135deg, hsl(var(--clr-primary)) 0%, #4a1538 100%);
            color: white;
            padding: 8rem 0 4rem;
            text-align: center;
            border-radius: 0 0 50px 50px;
            margin-bottom: 4rem;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 5rem;
        }

        .dashboard-card {
            background: hsl(var(--clr-surface));
            padding: 2rem;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            text-align: center;
            transition: transform var(--transition-fast), box-shadow var(--transition-fast);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .dashboard-icon {
            font-size: 3rem;
            color: hsl(var(--clr-primary));
            margin-bottom: 1.5rem;
        }

        .dashboard-card h3 {
            font-family: var(--font-serif);
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .dashboard-card p {
            color: hsl(var(--clr-text-dark) / 0.7);
            margin-bottom: 1.5rem;
        }

        .select-element{
            padding:0.3rem 0.8rem;
            border-radius:50px;
            font-size:0.8rem;
            font-weight:600;
            border:1px solid #e5e7eb;
            cursor:pointer;
            outline:none;
            background:#fdf6b2;
            color:#723b13;
          }
    </style>
</head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:styles />
<t:header />
<body>

    <!-- Fixed Navbar -->

    <header class="dashboard-header">
        <div class="container">
            <h1>Welcome to Your Dashboard</h1>
            <p id="welcome-msg" style="font-size: 1.2rem; opacity: 0.9; margin-top: 1rem;">Hello Venuka, we're glad to see you back!</p>
            
            <div style="margin-top: 2.5rem; display: flex; justify-content: center; gap: 1rem;">
                <a href="/admin/product/add" class="btn btn-accent" style="display: inline-flex; align-items: center; gap: 0.5rem; background: white; color: hsl(var(--clr-primary)); padding: 0.8rem 1.5rem; border-radius: 50px; font-weight: 600; text-decoration: none;">
                    <i class="fa-solid fa-plus"></i> Upload New Cake
                </a>
                <a href="/search" class="btn btn-outline" style="display: inline-flex; align-items: center; gap: 0.5rem; border-color: white; color: white; padding: 0.8rem 1.5rem; border-radius: 50px; font-weight: 600; text-decoration: none;">
                    <i class="fa-solid fa-eye"></i> View Shop
                </a>
            </div>
        </div>
    </header>

    <main class="container">
        <div id="employee-stats" style="margin-bottom: 3rem;">
            <div style="background: hsl(var(--clr-surface)); padding: 2rem; border-radius: 16px; box-shadow: var(--shadow-sm); border: 1px solid rgba(0, 0, 0, 0.05); text-align: center; margin-bottom: 2rem;">
                <h3 style="font-family: var(--font-serif); font-size: 1.8rem; margin-bottom: 1rem; color: hsl(var(--clr-primary));">Total Sales</h3>
                <p style="font-size: 3rem; font-weight: 700; color: #166534;">
                    <fmt:setLocale value="en_LK"/>
                    <fmt:formatNumber value="${totalPrice}" type="currency"  currencySymbol="LKR "/>
                </p>
                <p style="color: hsl(var(--clr-text-dark) / 0.7); margin-top: 0.5rem;">Total value of orders you placed</p>
            </div>

            <div style="background: hsl(var(--clr-surface)); padding: 2rem; border-radius: 16px; box-shadow: var(--shadow-sm); border: 1px solid rgba(0, 0, 0, 0.05);">
                <h3 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 1.5rem;">Recent Orders</h3>
                <div style="overflow-x: auto;">
                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead>
                            <tr style="border-bottom: 2px solid rgba(0,0,0,0.05);">
                                <th style="padding: 1rem; font-weight: 600;">Order ID</th>
                                <th style="padding: 1rem; font-weight: 600;">Date</th>
                                <th style="padding: 1rem; font-weight: 600;">Customer ID</th>
                                <th style="padding: 1rem; font-weight: 600;">Amount</th>
                                <th style="padding: 1rem; font-weight: 600;">Status</th>
                                <th style="padding: 1rem; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr style="border-bottom: 1px solid rgba(0,0,0,0.05);">
                                        <td style="padding: 1rem;">#${order.orderId}</td>
                                        <td style="padding: 1rem;">${order.dateOfOrder}</td>
                                        <td style="padding: 1rem;">#${order.customerId}</td>
                                        <td style="padding: 1rem; font-weight: 600;">
                                            <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="LKR "/>
                                        </td>
                                        <td style="padding: 1rem;">
                                            <form action="../order/updateOrderStatus" method="POST">
                                                <input type="text" name="orderId" value=${order.orderId} style="display:none">
                                                <select class="select-element" onchange="changeColor(this, event)" name="orderStatus">
                                                    <option value="Pending" ${order.orderStatus=="Pending" ? 'selected':''}>Pending</option>
                                                    <option value="Processing" ${order.orderStatus=="Processing" ? 'selected':''}>Processing</option>
                                                    <option value="Delivered" ${order.orderStatus=="Delivered" ? 'selected':''}>Delivered</option>
                                                </select>
                                            </form>
                                        </td>
                                        <td style="padding: 1rem;">
                                            <form action="/admin/order/delete" method="POST" onsubmit="return confirm('Are you sure you want to delete this order?');">
                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                <button type="submit" style="background: none; border: none; color: #ef4444; cursor: pointer;" title="Delete Order">
                                                    <i class="fa-solid fa-trash-can"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>

                        </tbody>
                    </table>
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
    <script src="/js/search.js"></script>
    <script>

    document.addEventListener('DOMContentLoaded', ()=>{
        var elements = document.getElementsByClassName('select-element');
        for (i= 0; i < elements.length; i++) {
            setColor(elements[i]);
        }
    })

    function setColor(el){
            el.style.background = el.value === 'Processing' ? '#fdf6b2' : el.value === 'Delivered' ? '#dcfce7':'#ff3c00e0'; el.style.color = el.value === 'Processing' ? '#723b13' : el.value === 'Delivered' ? '#166534':'white';
    }

    function changeColor(el, event){
        event.preventDefault();
        el.style.background = el.value === 'Processing' ? '#fdf6b2' : el.value === 'Delivered' ? '#dcfce7':'#ff3c00e0'; el.style.color = el.value === 'Processing' ? '#723b13' : el.value === 'Delivered' ? '#166534':'white';

        fetch(el.closest("form").action, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams(new FormData(el.closest("form")))
        });
    }

    </script>

</body>

</html>

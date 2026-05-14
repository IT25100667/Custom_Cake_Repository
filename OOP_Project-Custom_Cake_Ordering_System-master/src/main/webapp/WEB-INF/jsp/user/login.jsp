<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:styles />
<t:header />
    <style>
        .auth-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 8rem 2rem 4rem;
            background: linear-gradient(135deg, hsl(var(--clr-surface)) 0%, hsl(var(--clr-surface-dim)) 100%);
        }

        .auth-card {
            background: hsl(var(--clr-surface));
            padding: 4rem;
            border-radius: 20px;
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 500px;
            text-align: center;
            border: 1px solid rgba(0,0,0,0.03);
        }

        .auth-card h2 {
            font-family: var(--font-serif);
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            color: hsl(var(--clr-primary));
        }

        .auth-card p {
            color: hsl(var(--clr-text-dark) / 0.7);
            margin-bottom: 2.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            text-align: left;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            border-radius: 8px;
            font-family: var(--font-sans);
            font-size: 1rem;
            background: hsl(var(--clr-surface));
            transition: border-color var(--transition-fast);
        }

        .form-control:focus {
            outline: none;
            border-color: hsl(var(--clr-primary));
        }

        @media (max-width: 576px) {
            .auth-card {
                padding: 2.5rem 1.5rem;
            }
        }
    </style>
<body>


    <div class="auth-container">
        <div class="auth-card">
            <h2>Welcome Back</h2>
            <p>Login to your account or <a href="signup" style="color: hsl(var(--clr-accent)); font-weight: 600;">sign up</a></p>

            <form action="${pageContext.request.contextPath}/perform_login" method="POST">
            <!--Essentially gets the base path of the website-->
                <div class="form-group">
                    <label class="form-label" for="username">Username</label>
                    <input type="text" id="username" class="form-control" name="username" required >
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" class="form-control" name="password" required>
                </div>
                <c:if test="${not empty param.error}">
                    <p style="color:black; background:#FF8787; border-radius: 20px;">Incorrect Username or Password</p>
                </c:if>
                <div style="text-align: right; margin-bottom: 2rem;">
                    <a href="#" style="font-size: 0.9rem; color: hsl(var(--clr-text-dark) / 0.7);">Forgot password?</a>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center; font-size: 1.1rem; padding: 1rem;">
                    Sign In
                </button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-brand">
                    <h3>SweetPan.</h3>
                    <p>Baking happiness and premium quality treats for every special occasion.</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 SweetPan. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="/js/main.js"></script>
</body>
</html>
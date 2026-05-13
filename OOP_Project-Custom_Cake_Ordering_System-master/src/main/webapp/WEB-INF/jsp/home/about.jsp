<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | SweetPan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/static/css/styles.css">
    <style>

        .about-hero {
            position: relative;
            height: 60vh;
            min-height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            margin-bottom: 5rem;
        }

        .about-hero::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: url('https://images.unsplash.com/photo-1557925923-33b251dc3296?w=1600&h=900&fit=crop') center/cover;
            z-index: -2;
        }

        .about-hero::after {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.6) 0%, rgba(107, 33, 84, 0.4) 100%);
            z-index: -1;
        }

        .about-hero h1 {
            color: white;
            font-size: clamp(3rem, 5vw, 5rem);
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.3);
        }

        .about-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
            margin-bottom: 6rem;
        }

        .about-img {
            border-radius: 20px;
            box-shadow: var(--shadow-lg);
            width: 100%;
        }

        .story-text p {
            font-size: 1.1rem;
            color: hsl(var(--clr-text-dark) / 0.8);
            margin-bottom: 1.5rem;
        }

        .values-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            margin-bottom: 6rem;
        }

        .value-card {
            text-align: center;
            padding: 3rem 2rem;
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            transition: transform var(--transition-fast);
        }

        .value-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .value-icon {
            font-size: 2.5rem;
            color: hsl(var(--clr-accent));
            margin-bottom: 1.5rem;
        }

        @media (max-width: 992px) {
            .about-content {
                grid-template-columns: 1fr;
            }
            .values-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:styles />
<t:header />
<body>

    <header class="about-hero">
        <div class="container">
            <h1>Our Sweet Story</h1>
            <p style="font-size: 1.2rem; max-width: 600px; margin: 0 auto; line-height: 1.6;">Where passion for baking meets artistry. We believe every celebration deserves a centerpiece that's as beautiful as it is delicious.</p>
        </div>
    </header>

    <main class="container">
        
        <div class="about-content">
            <div class="story-text">
                <h2 class="section-title">Rooted in Tradition, Baked with Love</h2>
                <h3 class="section-subtitle" style="margin-bottom: 2rem; color: hsl(var(--clr-primary));">Founded in 2026.</h3>
                <p>SweetPan started in a small home kitchen with a simple philosophy: use only the finest ingredients to create cakes that make people smile. Over the years, our recipes have evolved, but our commitment to quality has never wavered.</p>
                <p>We source our Madagascar vanilla, Belgian chocolate, and fresh local dairy to ensure that every bite of our signature and custom cakes is an unforgettable experience.</p>
                <p>Whether you are designing a lavish wedding cake or ordering a dozen macarons for a Friday night, our team of expert pastry chefs put their heart into every detail.</p>
            </div>
            <div>
                <img src="https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&h=1000&fit=crop" alt="Baker decorating a cake" class="about-img">
            </div>
        </div>

        <div class="text-center">
            <h2 class="section-title" style="margin-bottom: 3rem;">Our Core Values</h2>
        </div>

        <div class="values-grid">
            <div class="value-card">
                <i class="fa-solid fa-leaf value-icon"></i>
                <h3 style="font-family: var(--font-serif); margin-bottom: 1rem; font-size: 1.5rem;">Pure Ingredients</h3>
                <p style="color: hsl(var(--clr-text-dark) / 0.7);">We never compromise. Only sustainable, high-quality, and ethical ingredients enter our kitchen.</p>
            </div>
            <div class="value-card">
                <i class="fa-solid fa-palette value-icon"></i>
                <h3 style="font-family: var(--font-serif); margin-bottom: 1rem; font-size: 1.5rem;">Artistic Detail</h3>
                <p style="color: hsl(var(--clr-text-dark) / 0.7);">Every cake is a canvas. Our decorators ensure every rosette and gold leaf is placed perfectly.</p>
            </div>
            <div class="value-card">
                <i class="fa-solid fa-heart value-icon"></i>
                <h3 style="font-family: var(--font-serif); margin-bottom: 1rem; font-size: 1.5rem;">Customer Joy</h3>
                <p style="color: hsl(var(--clr-text-dark) / 0.7);">Your happiness is our mission. We work closely with you to bring your dream cake to life.</p>
            </div>
        </div>

    </main>

    <!-- Footer -->
    <footer class="footer">
        <!-- Kept consistent footer -->
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
    <script src="/js/search.js"></script>
    <script src="/js/cart.js"></script>
</body>
</html>

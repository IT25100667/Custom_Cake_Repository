<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us | SweetPan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/styles.css">
    <style>
        .page-header {
            background: linear-gradient(135deg, hsl(var(--clr-surface)) 0%, hsl(var(--clr-surface-dim)) 100%);
            padding: 10rem 0 5rem;
            text-align: center;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            margin-bottom: 4rem;
        }

        .contact-layout {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 5rem;
            margin-bottom: 6rem;
        }

        .contact-info {
            padding-right: 2rem;
        }

        .info-item {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 2rem;
            align-items: flex-start;
        }

        .info-icon {
            font-size: 1.5rem;
            color: hsl(var(--clr-primary));
            background: hsl(var(--clr-primary) / 0.1);
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            flex-shrink: 0;
        }

        .info-text h4 {
            font-family: var(--font-sans);
            font-size: 1.1rem;
            margin-bottom: 0.3rem;
        }

        .info-text p {
            color: hsl(var(--clr-text-dark) / 0.7);
        }

        .contact-form {
            background: hsl(var(--clr-surface));
            padding: 3rem;
            border-radius: 20px;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(0,0,0,0.03);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
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

        textarea.form-control {
            resize: vertical;
            min-height: 150px;
        }

        @media (max-width: 992px) {
            .contact-layout {
                grid-template-columns: 1fr;
                gap: 3rem;
            }
            .form-row {
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

    <header class="page-header">
        <div class="container">
            <h1 style="font-size: clamp(2.5rem, 4vw, 4rem); font-family: var(--font-serif); margin-bottom: 0.5rem; color: hsl(var(--clr-primary));">Get in Touch</h1>
            <p style="font-size: 1.1rem; color: hsl(var(--clr-text-dark) / 0.7); max-width: 500px; margin: 0 auto;">Have a question about a custom order or need to reach our bakery? We'd love to hear from you.</p>
        </div>
    </header>

    <main class="container">
        
        <div class="contact-layout">
            <div class="contact-info">
                <h2 class="section-title" style="font-size: 2rem; margin-bottom: 2rem;">Contact Information</h2>
                
                <div class="info-item">
                    <div class="info-icon"><i class="fa-solid fa-location-dot"></i></div>
                    <div class="info-text">
                        <h4>Our Bakery</h4>
                        <p>SLIIT<br>Malabe</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fa-solid fa-phone"></i></div>
                    <div class="info-text">
                        <h4>Call Us</h4>
                        <p>XXX-XXXX-XXX<br>Mon-Fri, 9am - 6pm</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fa-solid fa-envelope"></i></div>
                    <div class="info-text">
                        <h4>Email Us</h4>
                        <p>hello@sweetpan.com<br>orders@sweetpan.com</p>
                    </div>
                </div>
            </div>

            <div class="contact-form-wrapper">
                <form class="contact-form" onsubmit="event.preventDefault(); alert('Message sent successfully! We will get back to you soon.'); this.reset();">
                    <h3 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 2rem;">Send us a Message</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="fname">First Name</label>
                            <input type="text" id="fname" class="form-control" required placeholder="Jane">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="lname">Last Name</label>
                            <input type="text" id="lname" class="form-control" required placeholder="Doe">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <input type="email" id="email" class="form-control" required placeholder="jane@example.com">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="subject">Subject</label>
                        <input type="text" id="subject" class="form-control" placeholder="Optional">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="message">Message</label>
                        <textarea id="message" class="form-control" required placeholder="How can we help you today?"></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center; font-size: 1.1rem; padding: 1rem;">
                        Send Message
                    </button>
                </form>
            </div>
        </div>

    </main>

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
    <script src="/js/search.js"></script>
    <script src="/js/cart.js"></script>
</body>
</html>

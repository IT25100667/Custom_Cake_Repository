<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Design Your Custom Cake | SweetPan</title>
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
        
        .page-header h1 {
            color: white;
            font-size: clamp(2.5rem, 4vw, 4rem);
            margin-bottom: 1rem;
        }
        
        .custom-builder-layout {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 4rem;
            align-items: start;
        }

        /* Preset Selection Grid */
        .preset-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .preset-card {
            border: 2px solid transparent;
            border-radius: 16px;
            overflow: hidden;
            cursor: pointer;
            transition: all var(--transition-fast);
            background: hsl(var(--clr-surface));
            box-shadow: var(--shadow-sm);
        }

        .preset-card.selected {
            border-color: hsl(var(--clr-accent));
            box-shadow: 0 0 0 4px hsl(var(--clr-accent) / 0.2);
            transform: scale(1.02);
        }

        .preset-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .preset-info {
            padding: 1rem;
            text-align: center;
        }
        
        .preset-info h4 {
            font-family: var(--font-sans);
            margin-bottom: 0.5rem;
        }

        /* Form Controls */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: hsl(var(--clr-text-dark));
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

        /* Summary Panel (Sticky) */
        .summary-panel {
            position: sticky;
            top: 100px;
            background: hsl(var(--clr-surface));
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(0,0,0,0.05);
        }

        .summary-title {
            font-family: var(--font-serif);
            font-size: 1.8rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-size: 1.05rem;
            color: hsl(var(--clr-text-dark) / 0.8);
        }

        .summary-row.total {
            font-size: 1.4rem;
            font-weight: 700;
            color: hsl(var(--clr-primary));
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(0,0,0,0.1);
        }

        .summary-row span.label {
            font-weight: 500;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .custom-builder-layout {
                grid-template-columns: 1fr;
            }
            .summary-panel {
                position: static;
                margin-top: 2rem;
            }
        }
        
        @media (max-width: 576px) {
            .preset-grid {
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
            <h1>Design Your Masterpiece</h1>
            <p style="font-size: 1.2rem; opacity: 0.9;">Tailor everything from the base to the final message.</p>
        </div>
    </header>

    <main class="container">
        <div class="custom-builder-layout">
            
            <!-- Left Side: Configuration Options -->
            <div class="builder-options">
                
                <h3 class="section-title" style="font-size: 2rem;">1. Choose Base Cake</h3>
                <p class="section-subtitle">Select from our 4 signature preset bases.</p>
                
                <div class="preset-grid" id="preset-grid">
                    <!-- Populated by JS -->
                </div>

                <h3 class="section-title" style="font-size: 2rem;">2. Customize</h3>
                <p class="section-subtitle">Make it uniquely yours.</p>

                <div class="form-group">
                    <label class="form-label" for="cake-size">Cake Size <span style="font-weight:normal; color:#666;">(Affects base price)</span></label>
                    <select id="cake-size" class="form-control">
                        <option value="1">1 kg (Serves 8-10) - Base Price</option>
                        <option value="1.5">1.5 kg (Serves 15) - +50%</option>
                        <option value="2">2 kg (Serves 20-25) - +100%</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label" for="cake-topping">Premium Toppings <span style="font-weight:normal; color:#666;">(+$5.00)</span></label>
                    <select id="cake-topping" class="form-control">
                        <option value="none">Standard Decor (Included)</option>
                        <option value="fresh-berries">Fresh Mixed Berries</option>
                        <option value="macarons">Assorted Macarons</option>
                        <option value="gold-leaf">Edible Gold Leaf Highlights</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label" for="cake-message">Special Message (Optional)</label>
                    <input type="text" id="cake-message" class="form-control" placeholder="e.g., Happy 30th Birthday Sarah!" maxlength="40">
                    <small style="color: #666; margin-top: 4px; display: block;">Max 40 characters.</small>
                </div>
            </div>

            <!-- Right Side: Live Summary -->
            <div>
                <div class="summary-panel">
                    <h3 class="summary-title">Your Order Summary</h3>
                    
                    <div class="summary-row">
                        <span class="label">Base Cake:</span>
                        <span id="summary-base-name">Select a cake</span>
                    </div>
                    <div class="summary-row">
                        <span class="label">Size:</span>
                        <span id="summary-size">1 kg</span>
                    </div>
                    <div class="summary-row">
                        <span class="label">Topping:</span>
                        <span id="summary-topping">Standard</span>
                    </div>
                    
                    <!-- Preview of chosen image -->
                    <div style="margin: 2rem 0; text-align: center;">
                        <img id="summary-img" src="https://via.placeholder.com/300?text=Select+a+Cake" alt="Preview" style="border-radius: 12px; height: 180px; width: 100%; object-fit: cover; box-shadow: var(--shadow-sm);">
                    </div>
                    
                    <div class="summary-row total">
                        <span class="label">Total Price:</span>
                        <span id="summary-total">$0.00</span>
                    </div>

                    <button id="btn-place-order" class="btn btn-primary" style="width: 100%; margin-top: 1.5rem; justify-content: center; font-size: 1.1rem; padding: 1rem;" disabled>
                        Place Order Now <i class="fa-solid fa-check-circle"></i>
                    </button>
                </div>
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

    <script src="/js/search.js"></script>
    <script src="/js/custom-cake.js"></script>
</body>
</html>

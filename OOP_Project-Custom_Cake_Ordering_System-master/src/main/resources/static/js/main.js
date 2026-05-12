/**
 * Main JavaScript File
 * Handles global interactions like Navbar styling on scroll, mobile menu, and cart state initialization.
 */

document.addEventListener('DOMContentLoaded', () => {
    initNavbar();
    initCartState();
    updateCartBadge();
    initCarousels();
});

// --- Navbar Interactions ---
function initNavbar() {
    const navbar = document.querySelector('.navbar');
    const mobileToggle = document.querySelector('.mobile-toggle');
    const navLinks = document.querySelector('.nav-links');

    // Scroll effect
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Mobile menu toggle
    if (mobileToggle) {
        mobileToggle.addEventListener('click', () => {
            navLinks.classList.toggle('active');
            // Toggle icon between bars and times
            const icon = mobileToggle.querySelector('i');
            if(icon) {
                if(navLinks.classList.contains('active')){
                    icon.classList.remove('fa-bars');
                    icon.classList.add('fa-times');
                } else {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            }
        });
    }

    // Handle Dropdown links (redirect to search.html with category)
    const dropdownItems = document.querySelectorAll('.dropdown-item');
    dropdownItems.forEach(item => {
        item.addEventListener('click', (e) => {
            const category = e.target.getAttribute('data-category');
            if (category) {
                // We're navigating, no need to preventDefault if it's an anchor, 
                // but just in case we use JS navigation:
                window.location.href = `/search?category=${category}`;
            }
        });
    });
}

// --- Cart State Management ---
function initCartState() {
    // Backend handles state now
}

window.updateCartBadge = async function() {
    const cartBadge = document.querySelector('.cart-badge');
    if (cartBadge) {
        try {
            const response = await fetch('/api/cart');
            if (!response.ok) return;
            const items = await response.json();
            const total = items.reduce((sum, item) => sum + (item.quantity || 1), 0);
            cartBadge.textContent = total;
            
            if (total === 0) {
                cartBadge.style.display = 'none';
            } else {
                cartBadge.style.display = 'flex';
            }
        } catch (e) {
            console.error("Cart update failed", e);
        }
    }
}

window.addToCart = async function(product) {
    try {
        const response = await fetch(`/api/cart/add?productId=${product.id || product.productId}&quantity=1`, {
            method: 'POST'
        });
        
        if (response.status === 403 || response.status === 401) {
            showToast("Please login to add items to cart");
            return;
        }

        const result = await response.json();
        if (result.status) {
            updateCartBadge();
            showToast(`Added ${product.title || product.name} to cart`);
        } else {
            showToast(`Error: ${result.message}`);
        }
    } catch (e) {
        console.error("Add to cart failed", e);
        showToast("Failed to add to cart");
    }
}

function showToast(message) {
    const existingToast = document.querySelector('.toast');
    if(existingToast) existingToast.remove();

    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.style.cssText = `
        position: fixed;
        bottom: 2rem;
        right: 2rem;
        background: hsl(var(--clr-primary));
        color: white;
        padding: 1rem 2rem;
        border-radius: 50px;
        box-shadow: var(--shadow-lg);
        z-index: 9999;
        transform: translateY(100px);
        opacity: 0;
        transition: all var(--transition-fast);
    `;
    toast.innerHTML = `<i class="fa-solid fa-check-circle" style="margin-right: 10px;"></i> ${message}`;
    
    document.body.appendChild(toast);
    
    // Animate in
    setTimeout(() => {
        toast.style.transform = 'translateY(0)';
        toast.style.opacity = '1';
    }, 100);
    
    // Animate out
    setTimeout(() => {
        toast.style.transform = 'translateY(100px)';
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// --- Carousel Implementation ---
function initCarousels() {
    const carousels = document.querySelectorAll('.carousel-wrapper');
    
    carousels.forEach(wrapper => {
        const container = wrapper.querySelector('.carousel-container');
        const btnPrev = wrapper.querySelector('.btn-prev');
        const btnNext = wrapper.querySelector('.btn-next');
        
        if(container && btnPrev && btnNext) {
            btnPrev.addEventListener('click', () => {
                const cardWidth = container.querySelector('.product-card').offsetWidth;
                container.scrollBy({ left: -(cardWidth + 32), behavior: 'smooth' }); // 32 is gap
            });
            
            btnNext.addEventListener('click', () => {
                const cardWidth = container.querySelector('.product-card').offsetWidth;
                container.scrollBy({ left: (cardWidth + 32), behavior: 'smooth' });
            });
        }
    });
}

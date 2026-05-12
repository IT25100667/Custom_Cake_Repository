/**
 * Search and Shop Page JavaScript
 * Handles sorting and UI interactions for the product collection.
 */

document.addEventListener('DOMContentLoaded', () => {
    initSorting();
    highlightActiveCategory();
});

/**
 * Client-side sorting for products
 */

/**
 * Helper to extract price from a product card
 */
function getPrice(card) {
    const priceText = card.querySelector('.product-price').textContent;
    // Assuming format "LKR 1500"
    return parseFloat(priceText.replace(/[^\d.]/g, ''));
}

/**
 * Ensures the correct category tag is highlighted based on URL
 */
function highlightActiveCategory() {
    const params = new URLSearchParams(window.location.search);
    const category = params.get('category') || 'all';
    
    const tags = document.querySelectorAll('.filter-tag');
    tags.forEach(tag => {
        if (tag.getAttribute('href').includes(`category=${category}`)) {
            tag.classList.add('active');
        } else {
            tag.classList.remove('active');
        }
    });
}

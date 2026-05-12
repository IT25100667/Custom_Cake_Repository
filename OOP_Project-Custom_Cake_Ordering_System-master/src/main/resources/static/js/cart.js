if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', renderCart);
} else {
    renderCart();
}

async function renderCart() {
    const container = document.getElementById('cart-item-container');
    const contentArea = document.getElementById('cart-content');
    const emptyState = document.getElementById('empty-cart-state');

    if (!container || !contentArea || !emptyState) return;

    try {
        const response = await fetch('/api/cart');
        const cartItems = await response.json();

        if (cartItems.length === 0) {
            contentArea.style.display = 'none';
            emptyState.style.display = 'block';
            return;
        }

        contentArea.style.display = 'grid';
        emptyState.style.display = 'none';
        container.innerHTML = '';

        let subtotal = 0;

        cartItems.forEach((item) => {
            const itemTotal = item.productPrice * item.quantity;
            subtotal += itemTotal;

            const itemEl = document.createElement('div');
            itemEl.className = 'cart-item';
            itemEl.innerHTML = `
                <img src="${item.productImage || '/images/products/placeholder.jpg'}" alt="${item.productName}" class="cart-item-img">
                <div class="cart-item-details">
                    <div class="cart-item-category">${item.categoryName || 'Cake'}</div>
                    <h3 class="cart-item-title">${item.productName}</h3>
                    <div class="cart-item-price">LKR ${item.productPrice.toLocaleString()}</div>
                    
                    <div class="cart-item-actions">
                        <div class="qty-control">
                            <div class="qty-btn" onclick="updateQty(${item.id}, ${item.quantity - 1})"><i class="fa-solid fa-minus"></i></div>
                            <input type="text" class="qty-val" value="${item.quantity}" readonly>
                            <div class="qty-btn" onclick="updateQty(${item.id}, ${item.quantity + 1})"><i class="fa-solid fa-plus"></i></div>
                        </div>
                        <a href="javascript:void(0)" class="btn-remove" onclick="removeItem(${item.id})" title="Remove Item">
                            <i class="fa-solid fa-trash-can"></i>
                        </a>
                    </div>
                </div>
                <div style="font-weight: 700; color: hsl(var(--clr-primary)); align-self: center;">
                    LKR ${itemTotal.toLocaleString()}
                </div>
            `;
            container.appendChild(itemEl);
        });

        updateSummary(subtotal);
        
        // Add checkout button listener
        const checkoutBtn = document.getElementById('checkout-btn');
        if (checkoutBtn) {
            checkoutBtn.onclick = async () => {
                try {
                    // Send current cart to init the checkout session
                    const res = await fetch('/checkout/init', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(cartItems)
                    });
                    const result = await res.json();
                    if (result.status) {
                        window.location.href = '/checkout';
                    }
                } catch (e) {
                    console.error("Checkout initialization failed", e);
                }
            };
        }
    } catch (e) {
        console.error("Failed to render cart", e);
    }
}

function updateSummary(subtotal) {
    const total = subtotal;

    document.getElementById('subtotal-val').textContent = `LKR ${subtotal.toLocaleString()}`;
    document.getElementById('total-val').textContent = `LKR ${total.toLocaleString()}`;
}

window.updateQty = async function(itemId, newQty) {
    if (newQty < 1) return;
    try {
        const response = await fetch(`/api/cart/update?itemId=${itemId}&quantity=${newQty}`, {
            method: 'PUT'
        });
        const result = await response.json();
        if (result.status) {
            renderCart();
            if (window.updateCartBadge) window.updateCartBadge();
        }
    } catch (e) {
        console.error("Qty update failed", e);
    }
}

window.removeItem = async function(itemId) {
    if (!confirm("Remove this item from cart?")) return;
    try {
        const response = await fetch(`/api/cart/${itemId}`, {
            method: 'DELETE'
        });
        const result = await response.json();
        if (result.status) {
            renderCart();
            if (window.updateCartBadge) window.updateCartBadge();
        }
    } catch (e) {
        console.error("Remove failed", e);
    }
}

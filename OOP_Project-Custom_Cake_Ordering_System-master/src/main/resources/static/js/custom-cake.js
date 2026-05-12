/**
 * Logic for Custom Cake Builder
 */

const presetCakes = [
    { id: 'pres_1', name: 'Rich Chocolate Truffle', basePrice: 50, img: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=500&h=400&fit=crop' },
    { id: 'pres_2', name: 'Madagascar Vanilla Bean', basePrice: 45, img: 'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=500&h=400&fit=crop' },
    { id: 'pres_3', name: 'Classic Red Velvet', basePrice: 55, img: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=500&h=400&fit=crop' },
    { id: 'pres_4', name: 'Black Forest Dream', basePrice: 52, img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ_QOYax_PpaHEE2hYCKPDN7sV8agXvFIt7Q&s?w=500&h=400&fit=crop' }
];

let selectedPreset = null;

const state = {
    sizeMultiplier: 1, // 1 for 1kg, 1.5 for 1.5kg, 2 for 2kg
    sizeLabel: '1 kg',
    toppingPrice: 0,
    toppingLabel: 'Standard Decor',
    message: ''
};

function initCustomBuilder() {
    renderPresets();
    attachListeners();
}

function renderPresets() {
    const grid = document.getElementById('preset-grid');
    grid.innerHTML = presetCakes.map(cake => `
        <div class="preset-card" data-id="${cake.id}">
            <img src="${cake.img}" alt="${cake.name}" class="preset-img">
            <div class="preset-info">
                <h4>${cake.name}</h4>
                <p style="color: hsl(var(--clr-primary)); font-weight: 600;">Starting at $${cake.basePrice}</p>
            </div>
        </div>
    `).join('');

    // Add selection logic
    const cards = document.querySelectorAll('.preset-card');
    cards.forEach(card => {
        card.addEventListener('click', () => {
            // Remove selection
            cards.forEach(c => c.classList.remove('selected'));
            // Select this one
            card.classList.add('selected');
            
            const cakeId = card.getAttribute('data-id');
            selectedPreset = presetCakes.find(p => p.id === cakeId);
            
            updateSummary();
            document.getElementById('btn-place-order').disabled = false;
        });
    });
}

function attachListeners() {
    const sizeSelect = document.getElementById('cake-size');
    const toppingSelect = document.getElementById('cake-topping');
    const msgInput = document.getElementById('cake-message');

    sizeSelect.addEventListener('change', (e) => {
        state.sizeMultiplier = parseFloat(e.target.value);
        state.sizeLabel = e.target.options[e.target.selectedIndex].text.split('(')[0].trim();
        updateSummary();
    });

    toppingSelect.addEventListener('change', (e) => {
        const val = e.target.value;
        if (val === 'none') {
            state.toppingPrice = 0;
            state.toppingLabel = 'Standard Decor';
        } else {
            state.toppingPrice = 5;
            state.toppingLabel = e.target.options[e.target.selectedIndex].text.split('(')[0].trim();
        }
        updateSummary();
    });

    msgInput.addEventListener('input', (e) => {
        state.message = e.target.value;
    });

    // Place Order
    document.getElementById('btn-place-order').addEventListener('click', handlePlaceOrder);
}

function updateSummary() {
    if (!selectedPreset) return;

    // Base Price * Size Multiplier + Topping Price
    const total = (selectedPreset.basePrice * state.sizeMultiplier) + state.toppingPrice;

    document.getElementById('summary-base-name').textContent = selectedPreset.name;
    document.getElementById('summary-size').textContent = state.sizeLabel;
    document.getElementById('summary-topping').textContent = state.toppingLabel + (state.toppingPrice > 0 ? ` (+$${state.toppingPrice})` : '');
    document.getElementById('summary-img').src = selectedPreset.img;
    document.getElementById('summary-total').textContent = `$${total.toFixed(2)}`;
}

async function handlePlaceOrder() {
    if (!selectedPreset) return;

    const total = (selectedPreset.basePrice * state.sizeMultiplier) + state.toppingPrice;
    const btn = document.getElementById('btn-place-order');
    
    // Disable button and show loading state
    btn.disabled = true;
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';

    const orderData = {
        presetName: selectedPreset.name,
        size: state.sizeLabel,
        topping: state.toppingLabel,
        message: state.message || 'None',
        totalPrice: total
    };

    try {
        const response = await fetch('/checkout/init-custom', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(orderData)
        });


        const result = await response.json();

        if (result.success) {
            window.showToast("Preparing your checkout... Redirecting.");
            setTimeout(() => {
                window.location.href = '/checkout'; 
            }, 1000);
        } else {
            window.showToast("Error: " + result.message);
            btn.disabled = false;
            btn.innerHTML = originalText;
        }
    } catch (error) {
        console.error('Order Error:', error);
        window.showToast("Failed to connect to server.");
        btn.disabled = false;
        btn.innerHTML = originalText;
    }



}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', initCustomBuilder);

/**
 * Logic for Custom Cake Builder
 */


const { createApp, ref } = Vue

createApp({
    data() {
        return {
            cakes: [],
            modifiers: [],
            text: '',
            currentModifiers: {},
            current: [],
            total: 0,
        }
    },
    computed: {

    },
    methods: {
        async fetchCustomCakes() {

            const response = await fetch(
                "/api/products/fetch-custom-cakes",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    }
                }
            )

            if (!response.ok) {
                throw new Error("Failed to fetch custom cakes")
            }

            const data = await response.json()

            this.current = data[0];
            this.cakes = data;
            console.log("Custom Cakes:", data)
        },
        async fetchCustomModifiers() {

            const response = await fetch(
                "/api/products/fetch-custom-modifiers",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    }
                }
            )

            if (!response.ok) {
                throw new Error("Failed to fetch custom modifiers")
            }

            const data = await response.json()

            this.modifiers = data

            for (x of data) {
                this.currentModifiers[x.modifierId] = x.modifierList[0].modifierValueId;
            }

            console.log("Custom Modifiers:", data)

        },
        placeOrder() {
            const orderData = {
                cakeId: this.current.id,
                modifiers: this.currentModifiers,
                text: this.text,
                totalPrice: this.total
            };
            console.log("Placing order with data:", orderData);
            fetch("/api/orders/place-custom-order", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(orderData)
            })
                .then(response => {
                    if (!response.ok) {

                        Swal.mixin({
                            toast: true,
                            position: "top-end",
                            showConfirmButton: false,
                            timer: 3000,
                            timerProgressBar: true,
                            didOpen: (toast) => {
                                toast.onmouseenter = Swal.stopTimer;
                                toast.onmouseleave = Swal.resumeTimer;
                            }
                        }).fire({
                            icon: "error",
                            title: "Failed to place order"
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Order placed successfully:", data);
                    Swal.mixin({
                        toast: true,
                        position: "top-end",
                        showConfirmButton: false,
                        timer: 3000,
                        timerProgressBar: true,
                        didOpen: (toast) => {
                            toast.onmouseenter = Swal.stopTimer;
                            toast.onmouseleave = Swal.resumeTimer;
                        }
                    }).fire({
                        icon: "success",
                        title: "Order placed successfully !"
                    });
                })
                .catch(error => {
                    console.error("Error placing order:", error);
                    Swal.mixin({
                        toast: true,
                        position: "top-end",
                        showConfirmButton: false,
                        timer: 3000,
                        timerProgressBar: true,
                        didOpen: (toast) => {
                            toast.onmouseenter = Swal.stopTimer;
                            toast.onmouseleave = Swal.resumeTimer;
                        }
                    }).fire({
                        icon: "error",
                        title: "Error placing order"
                    });
                });
        },


        showModifierValues(modifierId) {
            return this.modifiers.find(x => x.modifierId == modifierId).modifierList.find(r => r.modifierValueId == this.currentModifiers[modifierId]).modifierValue;
        },

        changeCakes(cake) {
            this.current = cake;
            this.recalculateTotal();
        },

        recalculateTotal() {
            let total = this.current.price;

            for (const modId in this.currentModifiers) {
                const modValueId = this.currentModifiers[modId];
                const mod = this.modifiers.find(m => m.modifierId == modId);
                if (mod) {
                    const modValue = mod.modifierList.find(v => v.modifierValueId == modValueId);
                    if (modValue) {
                        total += modValue.priceModifier;
                    }
                }
            }
            this.total = total;
        }
    },

    mounted() {
        this.fetchCustomCakes();
        this.fetchCustomModifiers();
        this.recalculateTotal();
    },


}).mount('#app')


const presetCakes = [
    { id: 'pres_1', name: 'Rich Chocolate Truffle', basePrice: 50, img: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=500&h=400&fit=crop' },
    { id: 'pres_2', name: 'Madagascar Vanilla Bean', basePrice: 45, img: 'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=500&h=400&fit=crop' },
    { id: 'pres_3', name: 'Classic Red Velvet', basePrice: 55, img: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=500&h=400&fit=crop' },
    { id: 'pres_4', name: 'Black Forest Dream', basePrice: 52, img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ_QOYax_PpaHEE2hYCKPDN7sV8agXvFIt7Q&s?w=500&h=400&fit=crop' }
];


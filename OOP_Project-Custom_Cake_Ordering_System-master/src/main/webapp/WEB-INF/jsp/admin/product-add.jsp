<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Product | Admin Dashboard</title>
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

        .form-container {
            background: hsl(var(--clr-surface));
            border-radius: 16px;
            padding: 3rem;
            box-shadow: var(--shadow-sm);
            max-width: 800px;
            margin: 0 auto 5rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: hsl(var(--clr-text-dark) / 0.8);
        }

        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            font-family: var(--font-sans);
            font-size: 1rem;
            transition: all var(--transition-fast);
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: hsl(var(--clr-primary));
            box-shadow: 0 0 0 3px hsl(var(--clr-primary) / 0.1);
        }

        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }

        .image-upload-area {
            border: 2px dashed rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            background: hsl(var(--clr-surface-dim));
            cursor: pointer;
            transition: all var(--transition-fast);
        }

        .image-upload-area:hover {
            border-color: hsl(var(--clr-primary));
            background: hsl(var(--clr-primary) / 0.05);
        }

        .upload-icon {
            font-size: 2.5rem;
            color: hsl(var(--clr-primary) / 0.5);
            margin-bottom: 1rem;
        }

        .btn-submit {
            width: 100%;
            padding: 1rem;
            font-size: 1.1rem;
            margin-top: 1rem;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

    <t:styles />
    <t:header />

    <header class="page-header">
        <div class="container">
            <h1>Add New Product</h1>
            <p style="font-size: 1.1rem; opacity: 0.9; margin-top: 0.5rem;">Create a new sweet treat for the catalog</p>
        </div>
    </header>

    <main class="container">
        <div class="form-container">
            <form action="/admin/product/add" method="POST" enctype="multipart/form-data">
                
                <div class="form-group full-width" style="margin-bottom: 2rem;">
                    <label class="form-label">Product Image</label>
                    <div class="image-upload-area">
                        <i class="fa-solid fa-cloud-arrow-up upload-icon"></i>
                        <p style="font-weight: 500; margin-bottom: 0.5rem;">Click or drag to upload an image</p>
                        <p style="font-size: 0.85rem; color: hsl(var(--clr-text-dark) / 0.6);">PNG, JPG up to 5MB</p>
                    </div>
                    <input type="file" name="image" id="image" accept="image/*" style="display: none;" required>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="name">Product Name</label>
                        <input type="text" id="name" name="name" class="form-input" placeholder="e.g. Classic Chocolate Cake" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="category">Category</label>
                        <select id="category" name="category" class="form-select" required>
                            <option value="">Select a category...</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="price">Price (LKR)</label>
                        <input type="number" id="price" name="price" class="form-input" placeholder="0.00" min="0" step="0.01" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="stock">Stock Quantity</label>
                        <input type="number" id="stock" name="stock" class="form-input" placeholder="10" min="0" required>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label" for="description">Product Description</label>
                        <textarea id="description" name="description" class="form-textarea" placeholder="Describe the cake, flavors, and ingredients..." required></textarea>
                    </div>
                </div>

                <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                    <button type="button" class="btn btn-outline" style="width: 30%; justify-content: center;" onclick="window.history.back()">Cancel</button>
                    <button type="submit" class="btn btn-primary btn-submit" style="width: 70%; margin-top: 0; justify-content: center;">
                        <i class="fa-solid fa-plus" style="margin-right: 8px;"></i> Add Product
                    </button>
                </div>
            </form>
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

    <script>
        const uploadArea = document.querySelector('.image-upload-area');
        const fileInput = document.querySelector('#image');

        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });

        fileInput.addEventListener('change', (e) => {
            if(e.target.files.length > 0) {
                uploadArea.innerHTML = `<i class="fa-solid fa-check-circle upload-icon" style="color: #10b981;"></i>
                                        <p style="font-weight: 500; color: #10b981;">${e.target.files[0].name} selected</p>`;
            }
        });
    </script>
</body>
</html>

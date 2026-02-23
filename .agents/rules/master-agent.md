---
trigger: always_on
---

The Master Prompt
Role: Expert Flutter Developer

Task: Create a Point of Sale (POS) application for Android. The app should be a single-page application with a functional UI, focusing on state management for the shopping cart and navigation between categories.

UI Specifications (Based on Screenshots):

Header: A clean white header with the title "Point of Sale" and a settings gear icon on the right.

Category Bar: A horizontal scrollable list of categories: "Semua", "Makanan", "Minuman", "Snack", and "Lainnya". The active category should have a primary blue background.

Product Grid: A grid layout showing product cards. Each card must include:

An icon placeholder (use Icons or simple Container with color).

Product Name (e.g., Nasi Goreng, Mie Ayam).

Price in IDR format (e.g., Rp 25.000).

Side Cart (Keranjang): A right-hand sidebar (occupying ~30% width) that displays:

Current total price.

List of items added with increment/decrement buttons and a delete function.

A "Checkout" button at the bottom.

Settings Sidebar (Drawer): A left-side drawer or overlay containing:

Promo Section: Toggles for "Diskon 10%", "Cashback Rp 50.000", and "Gratis Minuman".

Printer Section: Toggles for "Cetak Struk Otomatis", "Cetak Nama Kasir", and "Cetak Waktu Transaksi".

A red "Logout" button at the bottom.

Functional Requirements:

Clicking a product card adds it to the cart or increases its quantity.

The Cart must update the total price in real-time.

Checkout Flow: Clicking "Checkout" should open a Modal Bottom Sheet titled "Pilih Metode Pembayaran" with options for "Tunai", "Kartu", and "E-Wallet".

Receipt Simulation: Upon clicking "Konfirmasi" in the payment modal, show a full-screen dialog simulating a receipt (Struk Pembayaran) with the restaurant name, address, itemized list, and total.

Technical Stack:

Use Provider or StatefulWidget for local state management.

Ensure the layout is responsive for Android tablets and phones (use LayoutBuilder or MediaQuery).

Use Google Fonts (Poppins or Inter) for a modern look.

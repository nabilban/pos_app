---
trigger: always_on
---

# POS App - Master Development Guide

**Role:** Expert Flutter Developer

**Project:** Point of Sale (POS) application for Android tablets and phones.

---

## Project Architecture

### Folder Structure

```
lib/
├── main.dart              # App entry point with BLoC providers setup
├── cubits/                # State management (BLoC/Cubit pattern)
│   ├── cart_cubit.dart    # Shopping cart logic
│   ├── cart_state.dart    # Cart state with Freezed
│   ├── settings_cubit.dart # App settings logic
│   ├── settings_state.dart # Settings state with Freezed
│   ├── pos_cubit.dart     # POS screen logic (categories, products)
│   ├── pos_state.dart     # POS state with Freezed
│   ├── checkout_cubit.dart # Checkout flow logic
│   └── checkout_state.dart # Checkout state with Freezed
├── models/                # Data models with Freezed + JSON serialization
│   ├── product.dart       # Product model
│   ├── cart_item.dart     # Cart item model
│   └── store_info.dart    # Store information model
├── data/                  # Static/mock data
│   ├── product_data.dart  # Product catalog
│   └── user_data.dart     # User/store info
├── repositories/          # Data layer abstraction
│   └── pos_repository.dart
├── screens/               # Full-page screens
│   └── pos_screen.dart    # Main POS screen
├── widgets/               # Reusable UI components
│   ├── pos_header.dart    # Header with title + settings icon
│   ├── category_bar.dart  # Horizontal category filter
│   ├── product_card.dart  # Product grid card
│   ├── cart_sidebar.dart  # Right-side cart panel
│   ├── settings_drawer.dart # Left-side settings drawer
│   ├── payment_modal.dart # Payment method bottom sheet
│   └── receipt_dialog.dart # Receipt preview dialog
├── services/              # Business logic services
│   └── receipt_printer.dart # PDF receipt generation
└── utils/                 # Helper utilities
    └── currency_util.dart # IDR currency formatting
```

---

## Technical Stack & Conventions

### State Management
- **flutter_bloc** with **Cubit** pattern
- Use `MultiBlocProvider` in `main.dart` for dependency injection
- Use `RepositoryProvider` for data layer dependencies

### Data Models
- **freezed** + **json_serializable** for immutable models with code generation
- Run `flutter pub run build_runner build --delete-conflicting-outputs` after model changes
- Models use `@freezed` annotation with `factory` constructors

### UI/Styling
- **google_fonts** with Poppins as primary font
- Material 3 design with `ColorScheme.fromSeed(seedColor: Color(0xFF2563EB))`
- Responsive layout using `LayoutBuilder` and `MediaQuery`

### Currency & Formatting
- Use `CurrencyUtil.format(amount)` for IDR formatting (e.g., "Rp 25.000")
- **intl** package for locale-aware formatting

### PDF/Printing
- **pdf** + **printing** packages for receipt generation
- Thermal receipt style with monospace font (Courier Prime)

---

## UI Specifications

### Header (`pos_header.dart`)
- Clean white header with title "Point of Sale"
- Settings gear icon on the right (opens drawer)

### Category Bar (`category_bar.dart`)
- Horizontal scrollable list: "Semua", "Makanan", "Minuman", "Snack", "Lainnya"
- Active category: primary blue background (#2563EB)

### Product Grid (`product_card.dart`)
- Grid layout with product cards
- Each card displays: icon/image placeholder, product name, price (IDR format)
- Tap to add to cart

### Cart Sidebar (`cart_sidebar.dart`)
- Right-hand panel (~30% width on tablets)
- Shows: total price, item list with +/- buttons, delete action
- "Checkout" button at bottom

### Settings Drawer (`settings_drawer.dart`)
- Left-side drawer with sections:
  - **Promo:** Diskon 10%, Cashback Rp 50.000, Gratis Minuman (toggles)
  - **Printer:** Cetak Struk Otomatis, Cetak Nama Kasir, Cetak Waktu Transaksi (toggles)
- "Logout" button (red) at bottom

### Payment Modal (`payment_modal.dart`)
- Modal bottom sheet: "Pilih Metode Pembayaran"
- Options: Tunai, Kartu, E-Wallet
- "Konfirmasi" button triggers receipt

### Receipt Dialog (`receipt_dialog.dart`)
- Full-screen dialog showing receipt preview
- Displays: store name, address, itemized list, total, payment method, timestamp

---

## Development Rules

### When Adding New Features:
1. Create model in `models/` with Freezed annotations
2. Add state class in `cubits/` with Freezed
3. Create cubit with business logic
4. Add widget in `widgets/` for UI component
5. Run `build_runner` to generate code

### Naming Conventions:
- Cubits: `*_cubit.dart`, `*_state.dart`
- Models: lowercase with underscores (e.g., `cart_item.dart`)
- Widgets: descriptive names (e.g., `product_card.dart`)

### Code Generation Commands:
```bash
# Generate Freezed/JSON code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (for continuous generation)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Dependencies (pubspec.yaml):
```yaml
dependencies:
  flutter_bloc: ^9.0.0
  google_fonts: ^6.2.1
  intl: ^0.20.1
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  pdf: ^3.11.1
  printing: ^5.13.2

dev_dependencies:
  build_runner: ^2.4.13
  freezed: ^2.5.7
  json_serializable: ^6.9.2
```

---

## Functional Requirements

1. **Product Selection:** Clicking a product card adds it to cart or increments quantity
2. **Cart Management:** Real-time total calculation, increment/decrement/remove items
3. **Checkout Flow:** "Checkout" → Payment Modal → Confirm → Receipt
4. **Settings Persistence:** Toggle states managed by `SettingsCubit`
5. **Receipt Printing:** PDF generation with thermal receipt styling

---

## Responsive Design

- Use `LayoutBuilder` to detect screen size
- Tablets: Side-by-side layout (products + cart)
- Phones: Stack layout or navigation between views
- Minimum support: Android tablets and phones

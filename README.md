# Mini Catalog App 📱

A modern, responsive mini e-commerce catalog application built with **Flutter**.

---

## 📸 Screenshots

### 1. Discover Screen
![Discover](assets/discover.png)

### 2. Product Detail Screen
![Detail](assets/detail.png)

### 3. Shopping Cart Screen
![Cart](assets/cart.png)

---

## 🌟 Features
- **Product Listing:** Display products in a clean 2-column grid.
- **Search:** Real-time title and description filtering.
- **Product Details:** Dynamic specification tags and product description.
- **Cart Management:** Add products to cart and track total item count.

---

## 🛠️ Tech Stack & Architecture
- **Framework:** Flutter (Dart)
- **State Management:** `StatefulWidget`
- **Navigation:** Named Routes (`/`, `/product-detail`, `/cart`)
- **Data Model:** JSON Serialization (`Product.fromJson` / `toJson`)

---

## 🚀 How to Run
```bash
# 1. Clone the repository
git clone <YOUR-GITHUB-REPO-URL>

# 2. Go to project directory
cd mini_catalog_app

# 3. Get packages
flutter pub get

# 4. Run application
flutter run -d chrome

# Aquire

Aquire is a FoundationOS-inspired concept storefront for fictional hardware devices, built with SwiftUI for iOS and macOS.

It’s a design + architecture playground for:
- A liquid-glass, prismatic UI
- A “device showroom” catalog
- Wishlist, orders, and acquired items
- Admin + debug tooling baked into the app

---

## Features

- **Browse catalog**
  - Card-based grid of Foundation devices
  - Category + search support

- **Product detail**
  - Big hero product card
  - Description, price, status
  - Hooks for 3D / USDZ preview

- **Wishlist & Acquired**
  - Mark items as wishlisted
  - Mark items as acquired
  - Separate tabs to browse what you own vs what you want

- **Orders**
  - Fake order history with statuses like “Processing” / “Shipped”
  - Good for testing list layouts and status pills

- **Admin panel**
  - Mark products as featured or hidden
  - Attach badges like “LABS” / “BETA”
  - Designed as an in-app CMS for the catalog

- **Debug overlay**
  - Developer-only overlay toggle
  - Handy for surfacing internal state while testing

---

## Tech Stack

- **Language:** Swift
- **UI:** SwiftUI
- **Platforms:** iOS and macOS (single codebase)
- **Architecture:**
  - `StoreModel` as a central `ObservableObject` for products, orders, and metadata
  - Feature views: Home, Browse, Wishlist, Acquired, Orders, Settings, Info, Admin
  - Shared UI components for backgrounds, cards, and buttons

---

## Getting Started

1. Clone the repo:

   ```bash
   git clone https://github.com/ashgotcryptidcravings/Aquire.git
   cd Aquire

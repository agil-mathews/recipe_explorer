# 🍽️ Recipe Explorer

Recipe Explorer is a Flutter application built using the MVVM architecture and Riverpod state management.  
The app allows users to explore meal categories, search recipes, view detailed cooking instructions, watch recipe videos, and manage favorite meals.

---

# ✨ Features

- Browse meal categories
- View meals by category
- Search meals with debounce support
- Detailed recipe screen
- Ingredients and cooking instructions
- Watch recipe tutorial videos on YouTube
- Add/remove favorites
- Pull-to-refresh support
- Loading, error, and empty states handling
- Reusable widgets and clean UI structure

---

# 🏗️ Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture.


# ⚙️ State Management Choice

This project uses **Riverpod** for state management.

## Why Riverpod?

Riverpod was chosen because:

- It provides a clean and scalable architecture
- Makes state predictable and testable
- Eliminates unnecessary widget rebuilds
- Safer than Provider (compile-time safety)
- Works well with MVVM architecture
- Handles async states elegantly using `AsyncValue`

Example states handled:
- Loading
- Success
- Error

---

# 🌐 API Used

The application uses:

## TheMealDB API

https://www.themealdb.com/api.php

Endpoints used:

- `categories.php`
- `filter.php?c=category`
- `lookup.php?i=id`
- `search.php?s=query`

---

# 📦 Packages Used

```yaml
flutter_riverpod
http
url_launcher
shared_preferences
google_fonts
```

---

# 🚀 Setup Instructions

## 1. Clone the Repository

```bash
git clone <your_repo_url>
```

---

## 2. Navigate to Project

```bash
cd recipe_explorer
```

---

## 3. Install Dependencies

```bash
flutter pub get
```

---

## 4. Run the Application

```bash
flutter run
```

---

# 📱 Android Configuration

For opening YouTube recipe videos, add the following permissions inside:

```bash
android/app/src/main/AndroidManifest.xml
```

## Add Internet Permission

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Add Queries Section

```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW"/>
        <data android:scheme="https"/>
    </intent>
</queries>
```

---

# 🔄 API State Handling

Every API request handles:

- Loading State
- Success State
- Error State
- Retry Mechanism
- Timeout Handling
- Network Failure Handling

Reusable widgets created:
- `LoadingView`
- `ErrorView`

---

# 🔍 Search Functionality

Search is implemented using:

- `search.php?s=query`
- 500ms debounce
- Riverpod StateNotifier
- Dynamic UI states

States:
- Explore Foods
- No Results Found
- Search Results

---

# ❤️ Favorites

Users can:

- Add meals to favorites
- Remove meals from favorites
- Pull to refresh favorites screen

---

# 🎥 Recipe Video Feature

Detailed meal screen includes:

- Watch Recipe Video button
- Opens YouTube tutorial using `url_launcher`

---

# 🎨 UI Highlights

- Modern card-based UI
- Gradient overlays
- Responsive layouts
- Pull-to-refresh animations

---



# 👨‍💻 Developed With

- Flutter
- Dart
- Riverpod
- MVVM Architecture

Release APK Link:https://drive.google.com/file/d/1H2uMXAo8ZbnIFl3RMTrTRZX5udhiAJad/view?usp=share_link<img width="738" height="1600" alt="WhatsApp Image 2026-05-23 at 14 35 18" src="https://github.com/user-attachments/assets/f2f88cd0-4f9f-4efd-9975-919560ea7638" />
<img width="738" height="1600" alt="WhatsApp Image 2026-05-23 at 14 35 17" src="https://github.com/user-attachments/assets/f80cc667-2b62-420a-ba30-045cce8f0950" />
<img width="738" height="1600" alt="WhatsApp Image 2026-05-23 at 14 35 17 (1)" src="https://github.com/user-attachments/assets/e835df62-4ca5-4a4f-b066-a1f421302dfa" />
<img width="738" height="1600" alt="WhatsApp Image 2026-05-23 at 14 35 16" src="https://github.com/user-attachments/assets/894ac37d-cb8d-4b3e-a344-c582df2e03b8" />
<img width="738" height="1600" alt="WhatsApp Image 2026-05-23 at 14 35 16 (1)" src="https://github.com/user-attachments/assets/5b677ae3-dee1-4bdf-a9ac-1b0f777c1062" />



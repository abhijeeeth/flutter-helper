# Abhijith Shaji's Flutter Tips, Tricks, and Reusable Widgets 🚀

Welcome to my Flutter repository! Here, you'll find a collection of **tips, tricks**, and **reusable widgets** that I've curated to help Flutter developers streamline their workflow. Additionally, I share solutions for **iOS-specific bugs**, along with **launcher icons setup** and more.

---

## 📌 What You'll Find

- **Reusable Widgets**: Simplify your UI development with pre-built, reusable components.
- **Tips & Tricks**: Handy Flutter tips to boost productivity and improve your apps.
- **iOS Bug Fixes**: Solutions for common issues when building apps for iOS.
- **Launcher Icons Code**: Step-by-step instructions and sample code for setting up custom launcher icons.

---

## 📁 Repository Structure

├── reusable_widgets/ # Pre-built Flutter widgets ├── tips_tricks/ # Flutter development tips and tricks ├── ios_bugs/ # iOS bug fixes and solutions ├── launcher_icons/ # Launcher icon setup and samples └── README.md # Documentation

yaml
Copy code

---

## 🌟 Featured Widgets

### 1. **CustomButton**
A stylish, customizable button widget you can reuse across your app.

### 2. **ShimmerLoader**
Add beautiful shimmer effects for loading states to enhance user experience.

### 3. **ResponsiveCard**
A fully responsive card widget perfect for adaptive layouts.

---

## 🛠️ Tips & Tricks

- Use `Expanded` and `Flexible` for optimizing layouts.
- Adopt `Bloc` or `Riverpod` for efficient state management.
- Leverage `Flutter DevTools` for faster debugging and performance analysis.

---

## 🐛 iOS Bugs & Fixes

### 1. **Build Issues**
- Resolve common `pod install` or `Xcode` build failures with the following:
  ```bash
  sudo arch -x86_64 gem install ffi
  arch -x86_64 pod install
2. Push Notifications
Fix Firebase messaging issues by ensuring you set the correct APNs certificate.
3. App Icons Not Displaying
Troubleshoot missing icons on iOS builds by double-checking the Assets.xcassets configuration.
🎨 Launcher Icons Setup
Use the flutter_launcher_icons package to set up custom launcher icons in your app.

Sample pubspec.yaml Configuration:
yaml
Copy code
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
Steps:
Add the above configuration to your pubspec.yaml.
Run the following command:
bash
Copy code
flutter pub run flutter_launcher_icons:main
🤝 Contributions
Feel free to fork the repository, submit issues, or create pull requests. Let's make Flutter development easier together!

📧 Contact Me
I'm always open to discussions, collaborations, and feedback. Reach out to me at:
Email: st.abhijithh@gmail.com
LinkedIn: Abhijith Shaji

📖 License
This repository is licensed under the MIT License. See the LICENSE file for more details.

Happy coding! 💻
~ Abhijith Shaji
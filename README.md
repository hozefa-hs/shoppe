# Shoppe 
### E-commerce Mobile Application 📱

**Shoppe is a Flutter-based e-commerce mobile application powered by Firebase, designed to deliver a seamless shopping experience. The app features role-based access for Admin and Users, enabling product management, order tracking, and secure payments. With UPI payment integration, Firebase notifications, and optimized performance using caching techniques, Shoppe provides a modern, efficient, and user-friendly platform for online shopping.**


## 📸 Screenshots

| Splash Screen | Login Screen | Sign Up Screen  
| --- | --- | --- |
| ![welcome](https://github.com/user-attachments/assets/f44274fb-3ed1-4b67-bd68-58ef2e832195) | ![Screenshot_20250125_203206](https://github.com/user-attachments/assets/5d7eceef-caac-493c-99ab-f834562714a9) | ![Screenshot_20250125_203031](https://github.com/user-attachments/assets/991c4eaf-6302-418f-861c-6545c52bf62e)

| Loading Screen | Home Screen | Home Screen | Home Screen 
| --- | --- | --- | --- |
| [loading.webm](https://github.com/user-attachments/assets/7361afbf-d246-47ff-bc0a-fceee7c5d985) | ![homescreen1](https://github.com/user-attachments/assets/53a463bc-b063-4c13-8154-d24e0cfcc473) | ![homescreen2](https://github.com/user-attachments/assets/4fe58f7e-3b60-4794-8115-c323687a0719) | ![homescreen3](https://github.com/user-attachments/assets/b669a1db-9a03-4a11-8e9f-00accca37876)

| Product Detail | Product Detail | Qty Dialog | Product Detail
| --- | --- | --- | --- |
| ![productdetail](https://github.com/user-attachments/assets/76cced79-622d-4155-afef-5047d357510b) | ![productdetail2](https://github.com/user-attachments/assets/4bb2a9c7-0557-45d8-bde7-c029061a7509) | ![productdetail3](https://github.com/user-attachments/assets/7f061e11-f2c0-4cf9-99a6-69cebbc7093c) | ![productdetail4](https://github.com/user-attachments/assets/860685fa-3193-4eb6-9da6-c3d131102937)

Cart Screen | Payment Screen | Payment Sucess 
| --- | --- | --- |
| ![cart](https://github.com/user-attachments/assets/501d853b-6134-43ea-9501-fcbc2828843b) | ![payment](https://github.com/user-attachments/assets/d12a7c21-fea8-4021-a17f-333e704ca10e)

## Admin Screenshots

| Dashboard| Categories | Products | Logout |
| --- | --- | --- | --- | 
| ![admin dashboard](https://github.com/user-attachments/assets/26d9fac2-f2c5-4e14-b4f3-d87311544cec) | ![manage categories](https://github.com/user-attachments/assets/a4235dc8-822a-4b4c-b552-42b01fdbdd5f) | ![manage products](https://github.com/user-attachments/assets/a0ccf30a-9bf5-4cad-9f98-9fea820c0f55) | ![logout](https://github.com/user-attachments/assets/4b18b5c9-0c45-4a05-b879-252842644cc4)


## Features ✨

- **Authentication**: Secure login and signup with Firebase Authentication, including role-based access for Admins and Users.
- **Admin Panel**: Manage categories, products, and orders dynamically.
- **User Panel**: Browse products, add items to the cart, and place orders easily.
- **Modern UI**: Clean and responsive design for an intuitive shopping experience.
- **Cart Management**: Add multiple items to the cart with real-time updates.
- **UPI Payment Integration**: Seamless payment experience with UPI apps.
- **Notifications**: Receive updates via Firebase Cloud Messaging.

## Tech Stack 🛠️

- **Frontend**
    - **Flutter**: For building a cross-platform mobile application with a modern UI.
    - **Provider**: State management for efficient and reactive UI updates.
- **Backend** 
    - **Firebase Authentication**: For secure user authentication and role-based access.
    - **Cloud Firestore**: Real-time database for storing and managing data.
    - **Firebase Cloud Messaging (FCM)**: For sending push notifications.
- **Third-Party Integrations**:
    - **Cached Network Image**: For optimized image loading and caching.
    - **UPI Payment Gateway**: For seamless payment processing.



## Folder Structure 📂

```
shoppe/
├── android/                # Android-specific files
├── ios/                    # iOS-specific files
├── lib/                    # Main source code
│   ├── models/             # Data models
│   ├── screens/            # UI screens
│   ├── widgets/            # Reusable widgets
│   ├── services/           # Business logic and services
│   ├── utils/              # Utility functions
│   └── main.dart           # Entry point of the application
├── assets/                 # Images, fonts, and other assets
├── test/                   # Unit and widget tests
├── pubspec.yaml            # Project configuration file
└── README.md               # Project documentation
```  



## Getting Started 🚀

To get a local copy up and running follow these simple steps.

### Prerequisites ✅

Make sure you have Flutter installed on your machine. You can download it from [here](https://flutter.dev/docs/get-started/install).

### Installation 🛠️

1. Clone the repository:
        ```bash
        git clone https://github.com/hozefa-hs/shoppe.git
        ```
2. Navigate to the project directory:
        ```bash
        cd shoppe
        ```
3. Install dependencies:
        ```bash
        flutter pub get
        ```
4. Run the app:
        ```bash
        flutter run
        ```

## Acknowledgements 🙏

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Stripe](https://stripe.com/)
- [Provider](https://pub.dev/packages/provider)


## Installation 🛠️

1. Clone the repository:
        ```bash
        git clone https://github.com/yourusername/shoppe.git
        ```
2. Navigate to the project directory:
        ```bash
        cd shoppe
        ```
3. Install dependencies:
        ```bash
        flutter pub get
        ```
4. Run the app:
        ```bash
        flutter run
        ```


## Contributing 🤝

1. Fork the repository.
2. Create a new branch:
        ```bash
        git checkout -b feature-name
        ```
3. Make your changes.
4. Commit your changes:
        ```bash
        git commit -m 'Add some feature'
        ```
5. Push to the branch:
        ```bash
        git push origin feature-name
        ```
6. Open a pull request.

## Support 💖

If you like this project, please consider giving it a ⭐ on [GitHub](https://github.com/hozefa-hs/shoppe)!

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact 📧

Connect with me on [LinkedIn](https://www.linkedin.com/in/hozefa-sailanawala/).
For any inquiries, please [Contact me](mailto:hozefawork16@gmail.com).

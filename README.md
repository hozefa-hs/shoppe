# Shoppe
### E-commerce Mobile Application

**Shoppe is a Flutter-based e-commerce mobile application powered by Firebase, designed to deliver a seamless shopping experience. The app features role-based access for Admin and Users, enabling product management, order tracking, and secure payments. With UPI payment integration, Firebase notifications, and optimized performance using caching techniques, Shoppe provides a modern, efficient, and user-friendly platform for online shopping.**


## Screenshots

![Home Screen](screenshots/home.png)
![Product Details](screenshots/product_details.png)
![Cart](screenshots/cart.png)  



## Features

- **Authentication**: Secure login and signup with Firebase Authentication, including role-based access for Admins and Users.
- **Admin Panel**: Manage categories, products, and orders dynamically.
- **User Panel**: Browse products, add items to the cart, and place orders easily.
- **Modern UI**: Clean and responsive design for an intuitive shopping experience.
- **Cart Management**: Add multiple items to the cart with real-time updates.
- **UPI Payment Integration**: Seamless payment experience with UPI apps.
- **Notifications**: Receive updates via Firebase Cloud Messaging.

## Tech Stack

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



## Folder Structure

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




## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

Make sure you have Flutter installed on your machine. You can download it from [here](https://flutter.dev/docs/get-started/install).

### Installation

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

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Stripe](https://stripe.com/)
- [Provider](https://pub.dev/packages/provider)


## Installation

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


## Contributing

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

## Support

If you like this project, please consider giving it a ⭐ on [GitHub](https://github.com/hozefa-hs/shoppe)!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Connect with me on [LinkedIn](https://www.linkedin.com/in/hozefa-sailanawala/).
For any inquiries, please [Contact me](mailto:hozefawork16@gmail.com).

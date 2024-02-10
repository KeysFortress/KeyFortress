# KeyFortress: Secure Mobile Password Manager

KeyFortress is a robust mobile application designed to safeguard your digital identity by providing a comprehensive suite of security features. With a focus on user-friendly functionality and cutting-edge encryption, KeyFortress ensures the utmost protection for your sensitive information.

## Features:

### 1. Password Generation
Generate strong and unique passwords effortlessly with KeyFortress. Enhance your online security by creating complex passwords tailored to meet the highest standards. Say goodbye to weak and easily guessable passwords.

### 2. End-to-End Encryption for Device Sharing
KeyFortress employs state-of-the-art end-to-end encryption to secure your data during device sharing. Safely collaborate and sync your passwords across multiple devices without compromising security. Your information remains confidential and protected from unauthorized access.

### 3. TOTP (Time-Based One-Time Passwords)
Enable an additional layer of security with Time-Based One-Time Passwords (TOTP). KeyFortress supports TOTP, allowing you to generate temporary and unique codes that add an extra level of protection to your accounts. Stay one step ahead of potential threats.

### 4. Passwordless Authenticator
Experience hassle-free authentication with KeyFortress's Passwordless Authenticator. Eliminate the need for traditional passwords and enhance user convenience while maintaining top-notch security. Log in effortlessly without compromising on safety.

## Why KeyFortress?

- **Security First:** Your data is encrypted end-to-end, ensuring that only you have access to your sensitive information.

- **User-Friendly:** Enjoy a seamless and intuitive user interface, making it easy to manage and organize your passwords securely.

- **Versatile:** Whether you need strong password generation, TOTP support, or passwordless authentication, KeyFortress has you covered.

- **Cross-Platform Sync:** Access your passwords and data securely from multiple devices, with synchronized data that remains protected at all times.

Download KeyFortress today and take control of your digital security with confidence. Safeguard your passwords, simplify authentication, and stay ahead of potential security threats. Your digital fortress is just a download away!

## Prerequisites


### Flutter Build Details

For more Flutter build details, refer to the [official documentation](https://flutter.dev/docs).


This solution is developed using the [clean architecture](hhttps://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html). In order to make it as modular as possible, with the goal to make all of the code, compatible and reusable between the Desktop version and this version (mobile) a lot of the code has to be separated from the main presentation layer which is this repository.

In order to do this, we have abstracted all of the different layers as submodules, before trying to build please see the section on submodule updates after cloning the repository.

### Submodule Update

To update submodules to the latest commit:

```bash
git submodule -init
git submodule update --remote --recursive
```

### Build for Android

```bash
cd KeyFortress
flutter build apk
```

### Build for iOS

```bash
cd KeyFortress
flutter build ios
```

The iOS app is generated in the `build/ios/` directory. Further steps can be performed by opening the project in Xcode. Note that building for iOS requires a macOS machine with Xcode installed.

### Build for Windows, Mac, Linux

For desktop platforms, refer to the [KeyFortress Desktop Repository](https://github.com/KeysFortress/KF_Desktop) for specific build instructions on Windows, Mac, and Linux.

---

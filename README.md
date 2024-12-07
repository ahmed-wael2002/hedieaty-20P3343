# **Hedieaty**

Welcome to **Hedieaty**, a social networking platform built with **Flutter** and integrated with **Firebase**, offering users a seamless experience to connect, manage friendships, and explore events. This project emphasizes clean architecture, modularity, and state management using the **Provider** package.

---

## **Table of Contents**
- [Features](#features)
- [Project Architecture](#project-architecture)
- [Technologies Used](#technologies-used)
- [Installation and Setup](#installation-and-setup)
- [Usage](#usage)
- [Directory Structure](#directory-structure)
- [Contributing](#contributing)
- [License](#license)

---

## **Features**
- **User Authentication**:
  - Sign up, log in, and log out functionalities powered by **Firebase Authentication**.
- **Friend Management**:
  - Add friends by phone number.
  - View a list of your friends with live updates.
- **Event Management**:
  - Browse a list of events (feature in progress).
- **Dynamic State Management**:
  - State is managed using the **Provider** package for a clean and reactive user experience.
- **Firestore Integration**:
  - All user data, including friend connections, is stored and retrieved in real-time using **Firestore**.
- **Customizable UI**:
  - Built with a clean and minimalistic design philosophy for a seamless user experience.

---

## **Project Architecture**
The project follows **Clean Architecture** principles to ensure scalability, modularity, and testability:
- **Presentation Layer**: Handles the user interface using Flutter widgets and state management (Provider).
- **Domain Layer**: Contains core business logic (entities and use cases).
- **Data Layer**: Manages interactions with Firestore (data sources and repositories).

---

## **Technologies Used**
- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Authentication, Firestore)
- **State Management**: Provider
- **Architecture**: Clean Architecture
- **Development Tools**: Android Studio, VS Code, GitHub

---

## **Installation and Setup**
To run the project locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/hedieaty.git
   cd hedieaty
   ```

2. **Install Dependencies**:
   Make sure you have Flutter installed. Run the following command:
   ```bash
   flutter pub get
   ```

3. **Set Up Firebase**:
   - Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).
   - Add an Android and/or iOS app to the project.
   - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place them in the appropriate folders.

4. **Run the Project**:
   Start the development server:
   ```bash
   flutter run
   ```

---

## **Usage**
1. **Sign Up / Log In**: Start by creating an account or logging in using your email and password.
2. **Manage Friends**:
   - Add friends by searching for their phone numbers.
   - View a dynamic list of friends updated in real-time.
3. **Explore Events**: Check out upcoming events (work in progress).

---

## **Directory Structure**
The project follows a modular structure:

```
lib/
├── features/
│   ├── auth/                 # Authentication module
│   │   ├── data/             # Repositories and data sources
│   │   ├── domain/           # Entities and use cases
│   │   └── presentation/     # UI and state management
│   ├── homepage/             # Home and friends management
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── events/               # Events management (in progress)
├── utils/                    # Shared utility widgets and methods
└── main.dart                 # App entry point
```

---

## **Contributing**
We welcome contributions to make **Hedieaty** even better! Here's how you can help:
1. Fork the repository.
2. Create a feature branch: `git checkout -b feature-name`.
3. Commit your changes: `git commit -m "Add new feature"`.
4. Push to the branch: `git push origin feature-name`.
5. Submit a pull request.

---

## **License**
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## **Screenshots**
![Login Page](assets/images/screenshot_login.png)  
*Login page for user authentication.*

![Friends List](assets/images/screenshot_friends_list.png)  
*Real-time dynamic friends list.*

![Profile Page](assets/images/screenshot_profile.png)  
*View and update your profile.*

---

Feel free to adapt this README to include additional sections or branding specific to your project!

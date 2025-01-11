# Task App

A simple Flutter task management app that allows users to log in using their email and password via Firebase Authentication. Tasks are stored both locally on the device using SQLite (sqflite) and in the cloud using Firebase Firestore, making the tasks visible to all users.

## Features

- User authentication with Firebase Email/Password login.
- Local task storage using SQLite (sqflite).
- Cloud task storage with Firebase Firestore.
- Tasks are synced across all devices for the users.

## Screen Recording

https://github.com/user-attachments/assets/33e83643-36c9-476c-8e7e-a1410cf73e14

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/kratikpal/task_app.git
```

### 2. Install dependencies

Run the following to install the Firebase packages:

```bash
flutter pub get
```

## Usage

### Running the App

Run the app on your emulator or physical device:

```bash
flutter run
```

### Authentication

1. On the login screen, users can log in using their email and password.
2. If the user doesn't have an account, they can register by entering a new email and password.
3. Upon successful login, the user is redirected to the tasks screen.

### Tasks

1. Users can create, update, and delete tasks.
2. Tasks are stored both locally using SQLite and remotely in Firebase Firestore.
3. All tasks are synced across all devices using Firestore, and any changes made will be reflected in real-time for all users.

### Task Synchronization

- Local tasks are stored in SQLite and can be accessed offline.
- Tasks are also saved in Firestore, which allows them to be shared across devices.
- Any changes made to the tasks (create, update, or delete) will sync to both local storage and Firestore, ensuring consistency.

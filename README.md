# Al-Baladiya: A Mobile Application for Municipal Complaints

This project, **Al-Baladiya**, is a mobile application aimed at improving communication between citizens and municipal administrations in Tunisia. It allows users to submit complaints, attach images, and track their complaint statuses in real-time using a unique ID. The app was developed using **Flutter** and deployed on the **AWS EC2** cloud infrastructure, leveraging **Firebase** for data management and real-time updates.

## Features

- **Submit Complaints**: Citizens can submit detailed complaints including titles, descriptions, locations, and images.
- **Track Complaints**: Track complaints in real-time via a unique complaint ID.
- **Chat Integration**: Real-time chat functionality between citizens and municipal admins for complaint updates.
- **Admin Dashboard**: Municipal administrators can review, manage, and respond to complaints through a dedicated dashboard.

## Technologies Used

- **Flutter**: For cross-platform mobile app development (iOS and Android).
- **Dart**: Primary programming language.
- **Firebase**: Used for backend services including authentication, Firestore database, storage, and real-time messaging.
- **AWS EC2**: For hosting the backend services and application deployment.
- **Nginx**: Used for serving the web components of the application.

## System Architecture

The application follows a **3-tier architecture**:
1. **Frontend**: The mobile client built with Flutter.
2. **Backend**: Firebase for real-time database, authentication, and storage.
3. **Cloud Hosting**: AWS EC2 for scalable infrastructure and hosting.

## Setup Instructions

### Prerequisites
- Flutter SDK installed.
- Firebase project setup.
- AWS EC2 instance.

### Steps
1. Clone the repository:
    ```bash
    git clone https://github.com/your-repo/al-baladiya.git
    cd al-baladiya
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Configure Firebase by adding your `google-services.json` file for Android and `GoogleService-Info.plist` for iOS in the appropriate directories.

4. Build and run the project:
    ```bash
    flutter run
    ```

### Deployment on AWS EC2
1. Launch an EC2 instance using Ubuntu.
2. Install **Nginx** and configure it to serve the web version of the app:
    ```bash
    sudo apt update
    sudo apt install nginx
    ```
3. Build the web version of the app:
    ```bash
    flutter build web
    ```
4. Deploy the build files on the EC2 instance:
    ```bash
    sudo cp -r build/web/* /var/www/html/
    sudo systemctl restart nginx
    ```

## Project Timeline
- **Start Date**: February 1, 2024
- **Completion Date**: May 31, 2024
- **Presentation Date**: June 11, 2024

## Contributor
- **Ahmed HABAIB**

## License
This project is licensed under the MIT License.

## Documentation
For more details, please refer to the **[Project Report](https://raw.githubusercontent.com/Ahmedhabaib/Setting-up-a-security-system/a7b254fac92aa9014936991c06e4a02143b3c5ac/Mise%20en%20place%20d%E2%80%99un%20syst%C3%A9me%20de%20s%C3%A9curit%C3%A9.pdf)**.

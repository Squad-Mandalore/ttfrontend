# TTFrontend

Hello and welcome everynyan to our time management application for Android. (Even though it is in Flutter we are to poor for an IOS developer account)

## Getting Started

This repository serves as the initial setup for a Flutter application. If this is your first time using Flutter, consider exploring the following resources to get up to speed:

- [Flutter Getting Started Guide](https://docs.flutter.dev/get-started/test-drive) - Step-by-step instructions to test drive Flutter.
- [Flutter Online Documentation](https://docs.flutter.dev/) - Comprehensive guides, samples, and a full API reference for mobile development.

## Setup Instructions

### Setting up on Arch Linux

#### Install Required Packages

Install the necessary packages from the official Arch repositories:

```
dart gradle clang cmake ninja pkgconf libbsd
```

Also, install the following from the Arch User Repository (AUR):

```
flutter google-chrome android-sdk android-sdk-build-tools android-platform android-sdk-platform-tools android-sdk-cmdline-tools-latest android-emulator
```

#### Environment Configuration

For Chrome support, add the following variable to your environment:

```
export CHROME_EXECUTABLE="$(which google-chrome-stable)"
```

#### Permissions Setup

Create a new user group with write permissions:

```
groupadd android-sdk
gpasswd -a <user> android-sdk
setfacl -R -m g:android-sdk:rwx /opt/android-sdk
setfacl -d -m g:android-sdk:rwX /opt/android-sdk
newgrp android-sdk
```

Alternatively, set the Android directory to have '777' permissions with:

```
chmod -R 777 /opt/android
```

#### License Agreement

Accept all Android licenses:

```
yes | flutter doctor --android-licenses
```

#### SDK Management

To install a system image using sdkmanager:

```
sdkmanager --list
sdkmanager --install "system-images;android-35;google_apis;x86_64"
sdkmanager --list_installed
```

To create an Android Virtual Device (AVD) using avdmanager:

```
avdmanager create avd -n myavd -k "system-images;android-35;google_apis;x86_64"
avdmanager list avd
```

#### Start the Emulator

To start the emulator:

```
emulator -avd myavd
```

Or, to start without loading snapshots:

```
emulator @myavd -no-snapshot-load
```

If the emulator cannot find the `avd.ini` file, set the `ANDROID_AVD_HOME` variable:

```
export ANDROID_AVD_HOME="/path/to/.android/avd"
```

### Setup on Other Distributions and Operating Systems

For non-Arch Linux users, please refer to the [Flutter online documentation](https://docs.flutter.dev/) for setup instructions tailored to your operating system.

## Running the Application

To run your Flutter application, select your build device and execute:

```
flutter run
```

## Monitor the application
After running the application a custom link to the flutter DevTools is provided.
If followed you can for example access the logs of the application.

### Logging
Please log with the log_service methods. Those are automatically displayed in the DevTools.

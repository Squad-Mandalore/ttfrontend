# ttfrontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Get Started](https://docs.flutter.dev/get-started/test-drive)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## how to setup

On Archlinux you have to install:
```
dart
google-chrome
gradle
android-platform
android-sdk
android-sdk-build-tools
android-sdk-cmdline-tools-latest
android-sdk-platform-tools
clang
cmake
ninja
pkg-config
```

for chrome you have to add the variable to your environment:
```
export CHROME_EXECUTABLE="$(which google-chrome-stable)"
```

you have to set the android directory to 777 rights, for example with:
```
chmod -R 777 /opt/android
```

to accept all licenses from android with (otherwise they wont get applied):
```
yes | flutter doctor --android-licenses
```

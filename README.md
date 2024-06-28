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
android-emulator
libbsd
```

for chrome you have to add the variable to your environment:
```
export CHROME_EXECUTABLE="$(which google-chrome-stable)"
```

you have to set the android directory to 777 rights, for example with:
```
chmod -R 777 /opt/android
```
or create a new usergroup with write rights:
```
groupadd android-sdk
gpasswd -a <user> android-sdk

setfacl -R -m g:android-sdk:rwx /opt/android-sdk
setfacl -d -m g:android-sdk:rwX /opt/android-sdk

newgrp android-sdk
```

to accept all licenses from android with (otherwise they wont get applied):
```
yes | flutter doctor --android-licenses
```

to install a systemimage you can use sdkmanager
```
sdkmanager --list
sdkmanager --install "system-images;android-35;google_apis;x86_64"
sdkmanager --list_installed
```

to create an avd you can use avdmanager
```
avdmanager create avd -n myavd -k "system-images;android-35;google_apis;x86_64"
avdmanager list avd
```

finally to start the emulator
```
cd /opt/android-sdk/tools/
emulator -avd myavd
```

if it cant find the avd.ini file set the ANDROID_AVD_HOME variable
```
export ANDROID_AVD_HOME="path/to/.android/avd"
```

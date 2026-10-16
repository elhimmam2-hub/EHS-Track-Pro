name: Build Android APK Release
on:
  push:
    branches: [ "main", "master" ]
  pull_request:
    branches: [ "main", "master" ]
  workflow_dispatch: # Allows 1-click manual trigger from GitHub UI
jobs:
  build:
    name: Build EHS Track Pro APK
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4
      - name: Set up Java Development Kit (JDK 17)
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '17'
      - name: Setup Android SDK
        uses: android-actions/setup-android@v3
      - name: Change Directory to Android Project & Grant execute permission
        run: |
          cd ehs_android_app
          chmod +x gradlew || true
      - name: Build Android Release APK
        run: |
          cd ehs_android_app
          gradle wrapper
          ./gradlew assembleRelease --stacktrace
      - name: Upload Release APK Artifact
        uses: actions/upload-artifact@v4
        with:
          name: EHS-Track-Pro-Release-APK

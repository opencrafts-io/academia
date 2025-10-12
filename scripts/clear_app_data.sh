#!/bin/bash

# Script to clear app data for Academia Flutter app
# This forces the database to be recreated with the latest schema

APP_PACKAGE="io.opencrafts.academia"

echo "Clearing app data for Academia app..."

# Check if adb is available
if ! command -v adb &> /dev/null; then
    echo "Error: adb command not found. Make sure Android SDK is installed."
    exit 1
fi

# Check if any device/emulator is connected
DEVICES=$(adb devices | grep -v "List of devices" | grep "device$" | wc -l)
if [ $DEVICES -eq 0 ]; then
    echo "Error: No Android device or emulator connected."
    echo "Please connect a device or start an emulator first."
    exit 1
fi

# Stop the app if running
echo "Stopping app..."
adb shell am force-stop $APP_PACKAGE

# Clear app data
echo "Clearing app data..."
adb shell pm clear $APP_PACKAGE

if [ $? -eq 0 ]; then
    echo "App data cleared successfully!"
    echo "The next time you launch the app, the database will be created with the latest schema."
else
    echo "Failed to clear app data. Make sure the app is installed."
    exit 1
fi

echo "Done!"
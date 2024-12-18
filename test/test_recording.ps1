# Set the test directory path
$testDirectory = "D:\College\Semester 9\1-Mobile Programming\Project\test"
$recordingFileName = "screen_recording.mp4"
$recordingPath = "/sdcard/$recordingFileName"

# Start the screen recording in the background
Start-Process adb -ArgumentList "shell", "screenrecord --time-limit 60 $recordingPath"

# Run the Flutter tests
cd $testDirectory
$flutterProcess = Start-Process flutter -ArgumentList "run", "test/login_page_test.dart" -PassThru

# Wait for 30 seconds
Start-Sleep -Seconds 15

# Forcefully kill the Flutter process after 30 seconds
if (!$flutterProcess.HasExited) {
    $flutterProcess.Kill()
}

# Wait for screen recording to finish and then pull the recording
Start-Sleep -Seconds 70
adb pull $recordingPath $testDirectory

# Clean up the recording from the device
adb shell "rm $recordingPath"

Write-Host "Test and recording complete."

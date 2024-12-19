# Set the integration_test directory path
$testDirectory = "D:\College\Semester 9\1-Mobile Programming\Project\integration_test"
$projectDirectory = "D:\College\Semester 9\1-Mobile Programming\Project\"
$recordingFileName = "screen_recording.mp4"
$recordingPath = "/sdcard/$recordingFileName"

Set-Location -Path $projectDirectory
# Start the screen recording in the background (time-limited to 60 seconds)
Start-Process adb -ArgumentList "shell", "screenrecord --time-limit 100 $recordingPath" -NoNewWindow

# Start the Flutter test process
$flutterProcess = Start-Process flutter -ArgumentList "test", "integration_test" -PassThru -NoNewWindow

# Wait for the Flutter test to run (time limit of 60 seconds for screen recording)
Start-Sleep -Seconds 100

# Kill the Flutter process if it's still running
if (!$flutterProcess.HasExited) {
    $flutterProcess.Kill()
}

# Wait for the screen recording to finish (optional buffer time for adb)
Start-Sleep -Seconds 10

# Pull the recording file from the device
try {
    adb pull $recordingPath $testDirectory
    Write-Host "Screen recording pulled to $testDirectory."
} catch {
    Write-Host "Failed to pull the screen recording."
}

# Clean up the recording from the device
try {
    adb shell "rm $recordingPath"
    Write-Host "Screen recording removed from the device."
} catch {
    Write-Host "Failed to remove the recording from the device."
}

Write-Host "Test and recording process complete."

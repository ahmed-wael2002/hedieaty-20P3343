# Set paths and filenames
$testDirectory = "D:\College\Semester 9\1-Mobile Programming\Project\integration_test"
$projectDirectory = "D:\College\Semester 9\1-Mobile Programming\Project\"
$recordingFileName = "screen_recording.mp4"
$recordingPath = "/sdcard/$recordingFileName"
$recordingLocalPath = "$testDirectory\$recordingFileName"
$htmlFile = "$testDirectory\TestResults.html"
$flutterLogFile = "$testDirectory\flutter_output.log"

# Set the project directory
Set-Location -Path $projectDirectory

# Start the screen recording in the background (time-limited to 100 seconds)
Start-Process adb -ArgumentList "shell", "screenrecord --time-limit 100 $recordingPath" -NoNewWindow

# Start the Flutter test process and log output to a file
$flutterProcess = Start-Process flutter -ArgumentList "test", "integration_test" -RedirectStandardOutput $flutterLogFile -PassThru -NoNewWindow

# Wait for the Flutter test to run (time limit of 100 seconds for screen recording)
Start-Sleep -Seconds 100

# Kill the Flutter process if it's still running
if (!$flutterProcess.HasExited) {
    $flutterProcess.Kill()
}

# Wait for the screen recording to finish (optional buffer time for adb)
Start-Sleep -Seconds 10

# Pull the recording file from the device
try {
    adb pull $recordingPath $recordingLocalPath
    Write-Host "Screen recording pulled to $recordingLocalPath."
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

# Determine the test status
$testOutput = Get-Content $flutterLogFile -Raw
if ($testOutput -match "All tests passed!") {
    $testStatus = "Passed"
} elseif ($testOutput -match "Some tests failed!") {
    $testStatus = "Failed"
} else {
    $testStatus = "Unknown"
}

# Generate the HTML report
$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Results</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Integration Test Results</h1>
    <table>
        <thead>
            <tr>
                <th>Test Path</th>
                <th>Status</th>
                <th>Recording Path</th>
                <th>Environment Variables used</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>$projectDirectory</td>
                <td>$testStatus</td>
                <td>$recordingLocalPath</td>
                <td>None</td>
            </tr>
        </tbody>
    </table>
</body>
</html>
"@

# Save the HTML content to a file
Set-Content -Path $htmlFile -Value $htmlContent

Write-Host "Test and recording complete. Results saved to $htmlFile"

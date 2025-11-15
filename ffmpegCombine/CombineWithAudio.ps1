param(
    [Parameter(Mandatory = $false)]
    [string]$VideoPath
)

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

if (-not $VideoPath) {
    [System.Windows.MessageBox]::Show(
        "No video file was passed to the script.",
        "Error",
        [System.Windows.MessageBoxButton]::OK,
        [System.Windows.MessageBoxImage]::Error
    )

    exit 1
}

# --- Pick audio file ---
$audioDialog = New-Object System.Windows.Forms.OpenFileDialog
$audioDialog.Title = "Select an audio file to combine with: `n$VideoPath"
$audioDialog.Filter = "Audio Files (*.mp3;*.m4a;*.aac;*.wav;*.flac;*.mp4)|*.mp3;*.m4a;*.aac;*.wav;*.flac;*.mp4|All Files (*.*)|*.*"
$audioDialog.Multiselect = $false

if ($audioDialog.ShowDialog() -ne "OK") {
    exit 1
}

$AudioPath = $audioDialog.FileName

# --- Save As dialog ---
$saveDialog = New-Object System.Windows.Forms.SaveFileDialog
$saveDialog.Title = "Save combined file as:"
$saveDialog.Filter = "MP4 Video (*.mp4)|*.mp4"
$saveDialog.FileName = [System.IO.Path]::GetFileNameWithoutExtension($VideoPath) + "_combined.mp4"

if ($saveDialog.ShowDialog() -ne "OK") {
    exit 1
}

$OutPath = $saveDialog.FileName

# --- Run ffmpeg ---
$ffmpegCmd = "ffmpeg -y -i `"$VideoPath`" -i `"$AudioPath`" -c:v copy -c:a copy `"$OutPath`""

Start-Process -NoNewWindow -Wait -FilePath "cmd.exe" -ArgumentList "/c $ffmpegCmd"

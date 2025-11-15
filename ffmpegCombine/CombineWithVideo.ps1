param(
    [Parameter(Mandatory = $false)]
    [string]$AudioPath
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework

if (-not $AudioPath) {
    [System.Windows.MessageBox]::Show(
        "No audio file was passed to the script.",
        "Error",
        [System.Windows.MessageBoxButton]::OK,
        [System.Windows.MessageBoxImage]::Error
    )

    exit 1
}

# --- Pick video file ---
$videoDialog = New-Object System.Windows.Forms.OpenFileDialog
$videoDialog.Title = "Select a video file to combine with: `n$AudioPath"
$videoDialog.Filter = "Supported Video (*.mp4;*.mkv;*.mov;*.m4v)|*.mp4;*.mkv;*.mov;*.m4v|All Files (*.*)|*.*"
$videoDialog.Multiselect = $false

if ($videoDialog.ShowDialog() -ne "OK") {
    exit 1
}

$VideoPath = $videoDialog.FileName

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

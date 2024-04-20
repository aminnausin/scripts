$path = $args[0]

Add-Type -AssemblyName 'System.Windows.Forms'

$dialog = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
    RootFolder            = "MyComputer"
    Description           = "Select symbolic link origin"
}
if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $directory = $dialog.SelectedPath

    if([string]::IsNullOrEmpty($directory)){
        Write-Host "Cancelled"
    }
    else{
        Write-Host "Directory selected is $directory"
        $folder = Split-Path $directory -Leaf

        # Write-Host "New-Item -Path `"$path\$folder`" -ItemType SymbolicLink -Value `"$directory`""
        Write-Host "cmd /c mklink /d `"$path\$folder`" `"$directory`""

        Start-Process -Verb RunAs cmd.exe -Args '/c', "cmd /c mklink /d `"$path\$folder`" `"$directory`""
    }

    $dialog.Dispose()   
}
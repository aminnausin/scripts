Set shell = CreateObject("WScript.Shell")
shell.Run "powershell.exe -ExecutionPolicy Bypass -NoLogo -NoProfile -STA -File ""C:\scripts\ffmpegCombine\CombineWithAudio.ps1"" """ & WScript.Arguments(0) & """", 0, False

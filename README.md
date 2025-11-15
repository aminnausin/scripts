# scripts

## CreateSymLink

- Right click in any folder to create a symbolic link to another location.
- Select the original location with the provided folder picker.
- The new link will be created as a folder with the same name.

## ffmpegCombine

> [!NOTE]  
> Requires ffmpeg.exe on system path

- Right click a video file to combine it with any audio file (option 1)
- Right click an audio file to combine it with any video file (option 2)
- A new video file will be created with a specified name or `${video_name}_combined.mp4`

## Installation

- Put in C:\scripts\\[scriptFolder]
  - C:\scripts\CreateSymLink\
  - C:\scripts\ffmpegCombine\
- Run the `.reg` file if it exists to add the scripts to your context menu

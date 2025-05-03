@echo off
echo Made by @zeds1175 (Dalk/TWCDalk/dalked). By using this script, you are abiding by the terms of the AGPL license attached to this toolkit.
set /p song_name=Enter the song filename (ex. Really Cool Wig.mp3): 
set /p duration=Enter duration in seconds (optional, default is 65): 

if "%duration%"=="" set duration=65

set "input_wav=%song_name%"
for %%F in ("%song_name%") do set "clean_name=%%~nF"
set "output_ts=OUT_LOT8_%clean_name%.ts"
set "input_video=output_file.ts"
set "input_image=LOT8_HD.png"
set "logo_wav=LOT8_SonicLogo.wav"
set "combined_wav=combined_audio.wav"

ffmpeg -y -i "%logo_wav%" -i "%input_wav%" -filter_complex "[0:0][1:0]concat=n=2:v=0:a=1[outa]" -map "[outa]" "%combined_wav%"

ffmpeg -y -i "%input_video%" -i "%combined_wav%" -i "%input_image%" -map 0:v -map 1:a -c:v mpeg2video -c:a ac3 -ac 6 -b:a 448k -filter_complex "[0:v]loop=loop=-1:size=1:start=0[v];[v][2:v]overlay=0:0" -t %duration% -f mpegts -pix_fmt yuv420p "%output_ts%"

del "%combined_wav%" >nul 2>&1

echo Process completed!
pause

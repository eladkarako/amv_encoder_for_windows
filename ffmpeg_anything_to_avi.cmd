::@echo off
chcp 65001 1>nul 2>nul
set "EXIT_CODE=0"

set "EXE__FFPROBE=.\ffprobe.exe"
set "EXE__FFMPEG=..\ffmpeg.exe"
pushd "%~dp1"

set "FILE_INPUT=%~f1"
set "FILE_OUTPUT=%~dpn1.avi"


set "PROBED_VCODEC="
set "PROBED_ACODEC="
for /f "tokens=*" %%a in ('call "%EXE__FFPROBE%" -hide_banner -loglevel error -strict experimental -i "%FILE_INPUT%" -select_streams "v:0" -show_entries "stream=codec_name" -print_format "default=noprint_wrappers=1:nokey=1"') do (set PROBED_VCODEC=%%a)
for /f "tokens=*" %%a in ('call "%EXE__FFPROBE%" -hide_banner -loglevel error -strict experimental -i "%FILE_INPUT%" -select_streams "a:0" -show_entries "stream=codec_name" -print_format "default=noprint_wrappers=1:nokey=1"') do (set PROBED_ACODEC=%%a)

set "ARGS="

set  ARGS=%ARGS% -y
set  ARGS=%ARGS% -hide_banner
set  ARGS=%ARGS% -threads auto
set  ARGS=%ARGS% -strict "experimental"

set  ARGS=%ARGS% -err_detect ignore_err
set  ARGS=%ARGS% -flags "-output_corrupt"
set  ARGS=%ARGS% -fflags "+discardcorrupt+autobsf"
set  ARGS=%ARGS% -flags2 "+ignorecrop"
set  ARGS=%ARGS% -i "%FILE_INPUT%"
set  ARGS=%ARGS% -movflags "+faststart"

::set  ARGS=%ARGS% -preset veryslow
::set  ARGS=%ARGS% -crf 24
::set  ARGS=%ARGS% -profile:v baseline
::set  ARGS=%ARGS% -level "3.0"

::set  ARGS=%ARGS% -an
::set  ARGS=%ARGS% -ac 1
::set  ARGS=%ARGS% -ar 22050

set  ARGS=%ARGS% -qscale:v 2
::set  ARGS=%ARGS% -b:v 2M
::set  ARGS=%ARGS% -vcodec msmpeg4
::set  ARGS=%ARGS% -acodec wmav2



rem ::only codec_type=mpeg4 supports this
rem   if /i ["%PROBED_VCODEC%"] EQU ["mpeg4"] (
rem     set ARGS=%ARGS% -bsf:v                  "mpeg4_unpack_bframes,remove_extra=freq=all"
rem   )
rem   if /i ["%PROBED_VCODEC%"] EQU ["h264"]  (
rem     set ARGS=%ARGS% -bsf:v                  "h264_redundant_pps,remove_extra=freq=all"
rem   )
  
rem   if /i ["%PROBED_VCODEC%"] NEQ ["mpeg4"]  (
rem     if /i ["%PROBED_VCODEC%"] NEQ ["h264"]  (
rem       set ARGS=%ARGS% -bsf:v                "remove_extra=freq=all"
rem     )
rem   )

rem   if /i ["%PROBED_ACODEC%"] EQU ["mp3"] (
rem     set ARGS=%ARGS% -bsf:a                  "mp3decomp"
rem   ) 

::----------------------------------------------------- this is added if the TARGET is MP4 only (not related to this CMD file really.. since it only use AVI output with mp3 audio).
::  if /i ["%PROBED_ACODEC%"] EQU ["aac"] (
::    set ARGS=%ARGS% -bsf:a                  "aac_adtstoasc"
::  ) 

set ARGS=%ARGS% -bsf:v "mpeg4_unpack_bframes,remove_extra=freq=all"
set ARGS=%ARGS% -bsf:a "mp3decomp"

set ARGS=%ARGS% -start_at_zero
set ARGS=%ARGS% -avoid_negative_ts        "make_zero"

::set ARGS=%ARGS% -zerolatency              "1"
::set ARGS=%ARGS% -tune                     "zerolatency"

::set  ARGS=%ARGS% -r 24

set  ARGS=%ARGS% -vf "fifo
set  ARGS=%ARGS%,setpts=PTS-STARTPTS
set  ARGS=%ARGS%,yadif=0:-1:0
set  ARGS=%ARGS%,dejudder=cycle=20
set  ARGS=%ARGS%,mpdecimate
set  ARGS=%ARGS%,crop=trunc(in_w/2)*2:trunc(in_h/2)*2
set  ARGS=%ARGS%,scale=208:176
set  ARGS=%ARGS%,eq=gamma=1.2:saturation=1.1
set  ARGS=%ARGS%,hqdn3d"

set  ARGS=%ARGS% -pix_fmt yuv420p
::set  ARGS=%ARGS% -to "00:00:10.000"

::-------------------------------------------------- pre-scale and smooth using new FFMPEG.
call "%EXE__FFMPEG%" %ARGS% "%FILE_OUTPUT%"
set "EXIT_CODE=%ErrorLevel%"

if ["%EXIT_CODE%"] NEQ ["0"] ( 
  goto ERROR_FFMPEG
) 


goto END


::---------------------------------------------------------------------------------
:ERROR_FFMPEG
  echo [ERROR] there was an error using FFMPEG.
  goto END


:END
  echo [INFO] EXIT_CODE:%EXIT_CODE%.
  pause
  popd
  exit /b %EXIT_CODE%

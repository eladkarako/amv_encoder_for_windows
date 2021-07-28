# amv_encoder_for_windows
a hard to find (AND WORKING!) solution to encoding anything to AMV (for some "MP4" players). uses new FFMPEG to pre-scale to 208x176 and encode to AVI which is than can be used as an input for "AMV Converter" (manually by you..). no installation. unzip and use (might be need to edit scripts for actual locations). license public domain just for my script - for ffmpeg and "amv converter" - it IS NOT!

  
download the repository using the following link: 
<a href="https://github.com/eladkarako/amv_encoder_for_windows/archive/refs/heads/master.zip">https://github.com/eladkarako/amv_encoder_for_windows/archive/refs/heads/master.zip</a>  

pre-set (do it once)
download a 'k-lite' codec pack named "mega" from <a href="https://codecguide.com/download_k-lite_codec_pack_mega.htm">https://codecguide.com/download_k-lite_codec_pack_mega.htm</a>, install it, if have to choose in the installation, choose the complete installation and the ffdshow whenever possible.

all the programs are compressed with 7zip (7z-zstd) which is provided to you here as well,  
it is compressed with zip, which is supported on most windows without an additional software. 
unzip notepad2 to the same folder, open the cmd file using notepad2 and make sure the end-of-line character is set to windows-eol (file, line endings, windows), save the cmd and quite notepad2. 
uncompress ffmpeg, ffplay, and ffprobe to the same folder. 
move your video files to the same folder, drag-and-drop one file over the "ffmpeg_anything_to_avi.cmd", it will take some time but eventually it will create a file with the same name and extension AVI in the same folder.  
uncompress amv-converter anywhere, you can use the same folder.  

right click the exe and choose properties, select compatibility and choose windows xp sp3, click ok, 
and run the main exe "amvtransform.exe" and click the first "input" path and choose your recently generated AVI video, 
choose a target path, and click the button with to arrows to start processing, keep the program in focus which is encodes, do not switch to other programs. when it will finish, it will open the video file (you can close the video file, and the program itself), re-open the program for the next video file convertion. do not add more than one file at a time.

you will end up with the following video file with two streams in your target location:
<pre>
Video: AMVV 208x176 10fps [V: amv, yuvj420p, 208x176]
Audio: ADPCM 22050Hz mono 352kbps [A: adpcm_ima_amv, 22050 Hz, 1 channels, s16, 352 kb/s]
</pre>

<hr/>
note: I have tried the ffmpeg fork that has AMV support in it but it didn't worked for me.
see: https://code.google.com/archive/p/amv-codec-tools/downloads  

and other versions from  
https://web.archive.org/web/20170222144209/http://mympxplayer.org/mp3-player-utilities-dc44.html  
had issues open up from the installation. 

<hr/>
this packages have no installation at all.
<hr/>
note: everything seems fine on my PC, but everything your do with those is your own resposibility, keep an updated anti-virus on your machine, 
or even better install a virtual-machine (virtualbox or vmware workstation) and run everything on that.

<hr/>
it seems that everything higher than 10fps can't work well so don't expect very high result.
if you do have a modified version of ANYTHING that generates a better result, it will be appreciated if you'll contact me somehow :]

<hr>
https://trac.ffmpeg.org/wiki/Encode/MPEG-4  
https://walterebert.com/blog/creating-wmv-videos-with-ffmpeg/  
https://web.archive.org/web/20120506090436/http://wiki.s1mp3.org/VirtualDub_corrections  
https://github.com/mcmilk/7-Zip-zstd/releases  


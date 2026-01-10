# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- #
# STEP 3 Script used for adding intro, FadeIn on video, and concatenating everything  #
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- #

import glob
from pathlib import Path

import moviepy.video.fx.FadeOut
from moviepy import *
from moviepy.video.fx import CrossFadeIn

# Collect clips
clips = glob.glob('OutputStep1/*.mp4')
intropath = glob.glob('IntroOutro/IntroFinal.mp4')[0]

watermarkpath = glob.glob('IntroOutro/Use this one with posiition 1590 989.png')[0]
intro_base = VideoFileClip(intropath, target_resolution = (1980, 1080))





# Initialize list to store the clips
clips_used = []

increment = 0

for clip_path in clips:

    clip_name = Path(clip_path).stem[:-6]

    outropath = glob.glob(f'OutputStep2/{clip_name}_Step2.mp4')[0]
    outro = VideoFileClip(outropath, target_resolution=(1980, 1080))

    #Reset variable
    clips_used = []
    increment += 1

    #Video with FadeIn()
    video_clip = VideoFileClip(clip_path, target_resolution = (1980, 1080))
    video_clip_with_fadein = moviepy.video.fx.FadeIn(1).copy().apply(video_clip)

    intro = intro_base.copy()
    #Add processed clips to the list
    clips_used.append(intro_base)
    clips_used.append(video_clip_with_fadein)
    clips_used.append(outro)



    #Concatenate all processed clips
    final_video = concatenate_videoclips(clips_used)
    final_video.write_videofile(f"OutputStep3/{clip_name}_Step3.mp4", fps = 60 )

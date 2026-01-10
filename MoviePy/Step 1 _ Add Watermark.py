#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-#
# STEP 1 Script used for adding watermark onto every video  #
#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-#

import glob
import os

from moviepy import *
from pathlib import Path

# Collect clips
clips = glob.glob('SourceVideos/*.mp4')
watermarkpath = glob.glob('IntroOutro/Use this one with posiition 1590 989.png')[0]
overlay_watermark = ImageClip(watermarkpath)  #Watermark

# Initialize list to store the clips
clips_used = []
increment = 0


for clip_path in clips:

    # Create Directories based on clip name. Every video from each step will go in each directory.
    clip_name = Path(clip_path).stem

    os.mkdir(f"OutputsFromSteps/{clip_name}")


    #Reset variable

    increment += 1

    print(clip_name)
    #Create a VideoFileClip object and resized them
    video_clip = VideoFileClip(clip_path, target_resolution = (1980, 1080))
    overlay_watermark = overlay_watermark.with_duration(video_clip.duration).with_opacity(0.3).with_position((1640, 989))

    video_with_watermark = CompositeVideoClip([video_clip, overlay_watermark])

    video_with_watermark.write_videofile(f"OutputsFromSteps/{clip_name}/{clip_name}_Step1.mp4", fps = 60 )







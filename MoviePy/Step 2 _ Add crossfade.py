# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- #
# STEP 2 Script used for adding crossfade on last frame of video and outro  #
# -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- #

import glob

from moviepy import *
from pathlib import Path

from moviepy import VideoFileClip, ImageClip, CompositeVideoClip
from moviepy.video.fx.CrossFadeIn import CrossFadeIn

# Collect clips
clips = glob.glob('OutputStep1/*.mp4')
outro_base = VideoFileClip("IntroOutro/OutroFrame5s.mp4", target_resolution = (1980, 1080))

# Initialize list to store the clips
clips_used = []
increment = 0

for clip_path in clips:

    #Reset variable

    increment += 1
    clip_name = Path(clip_path).stem[:-6]
    print(clip_name)
    #Create a VideoFileClip object and resized them
    video_clip = VideoFileClip(clip_path, target_resolution = (1980, 1080))

    freeze_duration = 1.3
    crossfade_duration = 0.8

    # 1. Extract ONLY the last frame of video_clip
    last_frame = video_clip.get_frame(video_clip.duration - 1 / video_clip.fps)

    # 2. Create frozen frame clip
    freeze_clip = (
        ImageClip(last_frame)
        .with_duration(freeze_duration)
        .with_fps(video_clip.fps)
    )

    # 3. Apply crossfade-in to clip2
    outro_crossfade = outro_base.with_effects([CrossFadeIn(crossfade_duration)])

    # 4. Timeline placement
    outro_cf_withstart = outro_crossfade.with_start(freeze_duration - crossfade_duration)

    # 5. Composite
    final = CompositeVideoClip([freeze_clip, outro_cf_withstart])

    # Export
    final.write_videofile(f"OutputStep2/{clip_name}_Step2.mp4", fps = 60 )

    final.close()
    video_clip.close()
    freeze_clip.close()

outro_base.close()
# clip_name = Path("OutputStep1/*.mp4").stem[:-6]
# print(clip_name)




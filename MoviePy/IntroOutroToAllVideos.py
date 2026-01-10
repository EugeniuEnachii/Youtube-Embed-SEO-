import glob

import moviepy.video.fx.FadeOut
from moviepy import *
from moviepy.video.fx import CrossFadeIn

# Collect clips
clips = glob.glob('Clips/*.mp4')
intropath = glob.glob('IntroOutro/IntroFinal.mp4')[0]
outropath = glob.glob('IntroOutro/OutroFrame5s.mp4')[0]
watermarkpath = glob.glob('IntroOutro/WatermarkPlacideTV.png')[0]
intro = VideoFileClip(intropath, target_resolution = (1980, 1080))
outro = VideoFileClip(outropath, target_resolution = (1980, 1080))
overlay_watermark = ImageClip(watermarkpath)  #Watermark



crossfade_duration = 0.8

# Initialize list to store the clips
clips_used = []

increment = 0

for clip_path in clips:

    #Reset variable
    clips_used = []
    increment += 1

    #Create a VideoFileClip object and resized them
    video_clip = VideoFileClip(clip_path, target_resolution = (1980, 1080))
    overlay_watermark = overlay_watermark.with_duration(video_clip.duration).with_opacity(0.2)

    video_with_watermark = CompositeVideoClip([video_clip, overlay_watermark])
    video_clip_with_fadein = moviepy.video.fx.FadeIn(1).copy().apply(video_with_watermark)
    video_with_fadein_endfreeze = moviepy.video.fx.Freeze(t='end',freeze_duration=2 , padding_end=0.1).copy().apply(video_clip_with_fadein)




    # Crossfade
    outro = outro.with_effects([CrossFadeIn(crossfade_duration)])
    outro = outro.with_start(video_with_fadein_endfreeze.duration - crossfade_duration)
    final = CompositeVideoClip([video_with_fadein_endfreeze, outro])


    #Add processed clips to the list
    clips_used.append(intro)
    #clips_used.append(video_with_fadein_endfreeze)
    #clips_used.append(outro)
    clips_used.append(final)


    #Concatenate all processed clips
    final_video = concatenate_videoclips(clips_used)
    final_video.write_videofile(f"output/Video{increment}.mp4", fps = 60)

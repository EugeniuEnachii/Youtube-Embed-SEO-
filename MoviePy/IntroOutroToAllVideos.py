import glob
from moviepy import VideoFileClip, concatenate_videoclips

# Collect clips
clips = glob.glob('Clips/*.mp4')
intropath = glob.glob('IntroOutro/IntroTemp.mp4')[0]
outropath = glob.glob('IntroOutro/OutroTemp.mp4')[0]
intro = VideoFileClip(intropath, target_resolution = (1980, 1080))
outro = VideoFileClip(outropath, target_resolution = (1980, 1080))



# Initialize list to store the clips
clips_used = []

increment = 0

for clip_path in clips:

    #Reset variable
    clips_used = []
    increment += 1

    #Create a VideoFileClip object and resized them
    video_clip = VideoFileClip(clip_path, target_resolution = (1980, 1080))

    #Add processed clips to the list
    clips_used.append(intro)
    clips_used.append(video_clip)
    clips_used.append(outro)


    #Concatenate all processed clips
    final_video = concatenate_videoclips(clips_used)
    final_video.write_videofile(f"output/Video{increment}.mp4", fps = 60)

import glob
from moviepy import VideoFileClip, concatenate_videoclips

# Collect clips
clips = glob.glob('Clips/*.mp4')

# Initialize list to store the clips
all_clips = []

for clip_path in clips:

    #Create a VideoFileClip object and resized them
    video_clip = VideoFileClip(clip_path, target_resolution = (1980, 1080))

    #Add processed clips to the list
    all_clips.append(video_clip)

#Concatenate all processed clips
final_video = concatenate_videoclips(all_clips)

final_video.write_videofile("output/Video.mp4", fps = 60)

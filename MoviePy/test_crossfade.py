from moviepy import VideoFileClip, ImageClip, CompositeVideoClip
from moviepy.video.fx.CrossFadeIn import CrossFadeIn

# Load clips
clip1 = VideoFileClip("IntroOutro/IntroFinal.mp4")
clip2 = VideoFileClip("IntroOutro/OutroFrame5s.mp4")

freeze_duration = 3.0
crossfade_duration = 1.5

# 1. Extract ONLY the last frame of clip1
last_frame = clip1.get_frame(clip1.duration - 1 / clip1.fps)

# 2. Create frozen frame clip
freeze_clip = (
    ImageClip(last_frame)
    .with_duration(freeze_duration)
    .with_fps(clip1.fps)
)

# 3. Apply crossfade-in to clip2
clip2 = clip2.with_effects([CrossFadeIn(crossfade_duration)])

# 4. Timeline placement
clip2 = clip2.with_start(freeze_duration - crossfade_duration)

# 5. Composite
final = CompositeVideoClip([freeze_clip, clip2])

# Export
final.write_videofile("output.mp4")
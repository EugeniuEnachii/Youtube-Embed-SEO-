import glob
import os
from pathlib import Path

from moviepy import VideoFileClip, ImageClip, CompositeVideoClip
from moviepy.video.fx.CrossFadeIn import CrossFadeIn

base_dir = "Outputs"
out_dir = "OutputStep2"
os.makedirs(out_dir, exist_ok=True)

# Load once as a "base" clip
outro_base = VideoFileClip("IntroOutro/OutroFrame5s.mp4", target_resolution=(1980, 1080))

output_dirs = sorted(
    d for d in glob.glob(os.path.join(base_dir, "*"))
    if os.path.isdir(d)
)

for output_dir in output_dirs:
    clips = sorted(glob.glob(os.path.join(output_dir, "*.mp4")))
    if not clips:
        continue

    for clip_path in clips:
        video_clip = VideoFileClip(clip_path, target_resolution=(1980, 1080))

        freeze_duration = 2.0
        crossfade_duration = 0.8

        # safer last-frame grab
        t = max(0, video_clip.duration - 1 / video_clip.fps)
        last_frame = video_clip.get_frame(t)

        freeze_clip = (
            ImageClip(last_frame)
            .with_duration(freeze_duration)
            .with_fps(video_clip.fps)
        )

        # make a fresh outro instance each time (don’t mutate the base)
        outro = (
            outro_base.copy()
            .fx(CrossFadeIn, crossfade_duration)
            .with_start(freeze_duration - crossfade_duration)
        )

        final = CompositeVideoClip([freeze_clip, outro])

        clip_name = Path(clip_path).stem  # no arbitrary slicing
        final.write_videofile(os.path.join(out_dir, f"{clip_name}_Step2.mp4"), fps=60)

        # close resources
        final.close()
        outro.close()
        freeze_clip.close()
        video_clip.close()

outro_base.close()

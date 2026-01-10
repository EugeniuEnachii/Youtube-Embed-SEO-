import glob
import numpy as np
from moviepy import *

FPS = 60
FREEZE_DUR = 1.0
XFADE = 1.0

def silence(duration, fps=44100, n_channels=2):
    def make_frame(t):
        if np.isscalar(t):
            return np.zeros((n_channels,)) if n_channels > 1 else 0.0
        t = np.array(t)
        return np.zeros((len(t), n_channels)) if n_channels > 1 else np.zeros((len(t),))
    return AudioClip(make_frame, duration=duration, fps=fps)

clips = glob.glob("Clips/*.mp4")
intropath = glob.glob("IntroOutro/IntroTemp.mp4")[0]
outropath = glob.glob("IntroOutro/OutroTemp.mp4")[0]

intro = VideoFileClip(intropath, target_resolution=(1980, 1080))
intro = vfx.FadeOut(1).copy().apply(intro)

outro = VideoFileClip(outropath, target_resolution=(1980, 1080))

increment = 0

for clip_path in clips:
    increment += 1

    video = VideoFileClip(clip_path, target_resolution=(1980, 1080))
    video = vfx.FadeIn(1).copy().apply(video)

    # Use a safe "last frame" time (avoid exact end)
    last_t = max(0, video.duration - 2 / FPS)

    # Split: main part + freeze frame (ImageClip)
    main = video.subclipped(0, last_t)
    freeze_frame = video.to_ImageClip(t=last_t).with_duration(FREEZE_DUR)

    # Audio: original audio + silence for freeze
    if video.audio is not None:
        afps = getattr(video.audio, "fps", None) or 44100
        sample = video.audio.get_frame(0)
        n_channels = 1 if np.isscalar(sample) else len(sample)
        freeze_audio = silence(FREEZE_DUR, fps=afps, n_channels=n_channels)
        audio = concatenate_audioclips([video.audio, freeze_audio])
        freeze_frame = freeze_frame.with_audio(freeze_audio)
        video_part = concatenate_videoclips([main, freeze_frame], method="chain").with_audio(audio)
    else:
        video_part = concatenate_videoclips([main, freeze_frame], method="chain")

    # Crossfade-in outro (still requires compose + overlap)
    outro_x = outro.with_effects([vfx.CrossFadeIn(XFADE)])

    final = concatenate_videoclips(
        [intro, video_part, outro_x],
        method="compose",
        padding=-XFADE
    )

    final.write_videofile(
        f"output/Video{increment}.mp4",
        fps=FPS,
        codec="h264_nvenc",
        audio_codec="aac",
        threads=16
    )

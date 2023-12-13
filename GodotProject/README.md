You need to copy audio and texture files into corresponding locations.

---

# Copying Textures

Copy all contents of `C:\Program Files (x86)\Armada Tanks\BaseT\Texture` into `Textures/Raw/`.

NEVER fix upper case extension, despite it looks weird.


---

# Converting & Copying Musics

Convert `game.it` and `menu.it` in `C:\Program Files (x86)\Armada Tanks\BaseT\Music` into *44100Hz* `*.ogg` files.
Move converted `game.ogg` and `menu.ogg` into `SoundSystem/Sounds/`.


## Method 1 - Audacity (Recommended)

Drag drop `*.it` file onto Audacity's empty area. Then, set *Project Speed* at left bottom corner to 44100Hz.

Then at `File > Export > Export OGG`.


## Method 2 - FFMpeg

If you prefer ffmpeg, use these 2 lines:

```
ffmpeg -i game.it -filter:a "volume=0.5" -b:a 256k -ar 44100 game.ogg
```

```
ffmpeg -i menu.it -filter:a "volume=1.5" -b:a 256k -ar 44100 menu.ogg
```

Otherwise ffmpeg will mess up volume, setting one way high and other way low.


---


# Copying & Converting Sounds

Copy all soundtracks in `C:\Program Files (x86)\Armada Tanks\BaseT\Sound` into `SoundSystem/Sounds/`.

HOWEVER, rename `A_shield.wav` into `A_shield.ogg`.
This file actually is `*.ogg` format but is using wrong extension.

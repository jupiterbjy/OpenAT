# Tex2JSON

Converts seemingly DX8 blending calls in *Armada Tanks*' Texture definition scripts.

This will convert all `texture*.json` files in `BaseT/Scripts/`.


## How this works

Basically there's 2 major blending modes currently used in-game (excluding unused dummy lines/models and no transparency)

One for black background JPEG:
```text
texture 18 "EFFECTS" {
  ColorOp_MODULATE
  Arg1_TEXTURE
  Arg2_CURRENT
  DestBlend_ONE
  SrcBlend_SRCCOLOR

  LoadFile "BaseT\\Texture\\Effects.jpg"
  Run
}
```

Another one for black background BMP(Only used once, another being dummy lines):

```text
texture 12 "TRACK" {
  ColorOp_MODULATE
  Arg1_TEXTURE
  Arg2_CURRENT
  DestBlend_INVSRCCOLOR
  SrcBlend_SRCCOLOR
  LoadFile "BaseT\\Texture\\Track.bmp"
  Run
}
```

And one for image with Alpha Channel, PNG:

```text
texture 13 "SCRPART" {
  ColorOp_MODULATE
  SrcBlend_SRCALPHA
  DestBlend_INVSRCALPHA
  LoadFile "BaseT\\Texture\\ScreenPart.png"
  Run
}
```


Upon long, long and very long search (Trust me, it's hard to find with near-zero-base) I found that this is some shorthands of Direct X calls.

- [Which blend state for me? (Eng)](https://wickedengine.net/2017/10/22/which-blend-state-for-me/) - from 2018
- [Blending & Alpha Blending (Kor)](https://xysterxx.tistory.com/50) - from 2012
- [DIRECTX Blending Option (Kor)](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=coolday11&logNo=60053915164) - from 2008 !

Last link (which was extremely supreme helpful) content is this:

| SRC Strength | DEST Strength | Layer Mix Mode Alias | Requires Alpha Src | Notes                                                                 |
|--------------|---------------|----------------------|--------------------|-----------------------------------------------------------------------|
| SRCALPHA     | INVSRCALPHA   | Normal               | O                  | Blended by Alpha value (Doesn't get brighter)                         |
| SRCCOLOR     | ONE           | Screen               | X                  | Adds bright values, become brighter (Black become transparent)        |
| ZERO         | SRCCOLOR      | Multiply             | X                  | Subtracts dark values, process like shadow (White become transparent) |
| ZERO         | DESTCOLOR     | -                    | X                  | Darken by square within object area (Texture has no Effects)          |
| INVDESTCOLOR | ZERO          | -                    | X                  | Invert and output                                                     |
| ONE          | ZERO          | Normal               | X                  | Opaque                                                                |


Thanks to these old posts written by wise ones, I think I now understand what's going on with those.

Here's one of incomplete PPT's slide explaining about my understanding on these calls: 

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/801829ec-e1e7-4aa8-ad51-cbb63925a73b)

With this in mind, what script does is simple. If a texture entry calls ColorOperation Modulate -
then script checks if this texture sets `SrcBlend_SRCALPHA` on source blending method, which indicates source has alpha channel.

If that's the case, will set `alpha=True` in dictionary. This will be used to set *Transparency* to *Alpha* in Godot Material. 
However, if texture sets `SrcBlend_SRCCOLOR` it's non-transparent that need to be, so we set `blend_add=True`.
This will be used to set *Blend Mode* to *Add* in Godot Material.

After this we export dictionary as json, simple! Godot-side scripts will use these as texture lookup table when generating material for each textures.

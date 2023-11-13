Collections of handcrafted models.


Despite simple looking, since I made each almost at 'typing each vertex coordinates' level, took way more time than it
looks like.

Order is inverse of creation time.


# lighting_bullet

For implementing Lightning weapon effect, because in 'modern' game engines we can't create mesh and edit UV in runtime!

Following is actual in-game implementation with this countless models, last 3 being extension and not modeled.

![](https://github.com/jupiterbjy/OpenAT/assets/26041217/9a7deb72-d8a8-4632-8f87-d160e8ea843e)


# tracks

Reconstructed models for use in godot. Material will be created with ADD blend mode on runtime, so black bg is fine.

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/016dea79-034b-400d-b3ea-e2b16598dd43)


# wall

Wall parts for each connection types.

This looks like a simple system without much attention, but actually is quite a bit of complex design.

As wall model doesn't exist in-game (presumably was easy enough to create with code?) - had to make one.

![](https://github.com/jupiterbjy/OpenAT/assets/26041217/2efe0329-8747-4a17-8934-87ae87ed880a)

![](https://github.com/jupiterbjy/OpenAT/assets/26041217/275bd3e8-8eb3-45c1-8e85-4e94be5ee9c2)

Actual wall connection system/model test vs original

![](https://github.com/jupiterbjy/OpenAT/assets/26041217/c179e185-5f89-4304-a7df-5d5455231e3c)


# terrain Version 2 (OpenAT)

Initial prototype for OpenAT before succeeding in decoding possibly in-house `*.dtm` model files.

Close enough from far, but not accurate close-up, despite hours went into it.

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/de90e952-0827-42e0-b824-7d7314944316)
![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/f18a77e6-f406-4638-afcd-98ad4983f17a)

# tank_sample

Originally made for [OpenArmada](https://youtu.be/y9SxrjWGQ5Y?si=N4GB5dVoKe6rwVIC).

Separated every individual parts to allow modularization.  

![](tank_sample/images/tank_parts.png)

After seeing Godot's built-in ***POWERFUL*** (Add 10x stronger emphasis here) outline mesh generation feature,
created a Simple headless Godot application wrapped with python called
[GLTFOutlineCreator](https://github.com/jupiterbjy/GLTFOutlineCreator).

With this tool, I ditched [old scale-based outline script](tank_sample/batch_export_w_invert_outline_mesh.py) and
created proper outline mesh for these as test.

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/171db34a-04d3-4103-87da-2607b28f27d7)

This made somewhat lame models much more badass, decided to use build logo upon this.

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/421c7a21-df64-454e-9a36-c62aaa01a2aa)


# terrain Version 1 (OpenArmada)

Even more ancient models that existed before this project for a concept project
[OpenArmada](https://youtu.be/y9SxrjWGQ5Y?si=N4GB5dVoKe6rwVIC).

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/02e23d20-7394-406e-8584-7167b868e8be)

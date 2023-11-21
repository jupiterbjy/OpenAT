![](/CustomResources/Images/logo/logo.png)

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/7c195f37-2fff-4a2f-86be-29d644a1d232)


# Introduction

An Open source Godot recreation project of Armada Tanks, a great arcade game by:

- Denis Kotov: Game Design, Programmer, Level design, Art & Graphics
- Pasha Oliynyk: Art & Graphics
- Yaroslav Yanovsky: Producer
- Message(??): Music Composition, Sound Design 

# Repo Structure

### [Decoded](Decoded)
Contains Markdown documents produced from our reverse-engineering efforts & few helper scripts.
Majority of project's efforts went into this decoding part.

### [ConversionScripts](ConversionScripts)
Resulting scripts of reverse-engineering efforts on *Armada Tanks*'s seemingly own in-house format.

- [ImageFontSplitter](ConversionScripts/ImageFontSplitter): Old script for splitting each letters from font image. No longer used.
- [DF2FNT](ConversionScripts/DF2FNT): `*.df` font format conversion script. Converts fonts into AngelCode's *BMFont* format.
- [DTM2Blender](ConversionScripts/DTM2Blender): DTM model reconstruction & model definition reconstruction script. Uses black magic trickery to allow Blender's GLTF exporter export mesh, UV and vertex animations properly.
- [Tex2JSON](ConversionScripts/Tex2JSON): `texture*.scr` texture definition scripts reconstruction script. Also translates DX8 Blending specifiers.  

### CustomResources
Collection of hand-crafted models.

- [CustomResources/Images](CustomResources/Images): Images made from scratch in paint.net or with blender. Refer README.md for details.
- [CustomResources/Models](CustomResources/Models): Models made from scratch in blender. Refer README.md for details.


# Why there's no game?

Currently, we couldn't solve the hard-dependency to Armada Tanks game resources, thus uploading godot project right now will violate the copyright.

We are planning to provide something similar to *OpenRCT2*'s approach, and indeed tested that it's possible.

But since that will make debugging and testing process much harder, we designed such runtime loader structures yet
still pointing it to in-project(aka `res://`) path.


```gdscript
## Actual usage of such loaders

    # setup model & check if null, if so return false
    _model = ModelLoader.load_name(model_name)
    
    ...
    
    # setup texture
    TextureLoader.set_mat(_model, tex_name, override)

    ...

    # setup collision
    _setup_collisions(CollisionLoader.get_area(model_name), collision_layer)
```


After game implementation is complete, we will start migrating hard dependency outside game so we can upload the project file.
Then dependencies can be supplied by users manually, albeit it might require users installing blender and running few scripts!


# Ramble: A Bit of history


## Version 0: Open Armada

Version 1 was made before OpenAT - Back then it was called *Open Armada*.
That project was made as a homework-ish Unity project for Computer Graphics lecture in Hong-Ik University.

- [A laugh-inducing-low-quality footage of Open Armada](https://youtu.be/y9SxrjWGQ5Y)

During that project, we failed to decode *Armada Tanks* for the entire full week.

Game - despite it's simplistic looks - was VERY complex in design,
that we couldn't find a single right thing about it back then.

Therefore, at least a working stuff resembling even tiny bit of it had to be done under about 72 remaining hours.
Those models used there were Just-In-Time(quite literally) model for use in impending doom called 'Deadline'.

Quality therefore, was quite miserable.

## Version 1: OpenAT

After failing our original Graduation project, we started working on Armada Tanks again, but from scratch.

We thought we could reuse all the thing we did in Unity, and pushed on researching about how we could utilize
*Armada Tanks* resources.

We surely can't simply read x86 ASM as this game seemingly uses DirectX 8.0 directly, however if we could utilize
original resources, our project could be run like one of my favourite *OpenRCT* - by just designating resource path.

Obviously this (and so many much more black magic *Armada Tanks* implements) was seemingly almost impossible in Unity.
So, we nailed down for using godot instead of unity. Not to mention unity's self-destruction with their TOS changes!

During a bit short of a month's hardship, project finally is starting to (at least) run.
Follow-up progress video will be linked here within 23, November.  

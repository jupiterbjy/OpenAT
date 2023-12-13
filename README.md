# OpenAT - Open source Reverse-Engineering project for Armada Tanks

A 50-days-long project made by *jupiterbjy* and *ruminex*, as part of *Hongik-University Graduation Project*.

![image](https://github.com/jupiterbjy/OpenAT/assets/26041217/cf9d34c0-dd60-46c7-b0e7-30aeac4288a5)

![1700538000_merged_4](https://github.com/jupiterbjy/OpenAT/assets/26041217/cee7b4c8-a0a0-4c72-8e7d-cac9e159cac2)

[Announcement-ish video](https://youtu.be/5v0qzULyCdM)

[Gameplay Demo](https://youtu.be/yI4WvkttvIA)

<br>

# Introduction

An Open source reverse-engineering project of Armada Tanks, a great arcade game by:

- Denis Kotov: Game Design, Programmer, Level design, Art & Graphics
- Pasha Oliynyk: Art & Graphics
- Yaroslav Yanovsky: Producer
- Message: Music Composition, Sound Design

With recent drama with Unity, to truely achive open-source nature, we've used *Godot 4.1.3*  Game engine for this project.

<br>

# Repo Structure

### [Decoded](Decoded)

&nbsp;&nbsp;Contains Markdown documents produced from our reverse-engineering efforts & few helper scripts.  
&nbsp;&nbsp;Majority of project's efforts went into this decoding part.

<br>

### [ConversionScripts](ConversionScripts)

&nbsp;&nbsp;Resulting scripts of reverse-engineering efforts on *Armada Tanks*'s seemingly own in-house format.

- [ImageFontSplitter](ConversionScripts/ImageFontSplitter): Old script for splitting each letters from font image. No longer used.
- [DF2FNT](ConversionScripts/DF2FNT): `*.df` font format conversion script. Converts fonts into AngelCode's *BMFont* format.
- [DTM2Blender](ConversionScripts/DTM2Blender): DTM model reconstruction & model definition reconstruction script. Uses black magic trickery to allow Blender's GLTF exporter export mesh, UV and vertex animations properly.
- [Tex2JSON](ConversionScripts/Tex2JSON): `texture*.scr` texture definition scripts reconstruction script. Also translates DX8 Blending specifiers.  

<br>

### CustomResources

&nbsp;&nbsp;Collection of hand-crafted models.

- [CustomResources/Images](CustomResources/Images): Images made from scratch in paint.net or with blender. Refer README.md for details.
- [CustomResources/Models](CustomResources/Models): Models made from scratch in blender. Refer README.md for details.


<br>

# Where's the game? How can I play?

### Test Builds

Considering that original game *Armada Tanks* is officially free -
I decided to distribute current build. But since this being open source repo, I can't simply put that as release here,
as it clearly contain ENKORD's textures or audios that can't be open sourced - so will be hosting it separately on
Google Drive.

By downloading [OpenAT Builds](https://drive.google.com/drive/folders/1BH4gQ538MWcWU4JmLSv4vDZ8O78YH99e?usp=drive_link),
*YOU ARE AGREEING TO ALSO [DOWNLOAD THE ORIGINAL GAME](https://www.enkord.com/game/armada-tanks/info/).*

Currently game is built for:
- Windows
- Linux/X11
- Android (Main game requires keyboard and mouse for now)

### Building yourself

Since this being open-source repository, all the game's source codes are open, however you'll need to follow few more
steps to fill in the missing files.

1. Download & install original *Armada Tanks* game from [Official site](https://www.enkord.com/game/armada-tanks/info/).
2. Follow [instruction](GodotProject/README.md).
3. Open `GodotProject/project.godot` in Godot Editor
4. Play or download build templates and build yourself!

<br>

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

<br>

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

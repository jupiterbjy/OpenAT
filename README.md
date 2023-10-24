# OpenAT

## Introduction

An Open source Godot recreation project of Armada Tanks, a great arcade game by:

- Denis Kotov: Game Design, Programmer, Level design, Art & Graphics
- Pasha Oliynyk: Art & Graphics
- Yaroslav Yanovsky: Producer
- Message(??): Music Composition, Sound Design 

Currently this is barren land because we couldn't solve the hard-dependency to Armada Tanks game resources, thus potentially violating the copyright. Everythign is in below-alpha state so far.

Until this graduation project is complete in somewhat safe way, we'll try to create all-in-one script to convert and move required dependencies to godot project resources, if possible. (Honestly not sure if it's possible at this moment)

## Repo Structure

### [ConversionScripts](ConversionScripts)
Resulting scripts of Reverse-Engineering attempts on *Armada Tanks*'s (seemingly) own format.

- [ImageFontSplitter](ConversionScripts/ImageFontSplitter): Initially used script for splitting each letters from font image, no longer needed.
- [DF2FNT](ConversionScripts/DF2FNT): Currently used script for converting `*.df` font format into AngelCode's BMFont format 
- [DTM2Blender](ConversionScripts/DTM2Blender): DTM model reconstruction script. Reconstructs vertex animations into `.mdd` format & few more trickery to allow GLTF exporter export it's mesh, UV and vertex animations. 
- [Tex2JSON](ConversionScripts/Tex2JSON): Convert `texture*.scr` scripts to `*.json` for use in godot. 

### [Model](Model)
Collection of old models.

- [FromScratch](Model/FromScratch): Old models made from scratch(Some with in-game textures) before completing DTM2Blender script.

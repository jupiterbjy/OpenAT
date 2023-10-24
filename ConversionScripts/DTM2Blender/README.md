# Armada Tanks *.dtm model converter

Conversion Script for *Armada Tanks's* seemingly private model format `*.dtm` into blender/`*.glb`.   

![](https://github.com/jupiterbjy/OpenAT/assets/26041217/323abfd9-3fc1-4034-ad56-27f7b8243b67)
![](https://github.com/jupiterbjy/OpenAT/assets/45421813/d7bd0bb2-48dc-4d40-a1d0-2d15dee6dc4d)



## How to use

Two options:
- Install *Armada Tanks* via installer from official website & launch [dtm_2_json.py](dtm_2_json.py)
- Launch [dtm_2_json.py](dtm_2_json.py) with full path to game data(BaseT) as positional parameter

This will parse `Model/*.dtm` and `Script/model.scr`, rearranges & export as `*.json` in new subdirectory `dtm2json_output` at script's path.

Then:
1. Open up blender, clear up all in the scene by `ctrl+a` `del` & save the scene somewhere.
2. Load script [json_2_blender.py](json_2_blender.py).
3. Set script's `PATH` full path to `dtm2json_output` dir previously generated.
4. Run script - this will load all model into scene, including Animation & UV.
5. Load script [custom_batch_export.py](custom_batch_export.py).
6. Select all objects & run script.

After this, converted `*.glb` files will be sitting at subdir with same name as blender file.


## Internals

Search for clue was complicated - but result is simple and (somewhat) clear.

First, parses `model.scr` so we have complete list of which model is used in what name internally, and scale it uses.

Next, parses each `*.dtm` file - it contains mainly *Tvertex TFace Vertex Face* with metadata, where each Vertex has multiple frames.
Frame 0 being the idle pose, (if any) Frame 1 and onwards are positions for each vertex for use in Vertex Animation.

combined with `model.scr`'s scale data for each `*.dtm` file - this information is stored into corresponding named `*.json` files,
with `_lookup.json` for use in godot for translating internal model name & setting correct scale for each model, and `_files.txt` for letting blender side script know which files to look.

On Blender side script, it'll setup some logging & enable `MDD Exporter` addon in blender(it's not default-on)

Then, it will read `_files.txt` and read written file line by line.
For each line it'll create mesh from frame 0, create BMesh(BlenderMesh) for UV mapping. However, model contains UVW mapping but
Blender don't support 3rd Axis, so we drop W axis. (it's not empty btw)

After that, we create Object out of this mesh. If there's any frame after frame 0 - we setup vertex animation and bake current mesh as frame 1,
then start adding more frames from coordinates. 

Unfortunately, blender & GLTF exporter can't output raw vertex animations, so we need to use *NewTek*'s MDD format.
We now export obj with *MDD Exporter*, delete all keyframes for each vertex, import *MDD* again.

Then all keyframes are imported as ShapeKey in blender, with additional useless keys at start and end.
This keys mess up animation playback, so we select each unneeded keys and removes it. Trust me - it took very long to figure this out, you can't search this anywhere.

Then, it's finally all set - we export this by `custom_batch_export` script and each will be saved as `.glb` formats, immediately usable in godot.


## Big Thanks (Because they deserve)

Big thanks to almost-10-year-old answer & it's linked source for giving insight to scripted UV mapping!
- [Blender StackExchange Answer](https://blender.stackexchange.com/a/10444/126787)
- [Linked source(Warning: ol' HTTP site)](http://web.purplefrog.com/~thoth/blender/python-cookbook/barber-pole.html)

Also for the basics of keyframing vertex in script,
- [Blender StackExchange Answer](https://blender.stackexchange.com/a/283060/126787)

Final one for MDD Export-Import trick for vertex animations
- [MDD Trick](https://github.com/mrdoob/three.js/issues/18809#issuecomment-594629778)


## Behind story

Most of the time took to write this script is spent on researching how this never-seen `*.dtm` format works.

Apparently there's a format with same extension, but it's for geological terrain data mapping.
There's no information what `*.dtm` file is. I assume this is in-house format used by developers. 

Initially I went on rebuilding models from scratch, but it took way long time(about ~100hrs right now) and produced too little:

![](https://github.com/jupiterbjy/OpenAT/assets/45421813/89926229-243a-4984-b49e-3d5c95f0b2f0)

Yes - that's all I could make!

So, after getting mentally overloaded and physically exhausted, I looked back on idea of some kinda of reverse-engineering the DTM file.

It really seemed quite similar with what I heard in *Computer Graphics Lecture* in Hongik-University. Thought Just maybe, we can do this!
After long search and trials, about 4 hours or so, I managed to make it happen.

Couldn't save the `W` axis from `UVW` mapping devs were using though!

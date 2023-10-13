## Armada Tanks *.dtm model converter

![1Armada Tanks  dtm model converter](https://github.com/jupiterbjy/OpenAT/assets/45421813/d7bd0bb2-48dc-4d40-a1d0-2d15dee6dc4d)

For converting *Armada Tanks's* seemingly private model format `*.dtm` into blender object.  

### How to use

1. Gather all `*.dtm` files in *Armada Tanks* into single directory
2. Drag-drop that directory onto [dtm_2_json.py](dtm_2_json.py)
3. Script will recursively parse `*.dtm` into a dictionary, then cherry-pick, rearranges data & export as `*.json` in new directory
4. Open up blender, load script [json_2_blender.py](json_2_blender.py), set script's `PATH` to point [dtm_2_json.py](dtm_2_json.py) generated directory.

### Behind story

Most of the time took to write this script is spent on researching how this never-seen `*.dtm` format works.

Apparently there's a format with same extension, but it's for geological terrain data mapping.
There's no information what `*.dtm` file is. I assume this is in-house format used by developers. 

Initially I went on rebuilding models from scratch, but it took way long time(about ~100hrs right now) and produced too little:

![2Initially I went on rebuilding models from scratch, but it took way long time(about ~100hrs right now) and produced too little](https://github.com/jupiterbjy/OpenAT/assets/45421813/89926229-243a-4984-b49e-3d5c95f0b2f0)

So, after getting mentally overloaded and physically exhausted, I looked back on idea of some kinda of reverse-engineering the DTM file.

It really seemed quite similar with what I heard in *Computer Graphics Lecture* in Hongik-University. Thought Just maybe, we can do this!
After long search and trials, about 4 hours or so, I managed to make it happen. Couldn't save the `W` axis from `UVW` mapping devs were using thought! 

Big thanks to almost-10-year-old answer and it's linked source for giving insight to scripted UV mapping!
- [Blender StackExchange Answer](https://blender.stackexchange.com/a/10444/126787)
- [Linked source(Warning: ol' HTTP site!)](http://web.purplefrog.com/~thoth/blender/python-cookbook/barber-pole.html)

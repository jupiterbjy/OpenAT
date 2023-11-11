"""
Exports all selected objects into individual files specified in EXPORT_TYPE.

All files will be saved in script's named subdir.

No need to center every object into world center - script will handle that.

Written by jupiterbjy@gmail.com
"""


import os
import pathlib

import bpy


# CONFIG --------------

EXPORT_TYPE = "gltf"
SCALE = 0.1

# ---------------------


# select extension and exporter
EXTENSION = {
    "gltf": ".glb",
    "fbx": ".fbx",
}[EXPORT_TYPE]

EXPORTER = getattr(bpy.ops.export_scene, EXPORT_TYPE)


# check if file is saved
if not bpy.data.filepath:
    raise Exception("Blend file is not saved")


# init basedir
_file = pathlib.Path(bpy.data.filepath)

basedir = _file.parent / _file.stem
basedir.mkdir(exist_ok=True)


# cache selection and deselect all ---------
view_layer = bpy.context.view_layer

obj_active = view_layer.objects.active
selection = bpy.context.selected_objects

bpy.ops.object.select_all(action='DESELECT')


# shadow print() for output redirection to UI ---------
_overrides = []

for window in bpy.context.window_manager.windows:
    _overrides.extend(
        {"window": window, "screen": window.screen, "area": area} for area in window.screen.areas if area.type == "CONSOLE"
    )

def print(*args, sep=""):
    for override in _overrides:
        bpy.ops.console.scrollback_append(override, text=sep.join(map(str, args)), type="OUTPUT")


# for each cached selection export ---------
for obj in selection:
    

    # build clean path without illegal characters
    name = bpy.path.clean_name(obj.name)
    fn = basedir / (name + EXTENSION)
    
    # some exporters only use the active object - make sure it's selected and active
    obj.select_set(True)
    view_layer.objects.active = obj
    
    # move object to world center - or some exporter like gltf keeps offset when saving
    # need to cache old position explicitly
    old_pos = obj.location[:]
    obj.location = (0, 0, 0)
    
    old_scale = obj.scale[:]
    obj.scale = (SCALE, SCALE, SCALE)

    # export
    EXPORTER(filepath=fn.as_posix(), use_selection=True)
    print("written:", fn)

    # reset selection and position
    obj.location = old_pos
    obj.scale = old_scale
    
    obj.select_set(False)


# re-select & reset active for cached to keep consistency in view
view_layer.objects.active = obj_active

for obj in selection:
    obj.select_set(True)

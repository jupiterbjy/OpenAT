"""
Blender script for rebuilding json-ed *.dtm files back into shape
"""

import os
import math
import json
import pathlib
import tempfile

import bpy
import bmesh
import addon_utils


# CONFIG/ENV ---------

# change path to your dtm2json output path
PATH = r"E:\github\OpenAT\ConversionScripts\DTM2Blender\dtm2json_output"
PATH = pathlib.Path(PATH)

PATH_LIST = PATH / "_files.txt"
ENCODING = "utf8"

TEMP_FD, TEMP_FILE = tempfile.mkstemp(suffix=".mdd")


# shadow print() for output redirection to UI ---------

_overrides = []

for window in bpy.context.window_manager.windows:
    _overrides.extend(
        {"window": window, "screen": window.screen, "area": area}
        for area in window.screen.areas if area.type == "CONSOLE"
    )


def print(*args, sep=""):
    for override in _overrides:
        bpy.ops.console.scrollback_append(override, text=sep.join(map(str, args)), type="OUTPUT")


# make sure NewTek MDD format is enabled ---------

if not addon_utils.check("io_shape_mdd")[1]:
    print("Enabling MDD format addon")
    addon_utils.enable("io_shape_mdd")
else:
    print("MDD format addon already loaded")


# util functions ---------

def yield_files_gen():
    """path list yielding iterator"""
    for raw_path in PATH_LIST.read_text(ENCODING).splitlines():
        yield pathlib.Path(raw_path)


def cleanup_temp():
    """Remove temp file"""

    file = pathlib.Path(TEMP_FILE)

    try:
        file.unlink(missing_ok=True)

    except PermissionError:
        # need few more steps
        # ref: https://stackoverflow.com/a/50520072/10909029
        os.close(TEMP_FD)
        file.unlink()


# main functions ---------

def vertex_anim_to_shapekey(obj, frame_count):
    """Convert vertex animation into shapekeys"""

    # select & set active
    obj.select_set(True)
    bpy.context.view_layer.objects.active = obj

    # export
    print("Exporting mdd")
    bpy.ops.export_shape.mdd(filepath=TEMP_FILE, fps=11, frame_end=frame_count)

    # remove all keyframes
    for vertex in obj.data.vertices:
        for frame_no in range(1, frame_count + 1):
            vertex.keyframe_delete("co", frame=frame_no)

    # import - we want this start from 0 so gltf export can use frame 0 as resting position.
    print("Importing mdd")
    bpy.ops.import_shape.mdd(filepath=TEMP_FILE)

    # delete unnecessary basis key - that's frame 0 for us
    obj.active_shape_key_index = 0
    bpy.ops.object.shape_key_remove()

    # took entire night to figure this out, not on Google at least...
    # we need to remove -1 keyframe from frame_0000, that's duplicate.
    # also, remove last frame's last key, as this key resets animation back to frame 0.
    delete_target = {
        "frame_0000": -1,
        f"frame_{frame_count - 1:04}": frame_count
    }

    for key, frame in delete_target.items():
        obj.data.shape_keys.key_blocks[key].keyframe_delete("value", frame=frame)

    # unselect
    obj.select_set(False)


def reconstruct_uv(data: dict, mesh):
    """Reconstructs UV"""

    # create uv
    mesh.uv_layers.new()

    # create bmesh
    bm = bmesh.new()
    bm.from_mesh(mesh)

    # invalidate caching
    bm.faces.ensure_lookup_table()

    # cache uv layer obj
    uv_layer = bm.loops.layers.uv[0]

    # map uv
    for face_idx, t_vert_indices in enumerate(data["tex_loop"]):
        for in_loop_idx, t_vert_idx in enumerate(t_vert_indices):
            u, v, w = data["tex_vert"][t_vert_idx]
            bm.faces[face_idx].loops[in_loop_idx][uv_layer].uv = u, v

    # update bmesh and create obj with complete mesh
    bm.to_mesh(mesh)


def insert_keyframes(non_rest_keyframes, obj):
    """Add animation to obj"""

    print(f"Inserting {len(non_rest_keyframes)} more keyframes")

    # insert current state as first shape key
    for vertex in obj.data.vertices:
        # co stand for coordinates from what I see in manual
        vertex.keyframe_insert("co", frame=1)

    # fill in other frames
    for frame_no, frame in enumerate(non_rest_keyframes, 2):

        for vertex, frame_pos in zip(obj.data.vertices, frame):
            vertex.co = frame_pos
            vertex.keyframe_insert("co", frame=frame_no)

    # convert so it can be exported in gltf
    vertex_anim_to_shapekey(obj, len(non_rest_keyframes) + 1)


def reconstruct(file_path: pathlib.Path):
    """Reconstructs json-converted DTM file"""

    data = json.loads(file_path.read_text(ENCODING))

    # make sure there's at least one surface. Terr_Zero.dtm has ONE vertex, and it crashed Blender!
    if len(data["vertices"][0]) < 3:
        print(f"Only {len(data['vertices'])} in file {file_path.stem}! Skipping!")
        return

    # fetch first vertex keyframe
    base_keyframe, *other_keyframes = data["vertices"]

    # rebuild mesh from first keyframe
    mesh = bpy.data.meshes.new("cube_mesh_data")
    mesh.from_pydata(base_keyframe, [], data["faces"])
    mesh.update()

    # reconstruct uv & create obj
    reconstruct_uv(data, mesh)
    obj = bpy.data.objects.new(file_path.stem, mesh)

    # add object to main collections so we can select individually
    scene = bpy.context.scene
    scene.collection.objects.link(obj)

    # insert keyframe if there's more than one frame
    if other_keyframes:
        insert_keyframes(other_keyframes, obj)

    # set correct scale
    scale = data["scale"]
    obj.scale = scale, scale, scale

    # adjust rotation since blender use difference axis orders
    obj.rotation_euler = (math.radians(90), 0, 0)


# Driver --------

try:
    for _path in yield_files_gen():
        print(f"Reconstructing {_path}")
        reconstruct(_path)
finally:
    cleanup_temp()

"""
Blender script for rebuilding json-ed *.dtm files back into shape
"""

import math
import json
import pathlib

import bpy
import bmesh


# CONFIG ---------

# change path to your dtm2json output path
PATH = r"E:\github\OpenAT\ConversionScripts\DTM2Blender\dtm2json_output"
PATH = pathlib.Path(PATH)

PATH_LIST = PATH / "_files.txt"
ENCODING = "utf8"


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


# main functions ---------

def yield_files_gen():
    """path list yielding iterator"""
    for raw_path in PATH_LIST.read_text(ENCODING).splitlines():
        yield pathlib.Path(raw_path)


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


def insert_keyframes(keyframes, obj):
    """Add animation to obj"""

    print(f"Inserting {len(keyframes)} more keyframes")

    vertices = obj.data.vertices

    # insert current state as first shape key
    for vertex in vertices:
        # co stand for coordinates from what I see in manual
        vertex.keyframe_insert("co", frame=1)

    # fill in other frames
    for frame_no, frame in enumerate(keyframes, 2):
        print(f"Inserting frame {frame_no}")

        for vertex, frame_pos in zip(vertices, frame):
            vertex.co = frame_pos
            vertex.keyframe_insert("co", frame=frame_no)


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

    # insert keyframe if there's more than one frame
    if other_keyframes:
        insert_keyframes(other_keyframes, obj)

    # scale
    scale = data["scale"]
    obj.scale = scale, scale, scale

    # adjust rotation since blender use difference axis orders
    obj.rotation_euler = (math.radians(90), 0, 0)

    # add object to main collections
    scene = bpy.context.scene
    scene.collection.objects.link(obj)


# generate objects
for _path in yield_files_gen():
    print(f"Reconstructing {_path}")
    reconstruct(_path)

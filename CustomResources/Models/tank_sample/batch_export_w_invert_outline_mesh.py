"""
Export each selected object into it's own file
And also Generate Inverted normal mesh to make toonshading effect

Based on batch_export.py - edited by jupiterbjy
"""

import bpy
import os

# CONFIG ====================


# scale of inverted normal mesh in individual origin
scale = 1, 1, 1


# Outline material name. If no such material exists, creates one
outline_material_name = "Outline"


# Collection name to store outline objects
outline_collection_name = "Outlines"


# Pivot point
pivot = "INDIVIDUAL_ORIGINS"


# Save individual files?
save = False


# Bake Log ==================


def log_closure():
    
    window = bpy.context.window_manager.windows[0]
    screen = window.screen
    
    for area in screen.areas:
        if area.type == 'CONSOLE':
            break

    def _log(val):
        bpy.ops.console.scrollback_append(
            {'window': window, 'screen': screen, 'area': area},
            text=str(val)
        )
    
    return _log


log = log_closure()
log("\n\n\nLogging Start") 


# PREP ======================


# check if material exists
outline_mat = bpy.data.materials.get(outline_material_name)

if outline_mat is None:
    outline_mat = bpy.data.materials.new(name=outline_material_name)
    log(f"Created material {outline_material_name}")
else:
    log(f"Selected material {outline_material_name}")


# Create new collection
collection = bpy.data.collections.new(outline_collection_name)
bpy.context.scene.collection.children.link(collection)


# Make sure pivot point is set to individual origin
bpy.context.scene.tool_settings.transform_pivot_point = pivot
log(f"Setting Transform Pivot Point to {pivot}")


# ===========================


# export to blend file location
basedir = os.path.dirname(bpy.data.filepath)

if not basedir:
    raise Exception("Blend file is not saved")

view_layer = bpy.context.view_layer

obj_active = view_layer.objects.active
selection = bpy.context.selected_objects

bpy.ops.object.select_all(action='DESELECT')


for idx, obj in enumerate(selection):
    
    log(f"Processing {obj.name} - ({idx}/{len(selection)})")
    
    # create copy
    outline_obj = obj.copy()
    outline_obj.data = obj.data.copy()
    
    # Set name, link to collection
    outline_obj.name = obj.name + "_inverted"
    collection.objects.link(outline_obj)
    
    # Select copied object
    outline_obj.select_set(True)
    view_layer.objects.active = outline_obj
    
    # remove all materials but one
    for idx in range(1, len(outline_obj.material_slots)):
        
        log(f" Removing material {idx}")
        
        outline_obj.active_material_index = idx
        bpy.ops.object.material_slot_remove()
    
    # assign new mat
    log(f" Assigning outline material")
    outline_obj.data.materials[0] = outline_mat
    
    # enter edit mode
    bpy.ops.object.mode_set(mode="EDIT")
    
    # and scale
    log(f" Resizing mesh")
    bpy.ops.mesh.select_all(action="SELECT")
    bpy.ops.transform.resize(
        value=scale,
        orient_type='GLOBAL',
        orient_matrix=((1, 0, 0), (0, 1, 0), (0, 0, 1)),
        orient_matrix_type='GLOBAL',
        mirror=True,
        use_proportional_edit=False,
        proportional_edit_falloff='SMOOTH',
        proportional_size=1,
        use_proportional_connected=False,
        use_proportional_projected=False,
        snap=False,
        snap_elements={'INCREMENT'},
        use_snap_project=False, snap_target='CLOSEST',
        use_snap_self=True,
        use_snap_edit=True,
        use_snap_nonedit=True,
        use_snap_selectable=False
    )
    
    # invert normal & pull out of edit mode
    bpy.ops.mesh.normals_make_consistent(inside=True)
    bpy.ops.object.editmode_toggle()
    
    # unset selection
    outline_obj.select_set(False)
    
    if not save:
        continue
    
    # export
    for obj_ in (obj, outline_obj):
    
        obj_.select_set(True)

        # some exporters only use the active object
        view_layer.objects.active = obj_

        name = bpy.path.clean_name(obj_.name)
        fn = os.path.join(basedir, name)

        bpy.ops.export_scene.fbx(filepath=fn + ".fbx", use_selection=True)

        # Can be used for multiple formats
        # bpy.ops.export_scene.x3d(filepath=fn + ".x3d", use_selection=True)

        obj.select_set(False)

        print("written:", fn)


view_layer.objects.active = obj_active

for obj in selection:
    obj.select_set(True)

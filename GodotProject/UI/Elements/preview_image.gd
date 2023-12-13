class_name LevelPreviewRect
extends Sprite2D


static var _area_template: Dictionary = {
	"MAPPREV": load("res://Textures/Raw/MapPrev.jpg"),
	"MAPPREVS": load("res://Textures/Raw/MapPrevS.JPG"),
	"MAPPREVT": load("res://Textures/Raw/MapPrevT.JPG"),
}


func load_preview(texture_name: String, area_id: int, map_id: int):
	print("[LevelPreview] Loading preview [a:%s s:%s]" % [area_id, map_id])
	
	# get map image
	texture = _area_template[texture_name]
	
	# get region
	# TODO: unify area_id to start from idx 0 just like level_id
	region_rect = Rect2(map_id * 96, ((area_id - 1) % 5) * 96, 96, 96)

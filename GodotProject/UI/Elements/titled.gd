extends Control


@export var title: String = "Sample Text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$title.text = title

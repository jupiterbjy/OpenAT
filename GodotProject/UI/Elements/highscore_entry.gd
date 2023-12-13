extends HBoxContainer


var player_name: String = "EMPTY"
var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = player_name
	$Label3.text = str(score)

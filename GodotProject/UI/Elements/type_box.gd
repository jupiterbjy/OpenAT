extends LineEdit

var _compiled: RegEx = RegEx.new()


func _ready():
	_compiled.compile(r"[!_=<>\-\*\+0-9a-zA-Z ]*")


func _on_text_changed(new_text):
	text = ""
	for matched in _compiled.search_all(new_text):
		text += matched.get_string()
	
	caret_column = len(text)

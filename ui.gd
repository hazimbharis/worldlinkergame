extends CanvasLayer

# var textpopup = load("res://text_popup.tscn")

func _create_text(mouse_position):
	var t = load("res://text_popup.tscn").instantiate()
	add_child(t)
	t.position = mouse_position
	

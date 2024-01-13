extends Node3D

func _create_text(mouse_position):
	var t = load("res://3d_label.tscn").instantiate()
	add_child(t)
	t.position = mouse_position

extends CanvasLayer

# var textpopup = load("res://text_popup.tscn")

enum PopupIds {
	ADD_NODE
}

var _last_mouse_position

@onready var _popup_menu = $PopupMenu
@onready var info = $InfoboxContainer/MarginContainer/HBoxContainer/Label

func _create_text(mouse_position):
	#var t = load("res://text_popup.tscn").instantiate()
	#get_parent().add_child(t)
	#t.position = mouse_position
	pass

func _ready():
	EventBus.connect("update_attributes", _update_info)
	_popup_menu.add_item("Add Rail Node", PopupIds.ADD_NODE)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
		_last_mouse_position = get_viewport().get_mouse_position()
		_popup_menu.popup(Rect2(_last_mouse_position.x, _last_mouse_position.y, 100, 100))

func _update_info(attributes):
	var placeholder = [attributes.planet_name, attributes.planet_type, attributes.planet_status]
	info.text = "Planet Info\n\nName: %s\n\nType: %s\n\nLevel: %s" % placeholder
	pass

func _on_popup_menu_id_pressed(id):
	match id:
		0:
			print(get_node("../CameraController").current_point())
	print_debug(id)
	pass # Replace with function body.


func _on_popup_menu_index_pressed(index):
	print_debug(index)
	pass # Replace with function body.

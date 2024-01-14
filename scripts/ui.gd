extends CanvasLayer

# var textpopup = load("res://text_popup.tscn")

var total_cost : float = 0.0

@onready var info = $InfoboxContainer/MarginContainer/HBoxContainer/Label
@onready var resource = $ResourceContainer/HBoxContainer/Label
@onready var indicator = $Label

func _create_text(mouse_position):
	#var t = load("res://text_popup.tscn").instantiate()
	#get_parent().add_child(t)
	#t.position = mouse_position
	pass

func _ready():
	EventBus.connect("update_attributes", _update_info)
	EventBus.connect("update_resources", _update_resource)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("l_click"):
		indicator.visible = true
	if Input.is_action_just_released("l_click"):
		indicator.visible = false
	if Input.is_action_pressed("l_click"):
		indicator.text = "Total cost: " + str(total_cost)
		indicator.position = Vector2(get_viewport().get_mouse_position().x-70,get_viewport().get_mouse_position().y-40)

func _update_info(attributes):
	var placeholder = [attributes.planet_name, attributes.planet_type, attributes.planet_status]
	info.text = "Planet Info\n\nName: %s\n\nType: %s\n\nLevel: %s" % placeholder
	pass

func _update_resource(resources):
	resource.text = "x " + str(int(resource.text.substr(2,-1)) + resources)
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

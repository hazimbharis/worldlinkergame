extends Node

@export var rail_node:PackedScene
@export var blow_node:PackedScene
enum building {
	RAIL,
	BLOWER,
	FENCE,
}
var current = building.RAIL
var rotation = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("l_click"):
		if current == building.RAIL:
			call_deferred("add_child", rail_node.instantiate())
		else:
			var blow = blow_node.instantiate()
			call_deferred("add_child", blow)
			blow.position = current_point()
			var t = load("res://scenes/3d_label.tscn").instantiate()
			t.text = "HOVER & R = ROTATE"
			add_child(t)
			t.position = current_point() + Vector3(0, 2, 0)
			
	if Input.is_action_just_pressed("1"):
		current = building.RAIL
	if Input.is_action_just_pressed("2"):
		current = building.BLOWER
	

func current_point():
	var cam = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = cam.project_ray_origin(mouse_pos)
	var ray_to = ray_from +  cam.project_ray_normal(mouse_pos) * 10000
	return Plane.PLANE_XZ.intersects_ray(ray_from, ray_to)

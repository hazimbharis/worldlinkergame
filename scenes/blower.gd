extends Node3D
@export var area3d:Area3D
var selecting = false
#var visualization = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if !visualization:
	var overlap = area3d.get_overlapping_areas()
	print(overlap)
	for child in overlap:
		if child.get_parent().is_in_group("resource"):
			var res = child.get_parent()
			print("doing!")
			res.global_position += (Vector3.MODEL_FRONT*delta).rotated(Vector3(0,1,0), get_rotation().y) #A bit of a dirty fix, but we don't have a lotta time
	
	if selecting:
		if Input.is_action_just_pressed("rotate_key"):
			rotate(Vector3(0, 1, 0), deg_to_rad(45))
			print(rotation.y)

func current_point():
	var cam = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = cam.project_ray_origin(mouse_pos)
	var ray_to = ray_from +  cam.project_ray_normal(mouse_pos) * 10000
	return Plane.PLANE_XZ.intersects_ray(ray_from, ray_to)


func _on_collision_mouse_entered() -> void:
	selecting = true


func _on_collision_mouse_exited() -> void:
	selecting = false

extends Node3D

@export var start:Marker3D
@export var end:Marker3D
@export var path:Path3D

var points = []
var last_point:Vector3 = Vector3(0, -10000000, 0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("l_click"):
		#points = []
	if Input.is_action_pressed("l_click"):
		#print("click")
		#if Engine.get_process_frames() % 10 == 0:
		var current:Vector3 = current_point()
		if current.distance_squared_to(last_point) > 0.5:
			
			#print("new point!")
			last_point = current
			points.append(current)
	#print(points.size())
	if Input.is_action_just_released("l_click"):
	#if randi() % 10 == 5:
		var curve = Curve3D.new()
		for p in points:
			curve.add_point(p)
		path.curve = curve
		#points = []
		set_process(false)
func current_point():
	var cam = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = cam.project_ray_origin(mouse_pos)
	var ray_to = ray_from +  cam.project_ray_normal(mouse_pos) * 10000
	return Plane.PLANE_XZ.intersects_ray(ray_from, ray_to)

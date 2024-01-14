extends Node3D

@export var movement_speed:float = 20
@export var camera:Camera3D
@export var trail:GPUParticles3D
@export var delete_raycast:RayCast3D
#signal focused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	#trail.visible = false
	EventBus.connect("focused_at", on_new_focus_point)
	
	#trail.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)
	if Input.is_action_just_pressed("l_click"):
		trail.restart()
		trail.visible = true
		#trail.set_process(true)
	if Input.is_action_just_released("l_click"):
		trail.visible = false
		#trail.restart()
		#trail.set_process(false)
	if Input.is_action_pressed("l_click"):
		trail.position = current_point()
	if Input.is_action_pressed("r_click"):
		delete_raycast.position = current_point() - Vector3(0, 5, 0)
		if delete_raycast.is_colliding():
			print("raycast colliding!!!!")
			var del = delete_raycast.get_collider()
			if del.name == "CSGPolygon3D":
				del.get_parent().destroy_path(Vector3(-100000, 1000000, 10000000))
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			camera.position.z = clampf(camera.position.z - 0.85, 5, 15)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			camera.position.z = clampf(camera.position.z + 0.85, 5, 30)
		var s = trail.draw_pass_1.size
		trail.draw_pass_1.size = Vector2(remap(camera.position.z, 5, 15, 0.5, 1.5), remap(camera.position.z, 5, 15, 0.5, 1))

func _move(delta):
	var velocity = Vector3.ZERO
	if Input.is_action_pressed("up"):
		velocity -= basis.z
	if Input.is_action_pressed("down"):
		velocity += basis.z
	if Input.is_action_pressed("left"):
		velocity -= basis.x
	if Input.is_action_pressed("right"):
		velocity += basis.x
	
	velocity = velocity.normalized()
	position += velocity * movement_speed * delta
	
	#RenderingServer.global_shader_parameter_set("camera_position", position)
func on_new_focus_point(p: Vector3):
	get_tree().create_tween().tween_property(self, "position", p, position.distance_to(p)/ 50)


func current_point():
	var cam = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = cam.project_ray_origin(mouse_pos)
	var ray_to = ray_from +  cam.project_ray_normal(mouse_pos) * 10000
	return Plane.PLANE_XZ.intersects_ray(ray_from, ray_to)

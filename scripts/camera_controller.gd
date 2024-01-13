extends Node3D

@export var movement_speed:float = 20
@export var camera:Camera3D

#signal focused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_move(delta)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			camera.position.z = clampf(camera.position.z - 0.85, 5, 15)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			camera.position.z = clampf(camera.position.z + 0.85, 5, 30)

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


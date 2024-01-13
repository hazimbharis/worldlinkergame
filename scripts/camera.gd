extends Camera3D

const MIN_ZOOM: float = 0.1
const MAX_ZOOM: float = 1.0
const ZOOM_INCREMENT: float = 0.1
const ZOOM_RATE: float = 8.0

var _target_zoom: float = 1.0

func zoom_in() -> void:
	_target_zoom = max(_target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
	set_physics_process(true)

func zoom_out() -> void:
	_target_zoom = min(_target_zoom + ZOOM_INCREMENT, MIN_ZOOM)
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	#zoom = lerp(zoom, int(_target_zoom) * 1, ZOOM_RATE * delta)
	#set_physics_process(not is_equal_approx(zoom.x, _target_zoom))
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position.x -= event.relative.x #* zoom
			position.z -= event.relative.y
		if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			rotation.x -= event.relative.x #* zoom
			rotation.z -= event.relative.y
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				fov -= ZOOM_RATE
				zoom_in()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				fov += ZOOM_RATE
				zoom_out()

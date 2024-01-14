extends Sprite2D

func _ready():
	EventBus.connect("change_color", update)
	
func update(state):
	if state == 1:
		material.set_shader_parameter("source", Color(0.0, 0.0, 0.0, 1.0))
		pass
	else:
		material.set_shader_parameter("source", Color(1.0, 0.0, 0.0, 1.0))
		pass
		#disable

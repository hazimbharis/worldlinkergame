extends Node3D

@onready var info = $PlanetInfo

var spin_deg:float = 0
var orbit_deg:float = 0

@export var planet_mesh:MeshInstance3D
@export var root:Node3D


func _ready() -> void:
	planet_mesh.scale = Vector3(1, randf_range(0.85, 1), 1)
	spin_deg = randi_range(5, 25)
	orbit_deg = randi_range(1, 5)
func _physics_process(delta: float) -> void:
	
	rotation.y = wrapf(rotation.y + deg_to_rad(spin_deg*delta), -PI, PI)
	#print("hi")
func _on_mouse_entered() -> void:
	#get_node("../../CanvasLayer")._update_info(info.attributes)
	#print("entered!")
	print("hello!")
	pass


func _on_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	print("hi")
	if event is InputEventMouseButton:
		if event.double_click:
			print('double click ', event)
			#._create_text(Vector3(position.x, 1, position.z))
			EventBus.emit_signal("focused_at", self.global_position)
		elif event.button_index == 1:
			#find_
			pass
			#%CanvasLayer._update_info(info.attributes)

@tool
extends Node3D

var spin_deg:float = 0


@export var planet_mesh:MeshInstance3D

func _ready() -> void:
	planet_mesh.scale = Vector3(1, randf_range(0.85, 1), 1)
	spin_deg = randi_range(5, 25)
func _physics_process(delta: float) -> void:
	
	rotation.y = wrapf(rotation.y + (deg_to_rad(spin_deg)*delta), -PI, PI)


func _on_mouse_entered() -> void:
	#print("entered!")
	pass


func _on_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.double_click:
		print('double click ', event)
		get_node("../../CanvasLayer")._create_text(event.position)

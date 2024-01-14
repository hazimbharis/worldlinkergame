@tool
extends PathFollow3D

@export var speed:float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().create_tween().tween_property(self, "progress_ratio", 1.0, speed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _physics_process(delta: float) -> void:
	progress_ratio += delta * (speed*0.5)

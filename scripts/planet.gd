extends Node3D

@export var info:PlanetAttributes

var spin_deg:float = 0
var orbit_deg:float = 0

@export var planet_mesh:MeshInstance3D
@export var root:Node3D

# should be different resources depending on the planet
@export var resource:PackedScene

var basic_resource = 0:
	set(val):
		basic_resource = val
		print("resource increased!")

func _ready() -> void:
	planet_mesh.scale = Vector3(1, randf_range(0.85, 1), 1)
	spin_deg = randi_range(5, 25)
	orbit_deg = randi_range(1, 5)
	randomize()
	#info.resource_local_to_scene = true
	info.planet_name = str(randi())
	info.planet_type = str(randi())
	info.planet_status = "UNREGISTERED"
	
	$Timer.wait_time = info.production_seed * 3
func _physics_process(delta: float) -> void:
	
	rotation.y = wrapf(rotation.y + deg_to_rad(spin_deg*delta), -PI, PI)
	if Input.is_action_just_pressed("ui_down"):
		produce_material()
	#print("hi")
func _on_mouse_entered() -> void:
	EventBus.emit_signal("update_attributes", info)
	#._update_info(info.attributes)
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

func produce_material():
	pass
	# whatever material this planet produces
	#var rails = get_tree().get_nodes_in_group("rail")
	#var closest = INF
	#for rail in rails:
		#if rail.points.size() != 0:
			#var first = rail.points[0]
			#if first.distance_to(global_position) < closest:
				#closest = first
	#if closest != INF:
		#print("closest rail at: ", closest)


func _on_mouse_exited() -> void:
	EventBus.emit_signal("update_attributes", PlanetAttributes.new())


func _on_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.name == "CSGPolygon3D":
		body.get_parent().destroy_path()
		#print(body, " entered!")


func _on_timer_timeout() -> void:
	var res = resource.instantiate()
	print("spawn")
	
	add_child(res)
	res.scale = Vector3(1, 1, 1)
	res.global_position = global_position + Vector3(0, 0, 0)
	get_tree().create_tween().tween_property(res, "global_position", res.global_position + Vector3(5,0, 0).rotated(Vector3(0, 1, 0), randf() * 2 * PI), 2)
	res.from = self

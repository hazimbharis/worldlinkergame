extends Node3D

@export var start:Marker3D
@export var end:Marker3D
@export var path:Path3D

@export var resource:PackedScene
@export var csgpoly:CSGPolygon3D

var points = []
var last_point:Vector3 = Vector3(0, -10000000, 0)
var dist = 0
var created := false
var launch_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#csgpoly.get_collision_layer_value()
	print_debug(get_tree())
	pass


func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("l_click"):
		#points = []
	if !created:
		if Input.is_action_pressed("l_click"):
			#print("click")
			#if Engine.get_process_frames() % 10 == 0:
			var current:Vector3 = current_point()
			if current.distance_squared_to(last_point) > 0.5:
				
				#print("new point!")
				last_point = current
				points.append(current)
				
				# this is prob a war crime but idc
				dist += 0.5
				get_node("../../CanvasLayer").total_cost = round(dist)
		#print(points.size())
		if Input.is_action_just_released("l_click"):
		#if randi() % 10 == 5:
			if (int(get_node("../../CanvasLayer").resource.text.substr(2,-1)) - dist*2 < 0): 
				var t = load("res://scenes/3d_label.tscn").instantiate()
				t.text = str("Not enough resources")
				t.position = self.position
				get_parent().add_child(t)
				print("too much")
				queue_free()
				return
			var curve = Curve3D.new()
			for p in points:
				curve.add_point(p)
			path.curve = curve
			#points = []
			
			start.position = points[0]
			end.position = points[points.size()-1]
			start.visible = true
			end.visible = true
			created = true
			print("COST!!:(if not enough dont build) ", dist*2)
			EventBus.emit_signal("building_cost",dist*2)
	else:
		if points.size() < 5:
			EventBus.emit_signal("building_cost",-dist*2)
			queue_free()
		#set_process(false)
	if Input.is_action_just_pressed("ui_right"):
		#print("hello")
		$Path3D.add_child(resource.instantiate())
func current_point():
	var cam = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = cam.project_ray_origin(mouse_pos)
	var ray_to = ray_from +  cam.project_ray_normal(mouse_pos) * 10000
	return Plane.PLANE_XZ.intersects_ray(ray_from, ray_to)

func pass_resource(lifetime,type):
	print("passeD?")
	var res = resource.instantiate()
	res.type = type
	res.lifetime = lifetime
	var t = load("res://scenes/3d_label.tscn").instantiate()
	t.text = str(res.type)
	t.disappear = false
	res.add_child(t)
	res.from = $Start/IN
	$Path3D.call_deferred("add_child", res)

func destroy_path():
	var t = get_tree().create_tween()
	t.tween_property(self, "position", position - Vector3(0, 1000, 0), 20)
	await t.finished
	#await get_tree().create_tween().tween_property(self, "position.y", -50, 1).finished
	call_deferred("queue_free")
	

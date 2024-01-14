extends PathFollow3D

var lifetime = 0
var from
var following = true
var Velocity = Vector3.ZERO
var dec_velocity = Vector3.ZERO

var type

@export var mesh:MeshInstance3D
var multiplier = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lifetime > 120:
		call_deferred("queue_free")
	
	
func _physics_process(delta: float) -> void:
	if following:
		progress += delta * 5
	else:
		position += Velocity * delta
	lifetime += delta * multiplier

func _on_area_3d_area_entered(area: Area3D) -> void:
	
	#print(area, " entered!")
	if area.is_in_group("planet"):
		print("touched planet")
		if area != from:
			area.basic_resource += 1
			call_deferred("queue_free")
	elif area.is_in_group("input"):
		if area != from:
			area.get_parent().get_parent().pass_resource(lifetime)
			call_deferred("queue_free")
		print("touched_start")
	elif area.is_in_group("output"):
		print("touched_end!")
		
		#var areas:Array[Area3D] = $Area3D.get_overlapping_areas()
		#areas = areas.filter(func(a): 
			#return a.name != "OUT")
#
		#if areas.size() != 0:
#
			#var a = areas.pick_random()
			#a.get_parent().get_parent().pass_resource()
		#
		#call_deferred("queue_free")
		#area.get_parent().get_parent().free_resource(SURVIVAL_TIME)
		following = false
		
		var points = get_parent().get_parent().points
		if points.size()>=2:
			var dir = points[points.size()-1] - points[points.size() -2]
			Velocity = dir.normalized()*get_parent().get_parent().launch_speed
		#await get_tree().create_timer(SURVIVAL_TIME).timeout
		
		#var t = get_tree().create_tween()
		#t.tween_property(mesh.get_surface_override_material(0), "albedo_color:", Color(0, 1, 1), 1)
		#await t.finished
		lifetime = 0
		multiplier = 15
		#call_deferred("queue_free")
	pass # Replace with function body.

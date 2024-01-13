extends Node3D

@export var mesh:Mesh

var mm:RID
var instance_rid:RID

@export var min_dist := 2
@export var max_dist := 3
@export var quantity := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instance_rid = VisualInstance3D.new().get_instance()
	RenderingServer.instance_geometry_set_cast_shadows_setting(instance_rid, RenderingServer.SHADOW_CASTING_SETTING_OFF)
	
	mm = RenderingServer.multimesh_create()
	RenderingServer.multimesh_allocate_data(mm, quantity, RenderingServer.MULTIMESH_TRANSFORM_3D)
	RenderingServer.multimesh_set_mesh(mm, mesh.get_rid())
	RenderingServer.instance_set_base(instance_rid, mm)
	RenderingServer.instance_set_scenario(instance_rid, get_world_3d().scenario)
	
	
	#RenderingServer.multimesh_set_visible_instances(mm, 1)
	#RenderingServer.multimesh_instance_set_transform(mm, 0, Transform3D(Basis(), Vector3(0, 1, 0)))
	var packed := PackedFloat32Array()
	for i in quantity:
		var theta = 2 * PI * randf()
		var phi = acos(2 * randf() - 1)
		var radius = randi_range(min_dist, max_dist)
		var x = radius * sin(phi) * cos(theta)
		var y = radius * sin(phi) * sin(theta)
		var z = radius * cos(phi)
		var point = Vector3(x, y, z)
			
		packed.append_array([1, 0, 0, point.x, 0, 1, 0, point.y, 0, 0, 1, point.z])
	RenderingServer.multimesh_set_buffer(mm, packed)
	#print("added!")
	#print(RenderingServer.multimesh_get_buffer(mm))

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		RenderingServer.free_rid(mm)
		RenderingServer.free_rid(instance_rid)


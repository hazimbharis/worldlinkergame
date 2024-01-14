extends Node3D

var SRPath = preload("res://scenes/StarRailPath.tscn")

func _ready():
	draw_path( create_path3D(Vector3(0,0,0), Vector3(-3,0,5)) ) #Test call. Can delete
	pass
	
func create_path3D(start: Vector3, end: Vector3) -> Path3D:
	var curve = Curve3D.new()
	curve.add_point(start, Vector3(1,0,0), Vector3(0,0,0)) #These 2 Vector3 values controls the curve of the spline
	curve.add_point(end, Vector3(0,0,0), Vector3(-1,0,0))   #These 2 Vector3 values controls the curve of the spline
	var path = Path3D.new()
	path.set_curve(curve)
	return path
	
func draw_path(path: Path3D):
	#Instantiates a CSGPolygon3D in path mode for drawing path
	var csgpoly = CSGPolygon3D.new()
	csgpoly.mode = 2
	add_child(path)
	csgpoly.path_node = path.get_path()
	add_child(csgpoly)
	
	print(path.get_curve().get_baked_points().size())
	var bakedPoints = path.get_curve().get_baked_points()
	var totalBakedPoints = path.get_curve().get_baked_points().size()
	var arr = []
	arr.append(round(0.8*totalBakedPoints))
	arr.append(round(0.6*totalBakedPoints))
	arr.append(round(0.4*totalBakedPoints))
	arr.append(round(0.2*totalBakedPoints))
	print(arr)
	for i in arr:
		print(bakedPoints[i])
		var SRPath = preload("res://scenes/StarRailPath.tscn")
		var instancePath
		instancePath = SRPath.instantiate()
		instancePath.position = bakedPoints[i]
		get_parent().add_child.call_deferred(instancePath)
		
		
	
	
	#The drawing process
	var line_radius = 0.001
	var line_resolution = 180
	var circle = PackedVector2Array()
	for degree in line_resolution:
		var x = line_radius * sin(PI * 2 * degree/line_resolution)
		var y = line_radius * cos(PI * 2 * degree/line_resolution)
		var coords = Vector2(x,y)
		circle.append(coords)
	csgpoly.polygon = circle

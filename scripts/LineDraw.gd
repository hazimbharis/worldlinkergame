extends Node3D

func _ready():
	draw_path( create_path3D(Vector3(0,0,0), Vector3(-3,0,5)) ) #Test call. Can delete
	pass
	
func create_path3D(start: Vector3, end: Vector3) -> Path3D:
	var curve = Curve3D.new()
	curve.add_point(start, Vector3(1,0,0), Vector3(0,-1,0)) #These 2 Vector3 values controls the curve of the spline
	curve.add_point(end, Vector3(0,0,-1), Vector3(1,0,0))   #These 2 Vector3 values controls the curve of the spline
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
	
	#The drawing process
	var line_radius = 0.1
	var line_resolution = 180
	var circle = PackedVector2Array()
	for degree in line_resolution:
		var x = line_radius * sin(PI * 2 * degree/line_resolution)
		var y = line_radius * cos(PI * 2 * degree/line_resolution)
		var coords = Vector2(x,y)
		circle.append(coords)
	csgpoly.polygon = circle

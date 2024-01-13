extends Node3D

func _ready():
	draw_path("../Path3D")   #This func call currently assumes Path3D is a node thats been manually instantiated.
	
func draw_path(path):
	#Instantiates a CSGPolygon3D in path mode for drawing path
	var csgpoly = CSGPolygon3D.new()
	csgpoly.mode = 2
	csgpoly.path_node = path
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

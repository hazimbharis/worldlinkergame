extends Node3D

var planet = preload("res://scenes/BasicPlanet.tscn")


func _ready():
	# do this 20 times
	var group = get_node("Planets")
	get_node("Planets")
	for i in range(20):
		# create a new instance of the planet scene
		var new_planet = planet.instantiate()

		# set its global_position to two random (float)
		# values lying somewhere between 0 and 40
		new_planet.position.x = randf_range(-40, 40)
		new_planet.position.z = randf_range(-40, 40)

		# add it as a child of this "universe"-node
		group.add_child(new_planet)

func _create_text(mouse_position):
	var t = load("res://scenes/3d_label.tscn").instantiate()
	add_child(t)
	t.position = mouse_position

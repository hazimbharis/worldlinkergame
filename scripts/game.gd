extends Node3D

var planet = preload("res://scenes/BasicPlanet.tscn")

var planetTypes = ["Industry", "Residential", "Resource-Rich"]
var planetNames = ["Tartarus", "Ledonides", "Epsilon Beanbula I", "Giamomia R72", "Crukides XI"]

var objectChance = 0
var planetChance = 0
var clusterSize = 0
var clusterType = 0
var initialSpawn = Vector2.ZERO
#

func _ready():
	# do this 20 times
	var group = get_node("Planets")
	get_node("Planets")
	for i in range(20):
		randomize()
		"""
		#decide if its a cluster or lone planet or obstacle - maybe no lone planets
		objectChance = randi_range(1,3)
		match objectChance:
			1: #cluster
				clusterType = randi_range(1,3)
				clusterSize = randi_range(3,5)
				for j in range(clusterSize):
					match clusterType:
						1: # single planet type cluster
							planetChance = randi_range(1,3)
							pass
						2: # network-type cluster
							pass
						3: # problem-required cluster
							pass
				pass
			2: #lone planet
				var new_planet = planet.instantiate()
				new_planet.position.x = randf_range(-40, 40)
				new_planet.position.z = randf_range(-40, 40)
				planetChance = randi_range(0,2)
				new_planet.info.attributes.planet_name = planetNames[randi_range(0,4)]
				new_planet.info.attributes.planet_type = planetTypes[planetChance]
				pass
			3: #obstacle
				clusterSize = randi_range(3,5)
				for j in range(clusterSize):
					pass
				pass
		"""
		# set its global_position to two random (float)
		# values lying somewhere between -40 and 40
		# create a new instance of the planet scene
		var new_planet = planet.instantiate()
		new_planet.position.x = randf_range(-40, 40)
		new_planet.position.z = randf_range(-40, 40)
		#new_planet.get_node("Mesh").mesh.surface_get_material(0).albedo_color = Color(randf(),randf(),randf())
		#doesnt work, changes color of all planets
		# add it as a child of this "universe"-node
		group.add_child(new_planet)

func _create_text(mouse_position):
	var t = load("res://scenes/3d_label.tscn").instantiate()
	add_child(t)
	t.position = mouse_position

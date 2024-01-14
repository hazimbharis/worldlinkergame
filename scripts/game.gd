extends Node3D

var planet = preload("res://scenes/BasicPlanet.tscn")
var asteroid = preload("res://scenes/AsteroidCloud.tscn")

var planetTypes = ["Industry", "Residential", "Resource-Rich"]
var planetNames = ["Tartarus", "Ledonides", "Beanbula I", "Giamomia R72", "Crukides XI"]

var objectChance = 0
var planetChance = 0
var clusterSize = 0
var clusterType = 0
var initialSpawn = Vector2.ZERO
var branchSpawn = Vector2.ZERO
#

func _ready():
	
	EventBus.connect("focused_at", _create_text)
	
	# do this 20 times
	var group = get_node("Planets")
	for i in range(0):
		randomize()
		initialSpawn.x = randf_range(-40, 40)
		initialSpawn.y = randf_range(-40, 40)
		
		
		#decide if its a cluster or lone planet or obstacle - maybe no lone planets
		objectChance = randi_range(1,3)
		match objectChance:
			1: #cluster
				clusterType = randi_range(1,3)
				clusterSize = randi_range(3,5)
				for j in range(clusterSize):
					branchSpawn.x = randf_range(initialSpawn.x-1, initialSpawn.x+1)
					branchSpawn.y = randf_range(initialSpawn.y-1, initialSpawn.y+1)
					match clusterType:
						1: # single planet type cluster
							var new_planet = planet.instantiate()
							new_planet.position.x = branchSpawn.x
							new_planet.position.z = branchSpawn.y
							planetChance = randi_range(0,2)
							new_planet.get_node("PlanetInfo").attributes.planet_name = planetNames[randi_range(0,4)]
							new_planet.get_node("PlanetInfo").attributes.planet_type = planetTypes[0]
							pass
						2: # network-type cluster
							var new_planet = planet.instantiate()
							new_planet.position.x = branchSpawn.x
							new_planet.position.z = branchSpawn.y
							planetChance = randi_range(0,2)
							new_planet.get_node("PlanetInfo").attributes.planet_name = planetNames[randi_range(0,4)]
							new_planet.get_node("PlanetInfo").attributes.planet_type = planetTypes[1]
							pass
						3: # problem-required cluster
							var new_planet = planet.instantiate()
							new_planet.position.x = branchSpawn.x
							new_planet.position.z = branchSpawn.y
							planetChance = randi_range(0,2)
							new_planet.get_node("PlanetInfo").attributes.planet_name = planetNames[randi_range(0,4)]
							new_planet.get_node("PlanetInfo").attributes.planet_type = planetTypes[2]
							pass
				pass
			2: #lone planet
				var new_planet = planet.instantiate()
				new_planet.position.x = randf_range(-40, 40)
				new_planet.position.z = randf_range(-40, 40)
				planetChance = randi_range(0,2)
				new_planet.get_node("PlanetInfo").attributes.planet_name = planetNames[randi_range(0,4)]
				new_planet.get_node("PlanetInfo").attributes.planet_type = planetTypes[planetChance]
				pass
			3: #obstacle
				clusterSize = randi_range(3,5)
				for j in range(clusterSize):
					pass
				pass
		
		var new_planet = planet.instantiate()
		#new_planet.position.x = randf_range(-40, 40)
		#new_planet.position.z = randf_range(-40, 40)
		planetChance = randi_range(0,2)
		new_planet.get_node("PlanetInfo").attributes.planet_name = planetNames[randi_range(0,4)]
		new_planet.get_node("PlanetInfo").attributes.planet_type = planetTypes[planetChance]
		#new_planet.get_node("Mesh").mesh.surface_get_material(0).albedo_color = Color(randf(),randf(),randf())
		#doesnt work, changes color of all planets
		#var rotator = rotator.instantiate()
		#rotator.add_child(new_planet)
		#rotator.speed = randf_range(0.01, 0.5)
		#rotator.position.x = randf_range(-40, 40)
		#rotator.position.z = randf_range(-40, 40)
		#rotator.rotation.y = randf() * 2 * PI
		new_planet.position.x = randi_range(5, 10)
		new_planet.position.z = randi_range(5, 10)
		
		
		group.add_child.call_deferred(new_planet)

func _create_text(mouse_position):
	var t = load("res://scenes/3d_label.tscn").instantiate()
	add_child(t)
	t.position = mouse_position

extends Resource
class_name PlanetAttributes

enum PlanetTypes {
	INDUSTRY,
	RESIDENTIAL,
	RESOURCERICH
}

enum PlanetStatus {
	UNCONNECTED,
	CONNECTED
}

@export var planet_type: String = "???"
@export var planet_name: String = "???"
@export var planet_status: String = "???"
@export var production_seed:int = 5

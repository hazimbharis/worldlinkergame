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

@export var planet_type: String = "Industry"
@export var planet_name: String = "Jaddy Wriggles"
@export var planet_status: String = "Unconnected"

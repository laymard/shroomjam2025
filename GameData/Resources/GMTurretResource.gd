class_name GMTurretResource
extends Resource

@export var health: int

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_health = 0):
	health = p_health

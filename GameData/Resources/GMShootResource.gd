class_name GMShootResource
extends Resource

@export var rate_of_fire:float
@export var projectile:PackedScene

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_rate_of_fire = 0, p_projectile = null):
	rate_of_fire = p_rate_of_fire
	projectile = projectile

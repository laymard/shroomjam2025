class_name GMTurretShootComponent
extends Node

@export
var ShootResource:GMShootResource

@onready var ShootTimer:Timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ShootTimer.wait_time = ShootResource.rate_of_fire
	ShootTimer.start()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	_shoot_projectile(%ShootOrigin.global_transform)
	pass # Replace with function body.

func _shoot_projectile(origin:Transform3D)->void:
	var projectileInstance:GMBaseProjectile = ShootResource.projectile.instantiate()
	projectileInstance.transform = origin
	get_tree().get_root().add_child(projectileInstance)
	pass
	

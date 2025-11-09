class_name GMTurretShootComponent
extends Node

@export var ShootResource:GMShootResource
@export var AutoStartShoot:bool = true

@onready var ShootTimer:Timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ShootTimer.wait_time = ShootResource.rate_of_fire
	if not ShootTimer.timeout.is_connected(_on_timer_timeout):
		ShootTimer.timeout.connect(_on_timer_timeout)
	if(AutoStartShoot):
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

func set_auto_shoot_enabled(isEnabled:bool) ->void:
	if (isEnabled):
		ShootTimer.start()
	else:
		ShootTimer.stop()
	

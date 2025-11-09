class_name GMBaseProjectile
extends RigidBody3D

@export var ProjectileDamage:float = 10
@export var ProjectileSpeed:float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	linear_velocity = state.transform.basis * Vector3.FORWARD * ProjectileSpeed

func _on_body_entered(body: Node) -> void:
	var healthComponent:GMHealthComponent = body.get("HealthComponent")
	if healthComponent != null:
		healthComponent._applyDamage(ProjectileDamage, self)
	queue_free()
	pass # Replace with function body.

class_name GMBaseEnemy
extends CharacterBody3D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")
@export var Player:GMPlayer
@onready var HealthComponent:GMHealthComponent = %GMHealthComponent

@onready var TurretShootComponent:GMTurretShootComponent= %GMTurretShootComponent

# private
var _currentAimedTurret: GMBaseTurret

func _process(delta: float) -> void:
	_orient_to_aimed_turret()

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	pass

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
	pass

func _physics_process(delta):
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer3D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()
	pass

func _on_navigation_agent_3d_target_reached() -> void:
	_self_explode()
	pass # Replace with function body.
	
func _self_explode() -> void:
	queue_free()
	pass

func _on_area_shoot_range_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if _currentAimedTurret != null:
		return
	
	var parentNode3D:Node3D = body.get_parent_node_3d()
	if  body is GMBaseTurret:
		var turretDetected: GMBaseTurret = body as GMBaseTurret
		_set_current_aim_target(turretDetected)
	pass # Replace with function body.


func _on_area_shoot_range_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if  body is GMBaseTurret and body==_currentAimedTurret:
		_set_current_aim_target(null)
	pass # Replace with function body.

func _orient_to_aimed_turret()->void:
	if _currentAimedTurret == null:
		return
	var orientation:Vector3 = _currentAimedTurret.global_position - global_position
	orientation *= Vector3(1,0,1)
	%Pivot.transform = %Pivot.transform.looking_at(orientation)
	pass
	
func _set_current_aim_target(target:GMBaseTurret)->void:
	var oldTurret = _currentAimedTurret
	
	_currentAimedTurret = target
	_on_turret_changed(oldTurret, _currentAimedTurret)
	
	pass

func _on_turret_changed(oldTurret:GMBaseTurret, newTurret:GMBaseTurret)->void:
	var hasTurret:bool = newTurret != null
	TurretShootComponent.set_auto_shoot_enabled(hasTurret)
	pass


func _on_gm_health_component_health_changed(oldValue: float, newvalue: float) -> void:
	if (newvalue == 0):
		queue_free()
	pass # Replace with function body.

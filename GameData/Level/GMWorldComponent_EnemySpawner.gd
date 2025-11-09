class_name GMWorldComponent_EnemySpawner
extends Node

@export var EnemyToSpawn:PackedScene
@export var EnemySpawnTransform:Node3D
@export var EnemyTargetDestination:Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_spawn_enemy()

func _spawn_enemy() -> void:
	var enemyInstance:GMBaseEnemy = EnemyToSpawn.instantiate()
	enemyInstance.transform = EnemySpawnTransform.transform
	get_tree().get_root().add_child(enemyInstance)
	enemyInstance.set_movement_target(EnemyTargetDestination.global_position)
	

class_name GMLevelFlow
extends Node3D

@export var EnemiesToSpawn:int =5
@onready var DefensiveObjecive:GMBaseDefensiveObjective = %BaseDefensiveObjective
var _remainingEnemyToSpawn:int = 0
@export var NumberOfAdditionalEnemyPerWave = 2
var _additionalEnemyAccumulator = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DefensiveObjecive.HealthComponent.health_changed.connect(_on_defensiveObjective_healthChanged)
	pass # Replace with function body.

func _on_start_spawning_enemy_wave_timeout() -> void:
	_remainingEnemyToSpawn = EnemiesToSpawn
	_remainingEnemyToSpawn += _additionalEnemyAccumulator
	%DelayBetweenSingleEnemySpawning.start()
	%EnemySpawnerComponent._spawn_enemy()
	_remainingEnemyToSpawn -= 1
	pass # Replace with function body.


func _on_delay_between_single_enemy_spawning_timeout() -> void:
	%EnemySpawnerComponent._spawn_enemy()
	_remainingEnemyToSpawn -= 1
	if (_remainingEnemyToSpawn==0):
		%DelayBetweenSingleEnemySpawning.stop()
		%DelayBetweenWaves.start()
		_additionalEnemyAccumulator+=NumberOfAdditionalEnemyPerWave
	pass # Replace with function body.

func _on_delay_between_waves_timeout() -> void:
	_on_start_spawning_enemy_wave_timeout()
	pass # Replace with function body.
	
func _unhandled_input(event):
	# Replace "ui_accept" with your custom action name if you created one
	if event.is_action_pressed("restart_level"):
		get_tree().reload_current_scene()
		
func _on_defensiveObjective_healthChanged(oldHealth:float, newHealth:float)->void:
	if newHealth==0:
		get_tree().reload_current_scene()
	pass

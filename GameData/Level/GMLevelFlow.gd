extends Node3D

@export var EnemiesToSpawn:int =5

var _remainingEnemyToSpawn:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_spawning_enemy_wave_timeout() -> void:
	_remainingEnemyToSpawn = EnemiesToSpawn
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
	pass # Replace with function body.


func _on_delay_between_waves_timeout() -> void:
	_on_start_spawning_enemy_wave_timeout()
	pass # Replace with function body.

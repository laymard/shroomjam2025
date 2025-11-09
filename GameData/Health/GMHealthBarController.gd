extends Node3D

@export var HealthComponent:GMHealthComponent
@onready var _progressBar:ProgressBar = %ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HealthComponent.health_changed.connect(_onHealthChanged)
	_onHealthChanged(0,HealthComponent._currentHealth)
	pass # Replace with function body.

func _onHealthChanged(oldHealth:float, newHealth:float)->void:
	_progressBar.ratio = newHealth/HealthComponent.GMHealthData.Health
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

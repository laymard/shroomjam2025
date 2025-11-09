class_name GMHealthComponent
extends Node

@export var GMHealthData:GMHealth

signal health_changed(oldValue:float,newvalue:float)

var _currentHealth:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setHealth(GMHealthData.Health)
	pass # Replace with function body.

func _setHealth(newHealth:float) -> void:
	var oldHealth:float = _currentHealth
	_currentHealth = newHealth
	health_changed.emit(oldHealth, _currentHealth)
	
func _applyDamage(amountOfDamage:float, sourceObject)->void:
	var newHealth = clampf(_currentHealth - amountOfDamage, 0, GMHealthData.Health)
	_setHealth(newHealth)
	pass
	

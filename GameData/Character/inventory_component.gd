class_name GMInventoryComponent
extends Node

var _tvCount:int = 0
var _vhsCount:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_tv(tvToAdd:int) -> void:
	_tvCount += tvToAdd
	
func add_vhs(vhsToAdd:int) -> void:
	_vhsCount += vhsToAdd

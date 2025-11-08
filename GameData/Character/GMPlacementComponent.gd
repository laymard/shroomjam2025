class_name GMPlacementComponent
extends Node

@onready
var tvtoPlace = preload("res://GameData/LevelIngredient/CanonTV.tscn")

@onready
var Inventory:GMInventoryComponent = %InventoryComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_first"):
		_tryToPlaceTv()
	pass

func _tryToPlaceTv() -> void:
	if Inventory.get_tv_count() == 0:
		return
	if not %RayCast3D.is_colliding():
		return
	
	var placementPoint:Vector3 = %RayCast3D.get_collision_point()
	var canonToInstantiate: GMCanonTV = tvtoPlace.instantiate()
	canonToInstantiate.global_position = placementPoint
	get_tree().get_root().add_child(canonToInstantiate)
	Inventory.remove_tv(1)
	pass
		

class_name CollectorComponent
extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_collector_shape_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	var parentNodeCollected = area.get_parent_node_3d()
	if parentNodeCollected is GMCanonTV:
		%InventoryComponent.add_tv(1)
		parentNodeCollected.queue_free()
	if parentNodeCollected is GMVHS:
		%InventoryComponent.add_vhs(1)
		queue_free()
	pass

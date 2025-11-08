class_name GMDisplayInventory
extends Label
# Called when the node enters the scene tree for the first time.

@onready
var Player:GMPlayer = %Player

var _inventoryFormat:String = "TV count : %s \n VHS count : %s"

func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var actualstring = _inventoryFormat % [Player.Inventory.get_tv_count(), Player.Inventory.get_vhs_count()]
	text = String(actualstring)
	pass

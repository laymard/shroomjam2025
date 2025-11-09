class_name GMUIShowHelp
extends Control

var _is_showing_help:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PressForHelp.visible = true
	%HelpMessage.visible = false
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("show_help"):
		_switch_help_ui()
	

func _switch_help_ui()->void:
	var isPressForHelpShowed:bool = %PressForHelp.is_visible_in_tree()
	%PressForHelp.visible = not isPressForHelpShowed
	
	var isMessageShowned:bool = %HelpMessage.is_visible_in_tree()
	%HelpMessage.visible = not isMessageShowned
	pass

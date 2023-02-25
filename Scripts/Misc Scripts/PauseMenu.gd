extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	if is_paused:
		Input.set_custom_mouse_cursor(preload("res://Sprites/UI Sprites/menumouse.png"), Input.CURSOR_ARROW, Vector2(16, 16))
	else:
		Input.set_custom_mouse_cursor(null)

func _on_Resume_pressed():
	self.is_paused = false

func _on_Quit_pressed():
	var _temp = get_tree().change_scene("res://Scenes/Main Menu.tscn")

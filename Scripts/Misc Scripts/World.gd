extends Node

var cursor = preload("res://Sprites/UI Sprites/ingamemouse.png")

func _input(event):
	if event is InputEventMouse:
		if get_viewport().get_mouse_position().x >= 0 and get_viewport().get_mouse_position().x <= get_viewport().get_size().x:
			Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))
		else:
			Input.set_custom_mouse_cursor(null)

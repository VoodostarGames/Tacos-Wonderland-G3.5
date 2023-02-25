extends VisibilityNotifier2D


onready var visibility_notifier := get_node("/root/World/Player/VisibilityNotifier2D")

func _ready() -> void:
	var _error_code = visibility_notifier.connect("screen_entered", self, "show")
	_error_code = visibility_notifier.connect("screen_exited", self, "hide")
	visible = false


func _on_VisibilityNotifier2D_screen_entered():
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false

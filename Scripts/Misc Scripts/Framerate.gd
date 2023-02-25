extends ColorRect

func _process(_delta):
	$FPSCounter.text = "FPS : " + str(Engine.get_frames_per_second())

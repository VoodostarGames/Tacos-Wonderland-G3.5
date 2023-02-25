extends ColorRect

func _process(_delta):
	$MemoryCounter.text = str(OS.get_static_memory_usage())

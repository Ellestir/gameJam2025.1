extends Container

func _process(_delta: float) -> void:
	self.global_position = get_global_mouse_position()

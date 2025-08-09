extends HBoxContainer

func _on_mouse_entered() -> void:
	Global.inHandCardContainer = true


func _on_mouse_exited() -> void:
	Global.inHandCardContainer = false

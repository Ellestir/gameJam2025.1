extends HBoxContainer

func _on_mouse_entered() -> void:
	print("entered handCardContainer")
	Global.inHandCardContainer = true


func _on_mouse_exited() -> void:
	print("exited handCardContainer")
	Global.inHandCardContainer = false

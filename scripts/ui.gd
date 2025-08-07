extends CanvasLayer

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if Global.cardSelected:
			var allHandCards = get_tree().get_root().get_node("Main/UI/HandCardContainer").get_child_count()
			for i in allHandCards:
				get_tree().get_root().get_node("Main/UI/HandCardContainer").get_child(i).get_child(0).show()
			get_tree().get_root().get_node("Main/UI/CardHolder").get_child(0).free()
			Global.cardSelected = false
		else:
			if Global.cardHighlighted:
				get_tree().get_root().get_node("Main/UI/HandCardContainer").get_child(Global.hightlightedCardId).pickupCard()

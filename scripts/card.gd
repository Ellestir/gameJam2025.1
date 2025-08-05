extends Container

@onready var card = preload("res://scenes/cardHolder.tscn")
var cardHighlighted = false

func _on_mouse_entered() -> void:
	$AnimationPlayer.play("SelectCard")
	cardHighlighted = true


func _on_mouse_exited() -> void:
	$AnimationPlayer.play("DeselectCard")
	cardHighlighted = false


func _on_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			if cardHighlighted:
				var cardTemp = card.instantiate()
				get_tree().get_root().get_node("Main/UI/CardHolder").add_child(cardTemp)
				Global.cardSelected = true
				self.get_child(0).hide()
		elif event.button_mask == 0:
			if Global.inHandCardContainer:
				print("InHandCardContainer")
				#cardHighlighted = false
				self.get_child(0).show()
				get_tree().get_root().get_node("Main/UI/CardHolder").get_child(0).free()
				Global.cardSelected = false

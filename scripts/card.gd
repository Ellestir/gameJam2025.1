extends Container

@onready var card = preload("res://scenes/cardHolder.tscn")

func _on_mouse_entered() -> void:
	$AnimationPlayer.play("SelectCard")
	Global.cardHighlighted = true
	Global.hightlightedCardId = self.get_index()

func _on_mouse_exited() -> void:
	$AnimationPlayer.play("DeselectCard")
	Global.cardHighlighted = false
	Global.hightlightedCardId = null

func pickupCard() ->void:
	var cardTemp = card.instantiate()
	get_tree().get_root().get_node("Main/UI/CardHolder").add_child(cardTemp)
	Global.cardSelected = true
	self.get_child(0).hide()

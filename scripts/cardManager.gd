extends Node3D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			print("click")
			raycastCheckForCard()
		else:
			print("release")

func raycastCheckForCard() -> void:
	var spaceState = get_world_3d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_viewport().get_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = spaceState.intersect_point(parameters)
	print(result)

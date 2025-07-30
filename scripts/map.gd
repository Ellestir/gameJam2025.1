@tool
extends Node3D

var size := 1.15
var xOffset := sqrt(3.0) * size
var zOffset := (3.0 * size) / 2.0
var gapReductionOffset := xOffset * 0.5

func _ready() -> void:
	generateHexMap(4)

func generateHexMap(radius) -> void:
	for z in radius:
		for x in radius:
			var hex = preload("res://scenes/hexagon.tscn").instantiate()
			add_child(hex)
			if z % 2 == 0:
				hex.global_transform.origin = Vector3(xOffset * x, 0, zOffset * z)
			else:
				hex.global_transform.origin = Vector3(xOffset * x + gapReductionOffset, 0, zOffset * z)

@tool
extends Node3D

var size := 1.15
var zOffset := (3.0 * size) / 2.0
var xOffset := sqrt(3.0) * size
var gapReductionOffset := xOffset * 0.5
var cube_direction_vectors = [
	Vector3(+1, 0, -1), Vector3(+1, -1, 0), Vector3(0, -1, +1), 
	Vector3(-1, 0, +1), Vector3(-1, +1, 0), Vector3(0, +1, -1), 
]

func _ready() -> void:
	generateHexMap(3)

func generateHexMap(radius) -> void:
	var hex = preload("res://scenes/hexagon.tscn").instantiate()
	add_child(hex)
	var center = Vector3(0, 0, 0)
	for z in radius:
		for x in radius:
			hex = preload("res://scenes/hexagon.tscn").instantiate()
			add_child(hex)
			if z % 2 == 0:
				hex.global_transform.origin = Vector3(xOffset * x + gapReductionOffset, 0, zOffset * z)
			else:
				hex.global_transform.origin = Vector3(xOffset * x, 0, zOffset * z)

func cube_direction(direction) -> Vector3:
	return cube_direction_vectors[direction]

func cube_add(hex, vec) -> Vector3:
	return Vector3(hex.x + vec.x, hex.y + vec.y, hex.z + vec.z)

func cube_neighbor(cube, direction) -> Vector3:
	return cube_add(cube, cube_direction(direction))

func cube_scale(hex, factor) -> Vector3:
	return Vector3(hex.x * factor, hex.y * factor, hex.z * factor)

func cube_ring(center, radius) -> void:
	var hexGridPosition = cube_add(center, cube_scale(cube_direction(4), radius))
	for i in 6:
		for j in radius:
			var hex = preload("res://scenes/hexagon.tscn").instantiate()
			add_child(hex)
			hexGridPosition = cube_neighbor(hexGridPosition, i)
			hex.global_transform.origin = Vector3(hexGridPosition.x, 0, )

func cube_spiral(center, radius) -> void:
	for k in range(1,radius):
		cube_ring(center, k)

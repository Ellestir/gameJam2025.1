@tool
extends Node3D

var size := 1.15
var xOffset := (3.0 * size) / 2.0
var zOffset := sqrt(3.0) * size
var gapReductionOffset := xOffset * 0.5
var cubeDirectionVectors = [
	Vector3(+1, 0, -1), Vector3(+1, -1, 0), Vector3(0, -1, +1), 
	Vector3(-1, 0, +1), Vector3(-1, +1, 0), Vector3(0, +1, -1), 
]

func _ready() -> void:
	generateHexMap(10)

func generateHexMap(radius) -> void:
	var hex = preload("res://scenes/hexagon.tscn").instantiate()
	add_child(hex)
	var center = Vector3(0, 0, 0)
	cubeSpiral(center, radius)

func cubeDirection(direction) -> Vector3:
	return cubeDirectionVectors[direction]

func cubeAdd(hex, vec) -> Vector3:
	return Vector3(hex.x + vec.x, hex.y + vec.y, hex.z + vec.z)

func cubeNeighbor(cube, direction) -> Vector3:
	return cubeAdd(cube, cubeDirection(direction))

func cubeScale(hex, factor) -> Vector3:
	return Vector3(hex.x * factor, hex.y * factor, hex.z * factor)

func cubeRing(center, radius) -> void:
	var hexGridPosition = cubeAdd(center, cubeScale(cubeDirection(4), radius))
	for i in 6:
		for j in radius:
			var hex = preload("res://scenes/hexagon.tscn").instantiate()
			add_child(hex)
			hexGridPosition = cubeNeighbor(hexGridPosition, i)
			var doubleHeight = cubeToDoubleheight(hexGridPosition)
			hex.global_transform.origin = Vector3(doubleHeight.x * xOffset, 0, (doubleHeight.y * -1) * (zOffset * 0.5))

func cubeSpiral(center, radius) -> void:
	for k in range(1,radius):
		cubeRing(center, k)

func cubeToDoubleheight(hex) -> Vector2:
	var col = hex.x
	var row = 2 * hex.y + hex.x
	return Vector2(col, row)

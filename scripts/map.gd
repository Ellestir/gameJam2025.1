@tool
extends Node3D

const HEXTILE := preload("res://scenes/hexagon.tscn")
const SIZE := 1.15
const XOFFSET := (3.0 * SIZE) / 2.0
const ZOFFSET := sqrt(3.0) * SIZE
const CUBEDIRECTIONVECTORS = [
	Vector3(+1, 0, -1), Vector3(+1, -1, 0), Vector3(0, -1, +1), 
	Vector3(-1, 0, +1), Vector3(-1, +1, 0), Vector3(0, +1, -1), 
]

func _ready() -> void:
	generateHexMap(10)

func generateHexMap(radius) -> void:
	var hex = HEXTILE.instantiate()
	add_child(hex)
	var center = Vector3(0, 0, 0)
	cubeSpiral(center, radius)

func cubeDirection(direction) -> Vector3:
	return CUBEDIRECTIONVECTORS[direction]

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
			var hex = HEXTILE.instantiate()
			add_child(hex)
			hexGridPosition = cubeNeighbor(hexGridPosition, i)
			var doubleHeight = cubeToDoubleheight(hexGridPosition)
			hex.global_transform.origin = Vector3(doubleHeight.x * XOFFSET, 0, (doubleHeight.y * -1) * (ZOFFSET * 0.5))

func cubeSpiral(center, radius) -> void:
	for k in range(1,radius):
		cubeRing(center, k)

func cubeToDoubleheight(hex) -> Vector2:
	var col = hex.x
	var row = 2 * hex.y + hex.x
	return Vector2(col, row)

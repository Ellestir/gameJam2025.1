extends Camera3D

# How fast the camera moves in meters per second.
@export var speed = 0.25
# How fast the camera pans.
@export var sensitivity = 0.004

var playerInput = Vector3.ZERO
var targetVelocity = Vector3.ZERO

func _physics_process(_delta) -> void:
	# Moving the Character
	position = position + velocity()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _unhandled_input(event: InputEvent) -> void:
	playerInput = Vector3(
		Input.get_axis("moveLeft","moveRight"),
		Input.get_axis("moveDownwards","moveUpwards"),
		Input.get_axis("moveForward","moveBack")
	).normalized()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) and event is InputEventMouseMotion:
		headLook(-event.relative)

func getMoveDirection() -> Vector3:
	return (global_transform.basis * playerInput).normalized()

func velocity() -> Vector3:
	var dir = getMoveDirection()
	return dir * speed

func headLook(motion: Vector2) -> void:
	rotation.x = clamp(rotation.x + motion.y * sensitivity, -PI / 2 , PI / 2)
	rotate_y(motion.x * sensitivity)
	orthonormalize()

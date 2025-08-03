extends Camera3D

# How fast the camera moves in meters per second.
@export var speed = 0.25
# How fast the camera pans.
@export var sensitivity = 0.001

var target_velocity = Vector3.ZERO

func _physics_process(delta) -> void:
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("moveRight"):
		direction.x += 1
	if Input.is_action_pressed("moveLeft"):
		direction.x -= 1
	if Input.is_action_pressed("moveBack"):
		direction.z += 1
	if Input.is_action_pressed("moveForward"):
		direction.z -= 1
	if Input.is_action_pressed("moveUpwards"):
		direction.y += 1
	if Input.is_action_pressed("moveDownwards"):
		direction.y -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		#$Pivot.basis = Basis.looking_at(direction)
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	target_velocity.y = direction.y * speed
	
	# Moving the Character
	position = position + target_velocity

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_headLook(-event.relative)
		
func _headLook(motion: Vector2) -> void:
	rotation.x = clamp(rotation.x + motion.y * sensitivity, -PI / 2 , PI / 2)
	rotate_y(motion.x * sensitivity)
	orthonormalize()

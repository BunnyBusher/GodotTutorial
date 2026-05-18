extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 0
var input_dir : Vector2 = Vector2.ZERO

@export var _camera : XRCamera3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := (_camera.basis * Vector3(input_dir.x, 0, -input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _get_right_axis(axis : Vector2) -> void:
	input_dir = axis

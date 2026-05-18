extends CharacterBody3D

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var _movement : Vector2
var _rotation : Vector2

@export var meter_per_second: float = 2.5
@export var max_velocity: float = 4
@export var angle_rotation: float = 90

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta
	else:
		var forward = -transform.basis.z
		forward.y = 0
		velocity = forward * meter_per_second * _movement.y
		rotate_y(deg_to_rad(_rotation.x * angle_rotation * delta))
	
	velocity = velocity.limit_length(max_velocity)
	
	
	if _movement.length_squared() == 0 and is_on_floor():
		velocity *= 0.33 * delta
		if velocity.length_squared() < 0.01 and is_on_floor():
			velocity = Vector3.ZERO
	
	
	move_and_slide()

func _on_input_manager_on_horizontal_axe(movement: float) -> void:
	_movement.y = movement

func _on_input_manager_on_vertical_axe(movement: float) -> void:
	_rotation.x = -movement
	
func _on_rigth_joystick_value_update(movement: Vector2) -> void:
	_movement = movement
	if movement == Vector2.ZERO:
		return
	print("right ",_movement)
	
func _on_left_joystick_value_update(movement: Vector2) -> void:
	_rotation = -movement
	if movement == Vector2.ZERO:
		return
	print("left ",_rotation)

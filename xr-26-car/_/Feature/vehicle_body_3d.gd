extends VehicleBody3D

@export var turn_torque : float = 60
@export var max_speed : float = 2.5
var right_wheel_intensity : float
var left_wheel_intensity : float


func _physics_process(delta: float) -> void:
	var wheel_result : float  = right_wheel_intensity - left_wheel_intensity
	apply_torque(Vector3.UP * wheel_result * turn_torque)
	
	var velocity = linear_velocity
	var horizontal = Vector3(velocity.x,0,velocity.z)
	
	if horizontal.length() > max_speed:
		horizontal = horizontal.normalized() * max_speed
		linear_velocity.x = horizontal.x
		linear_velocity.z = horizontal.z
	
	
	
func _get_right_wheel_input(value : float) -> void:
	right_wheel_intensity = value
	
func _get_left_wheel_input (value : float) -> void:
	left_wheel_intensity = value
	
func reset_position(trigger : bool) -> void:
	if trigger:
		position = Vector3.ZERO
		rotation = Vector3.ZERO  

extends VehicleBody3D

@export var turn_torque : float = 60
var right_wheel_intensity : float
var left_wheel_intensity : float


func _physics_process(delta: float) -> void:
	var wheel_result : float  = right_wheel_intensity - left_wheel_intensity
	apply_torque(Vector3.UP * wheel_result * turn_torque)
	
func _get_right_wheel_input(value : float) -> void:
	right_wheel_intensity = value
	
func _get_left_wheel_input (value : float) -> void:
	left_wheel_intensity = value

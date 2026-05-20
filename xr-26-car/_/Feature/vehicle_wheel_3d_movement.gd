extends VehicleWheel3D

var _joystick_value : float
@export var _acceleration : float = 2.5
var _grip_intensity : float = 2

func _physics_process(delta: float) -> void:
	engine_force = _joystick_value * _acceleration
	wheel_friction_slip = _grip_intensity
	
	
func get_joystick_value(value : float) -> void:
	_joystick_value = -value
	_grip_intensity = _remap(abs(value),0,1,2,10)
	
	
func _remap (from:float, from_min:float,from_max:float,to_min:float, to_max:float) -> float:
	var value :float = (from - from_min) / (from_max - from_min) * (to_max - to_min) + to_min
	return value

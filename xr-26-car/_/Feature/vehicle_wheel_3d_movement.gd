extends VehicleWheel3D

var _joystick_value : float
@export var _acceleration : float = 2.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	engine_force = _joystick_value * _acceleration
	
func get_joystick_value(value : float) -> void:
	_joystick_value = -value

extends MeshInstance3D


@export var _degree_max_per_second : float = 720
var _joystick_value : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _joystick_value == 0:
		return
	
	#rotation_degrees.x += _joystick_value * (_degree_max_per_second * delta)

func set_joystick_value(value : float) -> void:
	_joystick_value = value

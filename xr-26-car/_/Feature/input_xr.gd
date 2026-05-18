extends Node

@export var left_hand : XRController3D
@export var right_hand : XRController3D

signal on_right_hand_joystick(joystick:Vector2)
signal on_left_hand_joystick(joystick:Vector2)
signal on_x_button_pressed(is_pressed:bool)


func _process(delta: float) -> void:
	var right_joystick : Vector2 = get_right_joystick_2d_value()
	var left_joystick : Vector2 = get_left_joystick_2d_value()
	var x_button : bool = get_a_button_trigger()
	
	on_right_hand_joystick.emit(right_joystick)
	on_left_hand_joystick.emit(left_joystick)
	on_x_button_pressed.emit(x_button)
	
	
func get_right_joystick_2d_value() -> Vector2:
	if not right_hand:
		return Vector2.ZERO
		
	for name in ["primary"]:
		var value = right_hand.get_vector2(name)
		if value.length() > 0.01:
			return value
	return Vector2.ZERO
	
func get_left_joystick_2d_value() -> Vector2:
	if not left_hand:
		return Vector2.ZERO
		
	for name in ["primary"]:
		var value = left_hand.get_vector2(name)
		if value.length() > 0.01:
			return value
	return Vector2.ZERO
	
func get_a_button_trigger() -> bool:
	if not right_hand:
		return false
	
	for name in ["ax_button"]:
		if right_hand.is_button_pressed(name):
			return true
	return false

extends Node

@export var is_enabled: bool = true

@export var key_front: Key = KEY_Z
@export var key_right: Key = KEY_D
@export var key_back: Key = KEY_S
@export var key_left: Key = KEY_Q

signal on_vertical_axe (movement:float)
signal on_horizontal_axe (movement:float)

var pressed_keys: Dictionary = {}


func _ready() -> void:
	
	pressed_keys = {
		key_front: false,
		key_right: false,
		key_back: false,
		key_left: false
	}

func _input(event) -> void:
		if not is_enabled:
			return
		
		if event is InputEventKey:
			if event.keycode in pressed_keys:
				if pressed_keys[event.keycode] != event.pressed:
					pressed_keys[event.keycode] = event.pressed
					_update_booleans_and_emit(event.keycode, event.pressed)
					
func _update_booleans_and_emit(keycode: Key, is_pressed: bool) -> void:
	
	match keycode:
		key_front:
			if is_pressed:
				on_horizontal_axe.emit(-1)
			else:
				on_horizontal_axe.emit(0)
		key_right:
			if is_pressed:
				on_vertical_axe.emit(1)
			else:
				on_vertical_axe.emit(0)
		key_back:
			if is_pressed:
				on_horizontal_axe.emit(1)
			else:
				on_horizontal_axe.emit(0)
		key_left:
			if is_pressed:
				on_vertical_axe.emit(-1)
			else:
				on_vertical_axe.emit(0)

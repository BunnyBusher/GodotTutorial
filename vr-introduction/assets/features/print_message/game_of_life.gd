extends Node

@export var tools_to_display : SSD1306NodeFacadeLite
@export var frequency : float = 1

var current_bool_array : Array[bool]
var next_bool_array : Array[bool]
var chrono : float = 0

const map_size: Vector2i = Vector2i(128,64)
const size: int = map_size.x * map_size.y



func _init() -> void:
	current_bool_array.resize(128*64)
	current_bool_array.fill(false)
	next_bool_array.resize(128*64)
	next_bool_array.fill(false)
	
func _ready() -> void:
	var pos = _get_index_from_2d_coordinates(Vector2i(64,10))
	next_bool_array[pos] = true	
	pos = _get_index_from_2d_coordinates(Vector2i(64,11))
	next_bool_array[pos] = true
	pos = _get_index_from_2d_coordinates(Vector2i(64,12))
	next_bool_array[pos] = true	

func _process(delta: float) -> void:
	chrono += delta
	if chrono >= frequency:
		chrono = 0
		current_bool_array = next_bool_array
		tools_to_display.set_value_with_1d_array_and_draw(current_bool_array)	
	

func _on_ssd_1306_bool_array_to_texture_ready() -> void:
	tools_to_display.set_value_with_1d_array_and_draw(current_bool_array)
	
func _get_index_from_2d_coordinates(coords: Vector2i) -> int :
	var index: int = coords.y * map_size.x + coords.x
	return index
	
func _get_map_position(index : int) -> Vector2i:
	var pos_x: int = index % map_size.x
	var pos_y: int = index / map_size.y
	return Vector2i(pos_x,pos_y)
	
func _process_game_of_life():
	for cell in range(size):
		var cellCoord : Vector2i = Vector2i(0,0)
		cellCoord = _get_map_position(cell)
		
		var aliveNeighbours : int = 0
		var index : int = 0
		var neighboursCoord : Vector2i = cellCoord
		
		for nb in range(8):
			neighboursCoord = cellCoord
			
			match nb:
				0:
					if cellCoord.y == 0 or cellCoord.x == 0:
						continue
					
					neighboursCoord.x -= 1
					neighboursCoord.y -= 1
					index = _get_index_from_2d_coordinates(neighboursCoord)
					if current_bool_array[index] == true:
						aliveNeighbours += 1
				
				1:
					if cellCoord.y == 0:
						continue
					
					neighboursCoord.y -= 1
					index = _get_index_from_2d_coordinates(neighboursCoord)
					if current_bool_array[index] == true:
						aliveNeighbours += 1
				
				2:
					if cellCoord.y == 0 or cellCoord.x == size - 1:
						continue
					
					neighboursCoord.x += 1
					neighboursCoord.y -= 1
					index = _get_index_from_2d_coordinates(neighboursCoord)
					if current_bool_array[index] == true:
						aliveNeighbours += 1
				
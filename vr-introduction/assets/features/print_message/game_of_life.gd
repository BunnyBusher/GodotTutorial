extends Node


signal on_draw(array : Array[bool])

@export var tools_to_display : SSD1306NodeFacadeLite
@export var frequency : float = .25


var current_bool_array : Array[bool]
var next_bool_array : Array[bool]
var chrono : float = 0

const map_size: Vector2i = Vector2i(128,64)
const size: int = map_size.x * map_size.y

const NEIGHBOURS = [
Vector2i(-1, -1),
Vector2i(0, -1),
Vector2i(1, -1),
Vector2i(-1, 0),
Vector2i(1, 0),
Vector2i(-1, 1),
Vector2i(0, 1),
Vector2i(1, 1),
]



func _init() -> void:
	current_bool_array.resize(128*64)
	current_bool_array.fill(false)
	next_bool_array.resize(128*64)
	next_bool_array.fill(false)
	
func _ready() -> void:
	#spawn_glider(32,16)
	#spawn_pulsor(96,16)
	#spawn_pulsor(96,32)
	#spawn_pulsor(96,48)
#
	#spawn_pulsor(32,16)
	#spawn_pulsor(32,32)
	#spawn_pulsor(32,48)
	#randomize_grid(.3)
	
	spawn_eye(-20,-15)
	spawn_eye(36,-15)
	
	
	tools_to_display.set_value_with_1d_array_and_draw(current_bool_array)

func _process(delta: float) -> void:
	chrono += delta
	if chrono >= frequency:
		chrono = 0
		_process_game_of_life()
		current_bool_array = next_bool_array.duplicate()
		next_bool_array.fill(false)
		tools_to_display.set_value_with_1d_array_and_draw(current_bool_array)
		on_draw.emit(current_bool_array)
	

func _on_ssd_1306_bool_array_to_texture_ready() -> void:
	tools_to_display.set_value_with_1d_array_and_draw(current_bool_array)
	
func _get_index_from_2d_coordinates(coords: Vector2i) -> int :
	var index: int = coords.y * map_size.x + coords.x
	return index
	
func _get_map_position(index : int) -> Vector2i:
	var pos_x: int = index % map_size.x
	var pos_y: int = floor(index / map_size.x)
	return Vector2i(pos_x,pos_y)
	
func _process_game_of_life():

	
	for cell in range(size):
		var cellCoord : Vector2i = Vector2i(0,0)
		cellCoord = _get_map_position(cell)
		
		var aliveNeighbours : int = 0
		
		for offset in NEIGHBOURS:
			var n = cellCoord + offset
	
			if n.x < 0 or n.x >= map_size.x:
				continue
		
			if n.y < 0 or n.y >= map_size.y:
				continue
	
			var idx = _get_index_from_2d_coordinates(n)
	
			if current_bool_array[idx]:
				aliveNeighbours += 1
			
			#test rule of life
		if current_bool_array[cell] == true:
				
			#rule 1
			if aliveNeighbours < 2:
				next_bool_array[cell] = false
				
			#rule 2
			elif aliveNeighbours == 2 or aliveNeighbours == 3:
				next_bool_array[cell] = true
				
			#rule 3
			elif aliveNeighbours > 3:
				next_bool_array[cell] = false
			
			#rule 4
		elif current_bool_array[cell] == false and aliveNeighbours == 3:
			next_bool_array[cell] = true

func spawn_glider(x: int, y: int) -> void:
	var coords : Array[Vector2i] = [
		Vector2i(x+1, y),
		Vector2i(x+2, y+1),
		Vector2i(x, y+2),
		Vector2i(x+1, y+2),
		Vector2i(x+2, y+2),
	]
	draw_patterns(coords)

			
func spawn_pulsor_vertical(x: int, y: int)-> void:
	var coords : Array[Vector2i] = [
		Vector2i(x,y-1),
		Vector2i(x,y),
		Vector2i(x,y+1),
	]
	draw_patterns(coords)
	
func spawn_pulsor_horizontal(x: int, y: int)-> void:
	var coords : Array[Vector2i] = [
		Vector2i(x-1,y),
		Vector2i(x,y),
		Vector2i(x+1,y),
	]
	draw_patterns(coords)
	
	
func draw_patterns(coords: Array[Vector2i]) -> void:
		for c in coords:
			if c.x >= 0 and c.x < map_size.x and c.y >= 0 and c.y < map_size.y:
				current_bool_array[_get_index_from_2d_coordinates(c)] = true
				
func randomize_grid(chance_alive: float = 0.25) -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for i in range(size):
		current_bool_array[i] = rng.randf() < chance_alive
		
func spawn_eye(x: int, y: int) -> void:
	# top horizontal
	spawn_pulsor_horizontal(x + 51, y + 29)
	spawn_pulsor_horizontal(x + 57, y + 29)

	# upper vertical cluster
	spawn_pulsor_vertical(x + 48, y + 32)
	spawn_pulsor_vertical(x + 53, y + 32)
	spawn_pulsor_vertical(x + 55, y + 32)
	spawn_pulsor_vertical(x + 60, y + 32)

	# mid horizontal
	spawn_pulsor_horizontal(x + 51, y + 34)
	spawn_pulsor_horizontal(x + 57, y + 34)

	# lower horizontal
	spawn_pulsor_horizontal(x + 51, y + 36)
	spawn_pulsor_horizontal(x + 57, y + 36)

	# lower vertical cluster
	spawn_pulsor_vertical(x + 48, y + 38)
	spawn_pulsor_vertical(x + 53, y + 38)
	spawn_pulsor_vertical(x + 55, y + 38)
	spawn_pulsor_vertical(x + 60, y + 38)

	# bottom horizontal
	spawn_pulsor_horizontal(x + 51, y + 41)
	spawn_pulsor_horizontal(x + 57, y + 41)

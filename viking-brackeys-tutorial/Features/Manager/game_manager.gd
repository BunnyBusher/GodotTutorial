extends Node

var score = 0
@onready var score_int: Label = $scoreInt
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound

func add_point():
	score +=1
	pickup_sound.play()
	score_int.text = str(score)
	print(score)

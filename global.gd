extends Node

var HUMAN  : String
var firstmob = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var who = randi_range(1,4)
	if (who == 1):
		HUMAN =  "Danelle"
	elif (who == 2):
		HUMAN =  "Meghan"
	elif (who == 3):
		HUMAN =  "Sandy"
	elif (who == 4):
		HUMAN =  "Vicki"
	

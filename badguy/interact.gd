extends Control

var mob = null # mob/monster this is connected to

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("interact ready")


func _on_getaway_pressed() -> void:
	if mob:
		mob.leave()


func _on_letin_pressed() -> void:
	if mob:
		mob.enterCar()
	

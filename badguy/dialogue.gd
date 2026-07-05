extends Control

var timeline = {}
var current_node = "start"
var dialogPath
var mob = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_timeline(dialogPath)
	show_node(current_node)


func load_timeline(path):
	var file = FileAccess.open(path, FileAccess.READ)
	timeline = JSON.parse_string(file.get_as_text())
	return timeline

func _on_option_1() -> void:
	if timeline[current_node]["options"][0]["next"] == "getaway":
		mob.leave()
		queue_free()
		return
	if timeline[current_node]["options"][0]["next"] == "letin":
		mob.enterCar()
		queue_free()
		return
	show_node(timeline[current_node]["options"][0]["next"])

func _on_option_2() -> void:
	if timeline[current_node]["options"][1]["next"] == "getaway":
		mob.leave()
		queue_free()
		return
	if timeline[current_node]["options"][1]["next"] == "letin":
		mob.enterCar()
		queue_free()
		return
	show_node(timeline[current_node]["options"][1]["next"])

func show_node(id):
	current_node = id
	var node = timeline[id]
	$box/mobLine.text = node["text"]
	$box/option1.hide()
	$box/option2.hide()
	if node["options"].size() <= 0:
		await get_tree().create_timer(2).timeout
		mob.restartTime()
		queue_free()
	if node["options"].size() > 0:
		$box/option1.text = node["options"][0]["text"]
		$box/option1.show()
	if node["options"].size() > 1:
		$box/option2.text = node["options"][1]["text"]
		$box/option2.show()
		
	
	

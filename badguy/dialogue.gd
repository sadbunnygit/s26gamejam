extends Control

var timeline = {}
var current_node = "start"
var dialogPath = "res://badguy/dialogs/sample.json"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_timeline(dialogPath)
	show_node(current_node)


func load_timeline(path):
	var file = FileAccess.open(path, FileAccess.READ)
	timeline = JSON.parse_string(file.get_as_text())
	return timeline

func _on_option_1() -> void:
	show_node(timeline[current_node]["options"][0]["next"])

func _on_option_2() -> void:
	show_node(timeline[current_node]["options"][2]["next"])

func show_node(id):
	current_node = id
	var node = timeline[id]
	$box/mobLine.text = node["text"]
	if node["options"].size() > 0:
		$box/option1.text = node["options"][0]["text"]
		$box/option1.show()
	else:
		$box/option1.hide()
	if node["options"].size() > 1:
		$box/option2.text = node["options"][1]["text"]
		$box/option2.show()
	else:
		$box/option2.hide()
	

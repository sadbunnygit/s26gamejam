extends PathFollow2D

# for monster spawning
@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_mob()

func spawn_mob():
	print_debug("mob spawned")
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	progress_ratio = 0
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta

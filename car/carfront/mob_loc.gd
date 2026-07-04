extends PathFollow2D

# for monster spawning
@export var mob_scene: PackedScene
var speed = 0.5 # how fast it will travel

func spawn_mob(type : String, s : float = speed):
	print_debug("mob spawned")
	speed = s
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	progress_ratio = 0 # start at the beginning of the path
	# Spawn the mob by adding it to the Main scene.
	mob.type = type
	add_child(mob)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta * speed

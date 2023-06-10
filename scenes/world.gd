extends Node

var segments = [
	preload("res://segments/segmentA.tscn"),
	# preload("res://segments/segmentB.tscn")
]

var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# spawn_inst(0,0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for area in $Areas.get_children():
		area.position.y -= speed * delta
		
func spawn_inst(x,y):
	var inst = segments[randi() % len(segments)].instantiate()
	inst.position = Vector2(x,y)
	$Areas.add_child(inst)

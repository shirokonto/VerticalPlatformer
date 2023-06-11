extends Node

var segments = [
	preload("res://segments/segmentA.tscn"),
	# preload("res://segments/segmentB.tscn")
]

var segment = preload("res://segments/segmentA.tscn")
var width
var speed = 200
var minDistance = 200
var spaceRange = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	width = get_viewport().get_visible_rect().size.x
	randomize()
	var y = 0
	while y > -3000:
		var new_platform = segment.instantiate()
		new_platform.global_position = Vector2(randf_range(-width/2, width/2),y)
		add_child(new_platform)
		y-= randf_range(minDistance, minDistance + spaceRange)
	# randomize()
	# spawn_inst(0,0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for area in $Areas.get_children():
		area.position.y -= speed * delta
		
func spawn_inst(x,y):
	var inst = segments[randi() % len(segments)].instantiate()
	inst.position = Vector2(x,y)
	$Areas.add_child(inst)

extends Node

@onready var player = $Player
@export var PLAYER_PATH : NodePath

var segment = preload("res://segments/segmentA.tscn")
var width
var speed = 200
var minDistance = 200
var spaceRange = 50
var score
var y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	width = get_viewport().get_visible_rect().size.x
	randomize()
	get_tree().paused = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# print("player pos: " + str(player.position))
	for area in $Areas.get_children():
		area.position.y -= speed * delta
	while player.position.y - y < 1000:		
		var new_platform = segment.instantiate()
		new_platform.global_position = Vector2(randf_range(-width/2, width/2),y)
		add_child(new_platform)
		y-= randf_range(50, 210) # modify so x is between a fixed set 
		
func new_game():
	get_tree().call_group("Paddles", "queue_free")
	width = get_viewport().get_visible_rect().size.x
	randomize()

	$HUD.show_message("Get Ready")
	score = 0
	$HUD.update_score(score)
	get_tree().paused = false
	var start_plattfrom = segment.instantiate()
	start_plattfrom.global_position = Vector2($StartPosition.position.x, $StartPosition.position.y + 200)
	start_plattfrom._enableCollision()
	add_child(start_plattfrom)
	y = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()	

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	
func _on_start_timer_timeout():
	$ScoreTimer.start()

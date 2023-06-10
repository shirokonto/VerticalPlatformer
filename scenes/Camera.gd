extends Camera2D

@export var player_path: NodePath
var player
var initial_player_position: Vector2

var maxCameraY: float


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current( )
	player = get_node(player_path)
	
	# initial_player_position = player.global_position	
	maxCameraY = global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_position = player.global_position
	var camera_position = global_position

	# if target_position.y < initial_player_position.y:
	if target_position.y < maxCameraY:
		maxCameraY = target_position.y
		global_position.y = lerp(target_position.y, maxCameraY, 0.1) 

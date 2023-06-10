extends Camera2D

@export var player_path: NodePath
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current( )
	player = get_node(player_path)
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_y = player.get_position_delta().y
	if  player_y < get_position().y:
		set_position(Vector2(0,player_y))
	pass

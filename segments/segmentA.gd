extends StaticBody2D

var time : float
var is_moving : bool
@onready var sprite = get_node("Sprite2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	is_moving = true if (randi_range(1,3) % 2) == 0 else false  # set random platform type 1 static 2 moving
	if is_moving && sprite != null:
		sprite.texture = load("res://art/Sprite-Plattform_Moving.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	if is_moving:
		global_position = Vector2(global_position.x + sin(time) ,global_position.y)
	pass

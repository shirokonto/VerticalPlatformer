extends CharacterBody2D

signal hit

@export var MOVE_SPEED = 200
@export var JUMP_HEIGHT : float
@export var JUMP_TIME_TO_PEEK : float
@export var JUMP_TIME_TO_DESCENT : float
@export var CAMERA_PATH : NodePath

@onready var JUMP_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEEK * JUMP_TIME_TO_PEEK)) * -1.0
@onready var FALL_GRAVITY : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEEK * JUMP_TIME_TO_DESCENT)) * -1.0

var jump_speed = 2000
var camera
var width

func _ready():	
	velocity = Vector2.ZERO
	camera = get_node(CAMERA_PATH)
	width = get_viewport_rect().size.x
	get_tree().paused = true
	
func start(pos):
	camera.global_position = pos
	show()
	print("start camera.global_position: " + str(camera.global_position))

	print("after camera.global_position: " + str(camera.global_position))
	print("start player position: " + str(position))
	position = pos
	print("after player position: " + str(position))
	$Area2D/CollisionShape2D.disabled = false

func _physics_process(delta):
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * MOVE_SPEED	
	move_and_slide()

func get_gravity() -> float:
	return JUMP_GRAVITY if velocity.y < 0.0 else FALL_GRAVITY

func get_input_velocity() -> float:
	var horizontal:= 0.0	
	if Input.is_action_pressed("move_left"):
		horizontal -= 1.0
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0
	return horizontal
	
func _on_collision(body):
	if body.is_in_group('Paddles') and get_real_velocity().y > 0:
		set_velocity(Vector2(0, -jump_speed))

func _on_exit_screen():
	if global_position.x > camera.global_position.x and velocity.x > 0:
		set_position(Vector2(-width/2, global_position.y))
	if global_position.x < camera.global_position.x and velocity.x < 0:
		set_position(Vector2(width/2, global_position.y))
	
	if position.y > camera.global_position.y + get_viewport_rect().size.y/2:
		print("dead")
		print("death position: " + str(position))
		print("###########")
		#hide()	
		hit.emit()
		#$Area2D/CollisionShape2D.set_deferred("disabled", true)

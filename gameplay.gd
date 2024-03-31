class_name Gameplay extends Node2D

@onready var head = %WormHead as WormHead

var time_between_moves: float = 1000.0
var time_since_last_move: float = 0
var speed: float = 1000.0

var move_direction: Vector2 = Vector2.RIGHT


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		move_direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		move_direction = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_left"):
		move_direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		move_direction = Vector2.RIGHT	

func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		update_worm()
		time_since_last_move = 0

func update_worm():
	var new_position:Vector2 = head.position + move_direction * Global.GRID_SIZE
	head.move_to(new_position)
	

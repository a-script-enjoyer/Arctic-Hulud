class_name Gameplay extends Node2D

const gameover_scene: PackedScene = preload("res://menus/game_over.tscn")
var gameover_menu: GameOver
const pause_scene: PackedScene = preload("res://menus/pause_menu.tscn")
var pause_menu: PauseMenu

@onready var head = %WormHead as WormHead
@onready var map_bounds = %MapBounds as MapBounds
@onready var spawner: Spawner = %Spawner as Spawner
@onready var hud = %HUD

var time_between_moves: float = 1000.0
var time_since_last_move: float = 0
var speed: float = 4000.0
var move_direction: Vector2 = Vector2.RIGHT
var new_move_direction: Vector2 = Vector2.ZERO
var snake_parts:Array[SnakePart] = []
var is_only_head: bool = true

var score: int:
	get:
		return score
	set(value):
		score = value
		hud.update_score(value)

func _ready():
	snake_parts.push_back(head)
	head.food_eaten.connect(_on_food_eaten)
	time_since_last_move = time_between_moves
	head.body_collision.connect(_on_body_collided)
	spawner.spawn_food()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		new_move_direction = Vector2.UP
		if is_only_head:
			move_direction = new_move_direction
		elif move_direction != Vector2.DOWN:
			move_direction = new_move_direction
	elif Input.is_action_just_pressed("ui_down"):
		new_move_direction = Vector2.DOWN
		if is_only_head:
			move_direction = new_move_direction
		elif move_direction != Vector2.UP:
			move_direction = new_move_direction
	elif Input.is_action_just_pressed("ui_left"):
		new_move_direction = Vector2.LEFT
		if is_only_head:
			move_direction = new_move_direction
		elif move_direction != Vector2.RIGHT:
			move_direction = new_move_direction
	elif Input.is_action_just_pressed("ui_right"):
		new_move_direction = Vector2.RIGHT
		if is_only_head:
			move_direction = new_move_direction
		elif move_direction != Vector2.LEFT:
			move_direction = new_move_direction

	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		update_worm()
		time_since_last_move = 0

func update_worm():
	var new_position:Vector2 = head.position + move_direction * Global.GRID_SIZE
	new_position = map_bounds.wrap_vector(new_position)
	head.move_to(new_position)
	for i in range(1, snake_parts.size(),1):
		snake_parts[i].move_to(snake_parts[i-1].last_position)
	
func _on_food_eaten():
	is_only_head = false
	spawner.call_deferred("spawn_food")
	snake_parts.append(spawner.spawn_tail(
						snake_parts[snake_parts.size()-1].last_position))
	speed += 500
	score += 1
	
						
func _on_body_collided():
	if not gameover_menu:
		gameover_menu = gameover_scene.instantiate() as GameOver
		add_child(gameover_menu)
		gameover_menu.set_score(score)
								
func pause_game():
	pause_menu = pause_scene.instantiate() as PauseMenu
	add_child(pause_menu)
	pause_menu.set_score(score)

func _notification(what):
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		pause_game()

class_name Gameplay extends Node2D

signal speed_changed

const gameover_scene: PackedScene = preload("res://menus/game_over.tscn")
var gameover_menu: GameOver
const pause_scene: PackedScene = preload("res://menus/pause_menu.tscn")
var pause_menu: PauseMenu

@onready var head: WormHead = %WormHead as WormHead
@onready var map_bounds = %MapBounds as MapBounds
@onready var spawner: Spawner = %Spawner as Spawner
@onready var hud = %HUD
@onready var desert_bells: AudioStreamPlayer = %DesertBells
@onready var timer: Timer = %Timer
@onready var rumble = %DivingSound
@onready var spawn_sound = %SpawnSound
@onready var moving_sound = %MovingSound
@onready var animate_snake_part = %AnimateSnakePart

var time_between_moves: float = 1000.0
var time_since_last_move: float = 0
var speed: float = 5000.0
var move_direction: Vector2 = Vector2.RIGHT
var new_move_direction: Vector2 = Vector2.ZERO
var snake_parts:Array[SnakePart] = []
var is_only_head: bool = true
var snake_direction: Vector2 = Vector2.ZERO
var dive_tracker: int = 1
var snake_is_diving: bool = false
var dive_segment_length: int = 10
var has_moving_started: bool = false
var is_moving_sound_locked: bool = false

var score: int:
	get:
		return score
	set(value):
		score = value
		hud.update_score(value)

func _ready():
	moving_sound.finished.connect(_on_moving_sound_finished)
	spawn_sound.play()
	desert_bells.play()
	snake_parts.push_back(head)
	desert_bells.finished.connect(_on_desert_bells_finished)
	head.food_eaten.connect(_on_food_eaten)
	time_since_last_move = time_between_moves
	head.body_collision.connect(_on_body_collided)
	spawner.spawn_food()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		has_moving_started = true
		new_move_direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		has_moving_started = true
		new_move_direction = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_left"):
		has_moving_started = true
		new_move_direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		has_moving_started = true
		new_move_direction = Vector2.RIGHT
	move_direction = new_move_direction
	
	if Input.is_action_just_pressed("ui_accept"):
		if not snake_is_diving:
			rumble.play()
			snake_is_diving = true
			head.dive()
		
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
	
func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		update_worm(time_between_moves)
		time_since_last_move = 0

func update_worm(delta):
	if has_moving_started and not is_moving_sound_locked:
		moving_sound.play()
		is_moving_sound_locked = true
	if not is_only_head:
		if snake_direction * -1 == move_direction:
			move_direction *= -1
	var new_position:Vector2 = head.position + move_direction * Global.GRID_SIZE
	new_position = map_bounds.wrap_vector(new_position)
	head.move_to(new_position, move_direction)
	head.shift_underground()
	
	if snake_is_diving == true:
		head.move_underground_head(head.is_diving)
		dive_tracker += 1
	if is_only_head and dive_tracker > dive_segment_length:
		dive_tracker = 1
	elif dive_tracker > dive_segment_length:
		dive_tracker = 1
	
	for i in range(1, snake_parts.size(),1):
		snake_parts[i].move_to(snake_parts[i-1].last_position, move_direction)
		snake_parts[i].move_underground(snake_parts[i-1].last_underground_state)
		snake_parts[i].shift_underground()

	print(dive_tracker)
	head.resurface(dive_tracker, dive_segment_length)
	if head.is_diving == false:
		dive_tracker = 1
	snake_is_diving = check_if_part_worm_underground()
	# TODO: Add rotation to sprite
	snake_direction = move_direction

func check_if_part_worm_underground():
	for i in range(snake_parts.size()):
		if snake_parts[i].is_underground == true:
			return true
	rumble.stop()
	return false

func _on_food_eaten():
	is_only_head = false
	spawner.call_deferred("spawn_food")
	snake_parts.append(spawner.spawn_tail(
						snake_parts[snake_parts.size()-1].last_position,
						snake_parts[snake_parts.size()-1].last_underground_state))
	speed += 500
	score += 1
	speed_changed.emit()
	
						
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
		
func _on_desert_bells_finished():
	timer.start()
	timer.wait_time = 5.0
	desert_bells.play()
			
func _on_music_playing(music):
	music.play()
	
func _on_moving_sound_finished():
	var moving_loop_activated: bool = false
	if not moving_loop_activated:
		speed_changed.connect(_quicken_moving_sound_raw)
	moving_loop_activated = true
	moving_sound.play()
	
func _quicken_moving_sound_raw():
	moving_sound.pitch_scale = (1 + speed/30000) 

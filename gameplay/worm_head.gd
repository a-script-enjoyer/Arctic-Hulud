class_name WormHead extends SnakePart

signal food_eaten
signal body_collision
signal death_finished
signal stop_movement

@export var sprite_frames: SpriteFrames

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var collision_shape_2d = %CollisionShape2D
@onready var part_animator = %PartAnimator

var texture_memo: Texture
var chomp_count: int = 0
var is_diving: bool = true

func _ready():
	$AnimatedSprite2D.frames = sprite_frames
	$AnimatedSprite2D.play("idle")
	connect("death_finished", _on_death_finished)
	z_index = 100

func chomp():
	# Personal flair condition, not tutorial
	if chomp_count == 0:
		print("om")
		chomp_count += 1
	else:
		print("nom")
		chomp_count += 1
		if chomp_count == 4:
			chomp_count = 0

func dive():
	$DiggingAnim.visible = true
	$DiggingAnim.play("dive")
	is_diving = true

func resurface(dive_tracker, dive_segment_length):
	if dive_tracker % dive_segment_length - 1 == 0:
		$DiggingAnim.visible = false
		$DiggingAnim.stop()
		is_underground = false
		last_underground_state = false
		is_diving = false
		
func move_underground_head(will_be_underground):
	last_underground_state = is_underground
	is_underground = will_be_underground
		
func death():
	$AnimatedSprite2D.play("death")
	emit_signal("stop_movement")
	DeathScream.play_sound()
	await get_tree().create_timer(1.3).timeout
	emit_signal("death_finished")
	print("Game Over!")
	
func _on_death_finished():
	body_collision.emit()


func _on_area_entered(area):
	if area.is_in_group("Food"):
		chomp()
		#Call deferred calls a function after the end of the physics cycle
		food_eaten.emit()
		area.call_deferred("queue_free")
		# TODO: call head animation
	elif area.is_in_group("Body"):
		death()
	else:
		pass

func shift_underground():
	if is_underground == true:
		collision_layer = 2
		collision_mask = 2
		sprite_2d.modulate = "ffffffab"
		sprite_2d.scale.x = -0.060
		sprite_2d.scale.y = -0.060
	else:
		collision_layer = 1
		collision_mask = 1
		sprite_2d.modulate = "ffffff"
		sprite_2d.scale.x = 0.04
		sprite_2d.scale.y = 0.04

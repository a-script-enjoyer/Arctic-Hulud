class_name WormHead extends SnakePart

signal food_eaten
signal body_collision

@export var textures: Array[Texture]

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var collision_shape_2d = %CollisionShape2D
@onready var part_animator = %PartAnimator

var texture_memo: Texture
var chomp_count: int = 0
var is_diving: bool = true

func _ready():
	sprite_2d.texture = textures[0]
	texture_memo = sprite_2d.texture

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
	is_diving = true

func resurface(dive_tracker, dive_segment_length):
	if dive_tracker % dive_segment_length - 1 == 0:
		is_underground = false
		last_underground_state = false
		is_diving = false
		
func move_underground_head(will_be_underground):
	last_underground_state = is_underground
	is_underground = will_be_underground
		
		
func death():
	print("Game Over!")

func _on_area_entered(area):
	if area.is_in_group("Food"):
		chomp()
		#Call deferred calls a function after the end of the physics cycle
		food_eaten.emit()
		area.call_deferred("queue_free")
		# TODO: call head animation
	elif area.is_in_group("Body"):
		death()
		body_collision.emit()
	else:
		pass

func shift_underground():
	if is_underground == true:
		sprite_2d.texture = textures[1]
		sprite_2d.modulate = "ffffffab"
		sprite_2d.scale.x = -0.060
		sprite_2d.scale.y = -0.060
		collision_shape_2d.disabled = true
	else:
		sprite_2d.texture = textures[0]
		sprite_2d.modulate = "ffffff"
		sprite_2d.scale.x = 0.04
		sprite_2d.scale.y = 0.04
		collision_shape_2d.disabled = false

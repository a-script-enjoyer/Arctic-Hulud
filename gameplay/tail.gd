class_name Tail extends SnakePart

@export var textures: Array[Texture]

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d = %CollisionShape2D

var texture_memo

func _ready():
	$DiggingAnimTail.visible = false
	sprite_2d.texture = textures.slice(0, 6).pick_random()
	texture_memo = sprite_2d.texture
	z_index = 100
	
func extend_snake(new_position: Vector2, new_underground_state: bool):
	self.position = new_position
	last_underground_state = new_underground_state

func shift_underground():
	if is_underground == true:
		sprite_2d.visible = false
		collision_layer = 2
		collision_mask = 2
		$DiggingAnimTail.global_position = sprite_2d.global_position
		$DiggingAnimTail.visible = true
		$DiggingAnimTail.play("dive_body")
	else:
		sprite_2d.visible = true
		sprite_2d.texture = texture_memo
		collision_layer = 1
		collision_mask = 1
		$DiggingAnimTail.visible = false
		$DiggingAnimTail.stop()

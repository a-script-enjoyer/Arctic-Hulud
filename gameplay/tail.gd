class_name Tail extends SnakePart

@export var textures: Array[Texture]

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d = %CollisionShape2D

var texture_memo

func _ready():
	sprite_2d.texture = textures.slice(0, 6).pick_random()
	texture_memo = sprite_2d.texture
	
func extend_snake(new_position: Vector2, new_underground_state: bool):
	self.position = new_position
	last_underground_state = new_underground_state

func shift_underground():
	if is_underground == true:
		sprite_2d.texture = textures[6]
		sprite_2d.modulate.a = 0.9
		sprite_2d.scale.x = 1.2
		sprite_2d.scale.y = 1.2
		collision_shape_2d.disabled = true
	else:
		sprite_2d.texture = texture_memo
		sprite_2d.modulate.a = 1
		sprite_2d.scale.x = 1
		sprite_2d.scale.y = 1
		collision_shape_2d.disabled = false

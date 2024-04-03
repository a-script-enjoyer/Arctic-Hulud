class_name Tail extends SnakePart

@export var textures: Array[Texture]

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	sprite_2d.texture = textures.pick_random()

func extend_snake(new_position: Vector2):
	self.position = new_position

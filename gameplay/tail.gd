class_name Tail extends SnakePart

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d = %CollisionShape2D

var texture_memo
var invulnerable: bool = false

func _ready():
	randomize()
	$DiggingAnimTail.visible = false
	var cell_size = 51.5
	var random_row = randi() % 4
	var random_col = randi() % 4
	sprite_2d.region_rect = Rect2(random_col * cell_size, random_row * cell_size, cell_size, cell_size)
	
	var scale_y_rand = randi_range(-5, 0)
	
	sprite_2d.position.x = sprite_2d.position.x + 48
	sprite_2d.scale.x = sprite_2d.scale.x * 1.5
	sprite_2d.scale.y = sprite_2d.scale.y + scale_y_rand
	z_index = 100
	
func extend_snake(spawn_position: Vector2, spawn_underground_state: bool, spawn_rotation: float):
	self.position = spawn_position
	self.rotation = spawn_rotation
	last_underground_state = spawn_underground_state

func shift_underground():
	if invulnerable:
		sprite_2d.visible = false
		collision_layer = 2
		collision_mask = 2
		$DiggingAnimTail.global_position = sprite_2d.global_position
		$DiggingAnimTail.visible = true
		$DiggingAnimTail.play("dive_body")
	else:
		if is_underground == true:
			sprite_2d.visible = false
			collision_layer = 2
			collision_mask = 2
			$DiggingAnimTail.global_position = sprite_2d.global_position
			$DiggingAnimTail.visible = true
			$DiggingAnimTail.play("dive_body")
		else:
			sprite_2d.visible = true
			collision_layer = 1
			collision_mask = 1
			$DiggingAnimTail.visible = false
			$DiggingAnimTail.stop()

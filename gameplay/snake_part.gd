class_name SnakePart extends Area2D


var interpolated_position: Vector2
var is_underground: bool = false
var will_be_underground: bool = false
var last_underground_state: bool = false

var current_hidden_head_rotation: float = 0

var last_position: Vector2
var last_rotation: float

func move_to(new_position:Vector2, new_rotation: float, is_head: bool = true):
	last_position = self.position
	self.position = new_position
	if is_head:
		current_hidden_head_rotation = new_rotation
	else:
		last_rotation = self.rotation
		self.rotation = new_rotation

		
func move_underground(new_underground_state: bool):
	last_underground_state = is_underground
	is_underground = new_underground_state

class_name SnakePart extends Area2D

var last_position: Vector2
var interpolated_position: Vector2
var is_underground: bool = false
var will_be_underground: bool = false
var last_underground_state: bool = false

func move_to(new_position:Vector2, move_direction: Vector2):
	last_position = self.position
	self.position = new_position
	rotate_model(move_direction)
	
func rotate_model(move_direction: Vector2):
	if move_direction == Vector2.ZERO:
		return
	if move_direction.y == 0:
		if move_direction.x == 1:
			self.rotation_degrees = 90
		elif move_direction.x == -1:
			self.rotation_degrees = -90
	else:
		if move_direction.y == -1:
			self.rotation_degrees = 0
		elif move_direction.y == 1:
			self.rotation_degrees = 180
		
func move_underground(new_underground_state: bool):
	last_underground_state = is_underground
	is_underground = new_underground_state

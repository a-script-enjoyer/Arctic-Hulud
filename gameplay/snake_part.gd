class_name SnakePart extends Area2D

signal resurface_head
var last_position: Vector2
var is_underground: bool = false
var will_be_underground: bool = false
var last_underground_state: bool = false


func move_to(new_position:Vector2):
	last_position = self.position
	self.position = new_position

func move_underground(new_underground_state: bool):
	last_underground_state = is_underground
	is_underground = new_underground_state

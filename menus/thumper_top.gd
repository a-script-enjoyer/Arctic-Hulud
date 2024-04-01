# TODO: Delete this file

class_name Thumper extends Sprite2D

var starting_position = self.position

func move_thumper(step):
	self.position += Vector2.DOWN
	
	
func reset_thumper():
	self.position = starting_position

class_name MapBounds extends Node2D

@onready var upper_left = %UpperLeft
@onready var lower_right = %LowerRight

var x_max: float
var x_min: float
var y_max: float
var y_min: float

func _ready():
	x_max = lower_right.position.x
	x_min = upper_left.position.x
	y_max = lower_right.position.y
	y_min = upper_left.position.y

func wrap_vector(vector:Vector2) -> Vector2:
	# Global reference addition/multiplication is needed
	# If no simple arithmetic, the parts spawn at the border causing alternation
	# Curiously, if you do want to spawn something on the border you would get
	# alternation if you have >= (non-strict relation). I.e. it would spawn
	# on one tick on the opposite side and on the next tick on the entering side
	# (if you input a perpendicular change of direction). If for some reason want
	# to be able to walk the border on wrap, you should add a strict comparison
	# ('>' instead of '>=') but that would mean you would never escape the
	# shifted grid.
	if vector.x > x_max:
		return Vector2(x_min + Global.GRID_SIZE/2, vector.y)
	elif vector.x < x_min:
		return Vector2(x_max - Global.GRID_SIZE/2, vector.y)
	elif vector.y > y_max:
		return Vector2(vector.x, y_min + Global.GRID_SIZE/2)
	elif vector.y < y_min:
		return Vector2(vector.x, y_max - Global.GRID_SIZE/2)
	return vector

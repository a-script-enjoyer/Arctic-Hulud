class_name MapBounds extends Node2D

@onready var upper_left = %UpperLeft
@onready var lower_right = %LowerRight

var x_max: float
var x_min: float
var y_max: float
var y_min: float

# TODO: Bounds are displacing worm before first food
# FIXME: This leads to an immortality bug

func _ready():
	x_max = lower_right.position.x
	x_min = upper_left.position.x
	y_max = lower_right.position.y
	y_min = upper_left.position.y

func wrap_vector(vector:Vector2) -> Vector2:
	if vector.x >= x_max:
		return Vector2(x_min, vector.y)
	elif vector.x <= x_min:
		return Vector2(x_max, vector.y)
	elif vector.y >= y_max:
		return Vector2(vector.x, y_min)
	elif vector.y <= y_min:
		return Vector2(vector.x, y_max)
	return vector

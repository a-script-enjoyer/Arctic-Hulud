class_name Spawner extends Node2D

# signals

@export var map_bounds: MapBounds

var food_scene:PackedScene = preload("res://gameplay/food.tscn")

func spawn_food():
	var location:Vector2 = Vector2.ZERO
	location.x = randf_range(map_bounds.x_min + Global.GRID_SIZE,
							map_bounds.x_max - Global.GRID_SIZE)
	location.y = randf_range(map_bounds.y_min + Global.GRID_SIZE,
							map_bounds.y_max - Global.GRID_SIZE)

	var food = food_scene.instantiate()
	food.position = location
	
	get_node(".").add_child(food)

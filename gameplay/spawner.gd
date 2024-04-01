class_name Spawner extends Node2D

@export var map_bounds: MapBounds

var food_scene: PackedScene = preload("res://gameplay/food.tscn")
var tail_scene: PackedScene = preload("res://gameplay/tail.tscn")

func spawn_food():
	var location:Vector2 = Vector2.ZERO
	location.x = randf_range(map_bounds.x_min + Global.GRID_SIZE,
							map_bounds.x_max - Global.GRID_SIZE)
	location.y = randf_range(map_bounds.y_min + Global.GRID_SIZE,
							map_bounds.y_max - Global.GRID_SIZE)
							
# Code below centers my spawnpoint within a grid tile
	location.x = floorf(location.x / Global.GRID_SIZE) * Global.GRID_SIZE
	location.y = floorf(location.y / Global.GRID_SIZE) * Global.GRID_SIZE

	var food = food_scene.instantiate()
	food.position = location
	
	get_node(".").add_child(food)
	
func spawn_tail(pos: Vector2):
	var tail:Tail = tail_scene.instantiate() as Tail
	tail.extend_snake(pos)

	get_node(".").call_deferred("add_child", tail)
	return tail

extends Area2D

@export var foods: Array[AnimatedSprite2D]

func _ready():
	for food in foods:
		food.visible = false
		food.play()
		food.z_index = 100
	var spawned_sprite: AnimatedSprite2D
	var random_chance = randi_range(0,20)
	if random_chance == 0:
		foods[0].visible = true
		add_to_group("PowerUp")
	else:
		foods[1].visible = true

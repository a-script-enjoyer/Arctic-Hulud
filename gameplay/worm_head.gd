class_name WormHead extends SnakePart

signal food_eaten
signal body_collision

var chomp_count: int = 0

func chomp():
	# Personal flair condition, not tutorial
	if chomp_count == 0:
		print("om")
		chomp_count += 1
	else:
		print("nom")
		chomp_count += 1
		if chomp_count == 4:
			chomp_count = 0
			
func death():
	print("Game Over!")

func _on_area_entered(area):
	if area.is_in_group("Food"):
		chomp()
		#Call deferred calls a function after the end of the physics cycle
		food_eaten.emit()
		area.call_deferred("queue_free")
		# TODO: call head animation
	elif area.is_in_group("Body"):
		death()
		body_collision.emit()
	else:
		pass
		

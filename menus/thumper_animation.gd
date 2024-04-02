class_name ThumperAnimation extends AnimationPlayer

@onready var thumper_sound: AudioStreamPlayer = %ThumperSound

#func _ready():
	#thumper_sound.finished.connect(_on_loop_sound)
	#thumper_sound.play()
	#
#func _on_loop_sound(player: AudioStreamPlayer):
	#thumper_sound.stream_paused = false
	#thumper_sound.play()

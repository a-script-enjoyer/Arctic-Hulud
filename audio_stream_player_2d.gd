extends AudioStreamPlayer2D

signal sound_finished

var sound = load("res://menus/sounds/dune-woman-2.mp3")  # Loads as AudioStream resource

func _ready():
	finished.connect(_on_audio_finished)

func play_sound():
	stream = sound
	play()

func _on_audio_finished():
	emit_signal("sound_finished")

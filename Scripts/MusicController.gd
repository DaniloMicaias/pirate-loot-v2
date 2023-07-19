extends Node2D



func _ready():
	pass


func play_menu_music():
	$bgMusic.play()

func stop_menu_music():
	$bgMusic.stop()
	
func play_level1_music():
	$level1Music.play()

func stop_level1_music():
	$level1Music.stop()


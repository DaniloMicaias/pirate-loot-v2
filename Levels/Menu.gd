extends Control

func _ready():
	$Controls/start.grab_focus()
	MusicController.play_menu_music()
	MusicController.stop_level1_music()

func _on_start_pressed():
	get_tree().change_scene("res://Levels/Level_01.tscn")
	MusicController.stop_menu_music()
	MusicController.play_level1_music()


func _on_controls_pressed():
	get_tree().change_scene("res://Scenes/controlsScreen.tscn")

func _on_quit_pressed():
	get_tree().quit()

extends Area2D

onready var changer = get_parent().get_node("Transition_in")

export var path : String

func _ready():
	$goal2.play("idle")
	

func _on_goal2_body_entered(body):
	if body.name == "Player":
		$goal2.play("collected")
		changer.change_scene(path)
		MusicController.stop_level2_music()
		MusicController.play_level3_music()


extends Area2D

#onready var changer = get_parent().get_node("Transition_in")

#export var path : String

func _ready():
	$chest.play("idle")

func _on_chest_body_entered(body):
	if body.name == "Player":
		var victoryScreen = load("res://Scenes/VictoryScreen.tscn").instance()
		$chest.play("unlocked")
		get_tree().current_scene.add_child(victoryScreen)

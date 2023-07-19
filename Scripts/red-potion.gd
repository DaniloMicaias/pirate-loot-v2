extends Area2D

var potion = 1
var player_health = 0

signal change_life(player_health)
	
func _ready():
	$redpotion.play("idle")
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/holder"), "on_change_life")
	
	
func _on_items_body_entered(body):	
	
	if(Global.player_health < 3):
		Global.player_health += 1
		
	player_health = Global.player_health
	emit_signal("change_life", player_health)
	print("More = %d" %Global.player_health)
#sinal com a barra de vida
	emit_signal("change_life", player_health)
	
	$drinkAudio.play()
	$redpotion.play("collected")
	Global.potion += potion
	
func _on_redpotion_animation_finished():
	if $redpotion.animation == "collected":
		queue_free()

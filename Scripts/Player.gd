extends KinematicBody2D

var motion = Vector2.ZERO
var direcao = Vector2(0,0)
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded
onready var raycasts = $raycasts

var player_health = 3
var max_health = 3

var hurted = false
var knockback_dir = 1
var knockback_int = 500

signal change_life(player_health)

func _ready() -> void:	
#conecao com a barra de vida
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/holder"), "on_change_life")
	
	Global.player_health = max_health
	print("Less = %d" %Global.player_health)
	emit_signal("change_life", max_health)
	
	

#Funcao principal para movimentacao
func _physics_process(delta: float) -> void:
	motion.y += gravity * delta
	motion.x = 0
	if !hurted:
		_get_input() 
	
	motion = move_and_slide(motion)
	
	is_grounded = _check_is_ground()
	
	_set_animation()

#funcao para andar e controlar a direcao
func _get_input():
	motion.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	motion.x = lerp(motion.x, move_speed * move_direction, 0.2)
	direcao.x = Input.get_axis("move_left", "move_right")
	
	if move_direction !=0:
		$AnimatedSprite.scale.x = move_direction
		knockback_dir = move_direction

#funcao para pular  
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && is_grounded:
		motion.y = jump_force / 2

#funcao para verificar se o player esta no chao (Evitar o pulo eterno)
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

#Funcao para controlar as animacoes
func _set_animation():
	if direcao.x == 0:
		$AnimatedSprite.play("idle")
	elif direcao.x != 0 :
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("jump")
	
	if hurted:
		$AnimatedSprite.play("hit")
		
	if motion.y > 0 and !is_grounded:
		$AnimatedSprite.play("fall")

func knockback():
	motion.x = -knockback_dir*knockback_int
	motion = move_and_slide(motion)

func _on_hurtbox_body_entered(body):
	player_health -= 1
	Global.player_health -= 1
	hurted = true
	emit_signal("change_life", player_health)
	knockback()
	get_node("hurtbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("hurtbox/collision").set_deferred("disabled", false)
	hurted = false
	if player_health < 1:
		queue_free()
		get_tree().reload_current_scene()

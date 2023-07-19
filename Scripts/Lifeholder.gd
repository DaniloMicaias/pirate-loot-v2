extends Control

var life_size = 32
	

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func on_change_life(player_health):
	#$redlife.show();
	#$redlife2.show();
	#$redlife3.show();
	if player_health == 3:
		$redlife.show();
		$redlife2.show();
		$redlife3.show();
	elif player_health == 2:
		$redlife.hide();
		$redlife2.show();
		$redlife3.show();
	elif player_health == 1:
		$redlife.hide();
		$redlife2.hide();
		$redlife3.show();
	elif player_health == 0:
		$redlife.hide();
		$redlife2.hide();
		$redlife3.hide();

#$live.rect_size.x = player_health * life_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

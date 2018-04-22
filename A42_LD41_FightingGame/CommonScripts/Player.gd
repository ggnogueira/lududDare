extends KinematicBody2D

signal allow_move
var actions = []

func _ready():
	connect("allow_move", get_parent(), "reset_move_array")
	pass
	
func set_player_queue(queue):
	actions = queue
	move_player(actions)

func move_player(actions):
	if actions.empty():
		emit_signal("allow_move")
		return
	match actions.front():
		"D":
			$Tween.interpolate_property(self, "position", position, position + Vector2(10,0), 0.4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.2)
			$Tween.start()
		"A":
			$Tween.interpolate_property(self, "position", position, position - Vector2(10,0), 0.4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.2)
			$Tween.start()
		"Y":
			$AnimationPlayer.play("attack_high")
		_:
			print("Ação ainda não programada")
	actions.pop_front()

func _on_Tween_completed(object, key):
	move_player(actions)
	
func _on_AnimationPlayer_finished(anim_name):
	move_player(actions)

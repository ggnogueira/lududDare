extends KinematicBody2D

export (int) var fwd_movement = 20
export (int) var bwd_movement = 10

signal allow_move
signal player_deal_damage

var opponent = null

func _ready():
	connect("allow_move", get_parent(), "reset_move_array")
	connect("player_deal_damage", get_parent().get_node("Enemy"), "damage_routine")
	opponent = get_parent().get_node("Enemy")

func move_player(action):
	if action == null:
		return
	match action:
		"D":
			$Tween.interpolate_property(self, "position", position, position + Vector2(fwd_movement,0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2)
			$Tween.start()
		"A":
			$Tween.interpolate_property(self, "position", position, position - Vector2(bwd_movement,0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2)
			$Tween.start()
		"J":
			$AnimationPlayer.play("attack")
		"K":
			$AnimationPlayer.play("defense")
		_:
			print("Ação ainda não programada")
	action = null
	if self.position.x > opponent.position.x:
		if self.scale.x > 0:
			var aux = fwd_movement
			fwd_movement = bwd_movement
			bwd_movement = aux
		self.scale.x = -1
	else:
		if self.scale.x < 0:
			var aux = fwd_movement
			fwd_movement = bwd_movement
			bwd_movement = aux
		self.scale.x = 1

func _on_player_Tween_completed(object, key):
	get_parent().reset_move_array()
	#emit_signal("allow_move")

func _on_player_AnimationPlayer_finished(anim_name):
	if anim_name == "attack" or anim_name == "defense":
		$AnimationPlayer.play("SETUP")
	get_parent().reset_move_array()
	#emit_signal("allow_move")

func _on_player_Sword_body_entered(body):
	if body.get_name() == "Enemy":
		emit_signal("player_deal_damage")
		get_parent().player_score += 1
		get_parent().update_score_label()

func damage_routine():
	# tocar animações adicionais
	pass
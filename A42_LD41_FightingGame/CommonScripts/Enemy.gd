extends KinematicBody2D

export (bool) var is_active = true

export (int) var fwd_movement = 20
export (int) var bwd_movement = 10

signal enemy_deal_damage

var opponent = null

func _ready():
	connect("enemy_deal_damage", get_parent().get_node("Player"), "damage_routine")
	opponent = get_parent().get_node("Player")
	pass

func move_enemy():
	if not is_active:
		return
	if self.position.distance_to(opponent.position) >= 40:
		$Tween.interpolate_property(self, "position", position, position - Vector2(fwd_movement,0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.2)
		$Tween.start()
	else:
		$AnimationPlayer.play("attack")
	if self.position.x < opponent.position.x:
		if self.scale.x < 0:
			var aux = fwd_movement
			fwd_movement = bwd_movement
			bwd_movement = aux
		self.scale.x = 1
	else:
		if self.scale.x > 0:
			var aux = fwd_movement
			fwd_movement = bwd_movement
			bwd_movement = aux
		self.scale.x = -1

func _on_enemy_AnimationPlayer_finished(anim_name):
	if anim_name == "attack" or anim_name == "defense":
		$AnimationPlayer.play("SETUP")
	pass # replace with function body

func damage_routine():
	# tocar animações adicionais
	pass

func _on_enemy_Sword_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("enemy_deal_damage")
		get_parent().enemy_score += 1
		get_parent().update_score_label()
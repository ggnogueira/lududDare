extends Node

signal command
var queue = []
var action = null
var can_move = true

var player_score = 0
var enemy_score = 0

var moves = ["D", "A", "J", "K"]

func _ready():
	connect("command", $Player, "move_player")
	update_score_label()
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		reset_move_array()
		get_tree().reload_current_scene()
	for v in moves:
		if event.is_action_pressed(v) and can_move:
			action = v
			emit_signal("command", action)
			can_move = false
			print("inseriu")
			get_node("Enemy").move_enemy()

func reset_move_array():
	print("liberado")
	can_move = true
	action = null
	
func update_score_label():
	$HUD/HBoxContainer/ScoreLabel.text = "Player %s vs. %s Enemy" % [player_score, enemy_score]
	
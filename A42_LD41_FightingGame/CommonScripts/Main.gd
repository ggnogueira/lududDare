extends Node

signal command
var queue = []
var can_move = true

var move_character = ["W","S","A","D"]
var attack_character = ["Y","U","I"]
var deffend_character = ["H", "J", "K"]

var moves = [move_character, attack_character, deffend_character]

func _ready():
	connect("command", $Player, "set_player_queue")

func _process(delta):
	if len(queue) == 3:
		print(queue)
		emit_signal("command", queue)
		can_move = false
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		reset_move_array()
		get_tree().reload_current_scene()
	
	if len(queue) < 4:
		for m in moves:
			for v in m:
				if event.is_action_pressed(v) and can_move:
					queue.append(v)
					print("inseriu")

func reset_move_array():
	can_move = true
	queue.clear()

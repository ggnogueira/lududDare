extends Node

var list = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		list.append("ui_up")
	if event.is_action_pressed("ui_down"):
		list.append("ui_down")

func _process(delta):
	if list.size() >= 3:
		print(list)
		list.clear()

extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	pass

func _on_NewGame_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
	#get_tree().change_scene("ress://Scenes/Main.tscn")
	pass # replace with function body


func _on_Options_pressed():
	pass # replace with function body


func _on_Exit_pressed():
	pass # replace with function body

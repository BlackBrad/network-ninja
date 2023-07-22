extends Node3D


var main_menu = preload("res://scenes/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_pressed("escape_to_menu"):
			return_to_menu()

func return_to_menu():
	get_tree().quit()

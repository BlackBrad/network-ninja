extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_business_card_type(type_index):
	for child in get_children():
		child.visible = false
		
	var index = type_index - 1
	if index < get_child_count():
		get_child(index).visible = true

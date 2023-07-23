extends Node3D

const CardTypes = preload("res://scripts/card_types.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_business_card_type(card_type):
	for child in get_children():
		child.visible = false
		
	var index = 0
	match card_type:
		CardTypes.YELLOW:
			index = 0
		CardTypes.BLUE:
			index = 1
		CardTypes.GREEN:
			index = 2
		CardTypes.SEAGAL:
			index = 3
		_:
			print("Unknown card type %d" % card_type)
			index = 0
			
	if index < get_child_count():
		get_child(index).visible = true

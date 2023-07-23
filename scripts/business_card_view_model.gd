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
		
	var child = null
	match card_type:
		CardTypes.A:
			child = get_node("A")
		CardTypes.B:
			child = get_node("B")
		CardTypes.C:
			child = get_node("C")
		CardTypes.D:
			child = get_node("D")
		CardTypes.E:
			child = get_node("E")
		CardTypes.SPECIAL:
			child = get_node("Special")
		_:
			print("Unknown card type %d" % card_type)
			
	if child:
		child.visible = true

extends Area3D

const CardTypes = preload("res://scripts/card_types.gd")

var t = 0.0
@export var amplitude = 0.4
@export var frequency = 1.5
@export var card_type = CardTypes.YELLOW

func _ready():
	$Mesh.set_business_card_type(card_type)

func _process(delta):
	# Sin wave bob
	var mesh = $Mesh
	mesh.position.y = amplitude * (1.0 - cos(frequency * t))
	t += delta


func _on_body_entered(body):
	if body.is_in_group("player"):
		# TODO: Give player card back?
		print("picked up business card")
		body.pickup_card(card_type)
		queue_free()

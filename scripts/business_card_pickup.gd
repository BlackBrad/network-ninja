extends Area3D

var t = 0.0
@export var amplitude = 0.4
@export var frequency = 1.5

func _process(delta):
	# Sin wave bob
	var mesh = $Mesh
	mesh.position.y = amplitude * (1.0 - cos(frequency * t))
	t += delta


func _on_body_entered(body):
	if body.is_in_group("player"):
		# TODO: Give player card back?
		print("picked up business card")
		body.pickup_card(1)
		queue_free()

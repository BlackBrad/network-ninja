extends Area3D

var pickup_prefab = preload("res://scenes/business_card_pickup.tscn")
const CardTypes = preload("res://scripts/card_types.gd")

const GRAVITY = 3.0
const FRICTION = 0.1
const SPEED = 10.0
const ROTATION_SPEED = 5.0
var velocity = Vector3()
var acceleration = Vector3()
var _flight_time = 0.0
var card_type = CardTypes.A

@onready var trail = $WackyTrail

# Called when the node enters the scene tree for the first time.
func _ready():
	$Mesh.set_business_card_type(card_type)
	if card_type == CardTypes.SPECIAL:
		trail.visible = true
	else:
		trail.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity -= Vector3(FRICTION, FRICTION, FRICTION) * delta
	velocity += acceleration * delta
	velocity.y -= GRAVITY * delta
		
	position += velocity * delta
	
	# Face velocity (NOT WORKING!)
	#if velocity.length() > 0.1:
	#	transform.looking_at(position + velocity.normalized() * 5.0)
		
	# Spin the mesh
	$Mesh.rotate_y(-velocity.length() * delta * ROTATION_SPEED)
	
	_flight_time += delta


func _on_body_entered(body):
	if body.is_in_group("attendees"):
		get_node("/root/ScoringSystem").add_card_flight_time(_flight_time * max(acceleration.length() * 5, 1))
		body.play_random_voice()
		if card_type == CardTypes.SPECIAL:
			if not body.is_networked:
				body.set_is_networked(true)
#	else:
#		pickup_prefab.instantiate()
#		# FIXME: Don't hard-code this, need to spawn the nodes under something in all our levels
#		var root = get_node("/root/test_level")
#		# TODO: Do we need to look at pooling these for perf
#		var instance = pickup_prefab.instantiate()
#		instance.card_type = card_type
#		root.add_child(instance)
#		instance.global_position = global_position

	
	queue_free()

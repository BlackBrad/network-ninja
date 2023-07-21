extends Area3D

const GRAVITY = 3.0
const FRICTION = 0.1
const SPEED = 10.0
const ROTATION_SPEED = 5.0
var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity -= Vector3(FRICTION, FRICTION, FRICTION) * delta
	velocity.y -= GRAVITY * delta
		
	position += velocity * delta
	
	# Face velocity (NOT WORKING!)
	if velocity.length() > 0.1:
		transform.looking_at(position + velocity.normalized() * 5.0)
		
	# Spin the mesh
	$Mesh.rotate_y(-velocity.length() * delta * ROTATION_SPEED)


func _on_body_entered(body):
	if body.is_in_group("attendees"):
		print("hit attendee")
		body.queue_free()

extends Area3D

var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	
	# Face velocity (NOT WORKING!)
	if velocity.length() > 0.1:
		transform.looking_at(position + velocity.normalized() * 5.0)

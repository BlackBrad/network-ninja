extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var _input_dir = Vector2(0, 0)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = (transform.basis * Vector3(_input_dir.x, 0, _input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Face direction of motion
	if Vector3(velocity.x, 0.0, velocity.z).length() > 0.2:
		$Mesh.look_at($Mesh.global_position - velocity.normalized())


func _on_timer_timeout():
	if velocity.length() > 0.1:
		_input_dir = Vector2(0, 0)
	else:
		_input_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	$Timer.wait_time = randf_range(1, 5)

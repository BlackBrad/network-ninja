extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.01
var business_card_prefab = preload("res://scenes/business_card.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

		var pivot = $Pivot
		pivot.rotation.x = clamp(pivot.rotation.x - event.relative.y * MOUSE_SENSITIVITY, -0.5 * PI, 0.5 * PI)

func handle_business_card():
	print("spawning business card")
	# FIXME: Don't hard-code this, need to spawn the nodes under something in all our levels
	var root = get_node("/root/test_level")
	# TODO: Do we need to look at pooling these for perf
	var instance = business_card_prefab.instantiate()
	root.add_child(instance)
	var spawner = $Pivot/Camera3D/CardEmitter
	instance.global_position = spawner.global_position
	
	var forward = -spawner.global_transform.basis.z
	instance.velocity = forward * instance.SPEED + velocity

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("fire"):
		handle_business_card()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

extends CharacterBody3D

const CardTypes = preload("res://scripts/card_types.gd")

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.01
var business_card_prefab = preload("res://scenes/business_card.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _start_drag = Vector2()
var _end_drag = Vector2()
var _relative_mouse_motion = Vector2()

var hand = [CardTypes.A, CardTypes.EMPTY,CardTypes.EMPTY,CardTypes.EMPTY,CardTypes.EMPTY]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	update_hand([CardTypes.A, CardTypes.B, CardTypes.C, CardTypes.D, CardTypes.SPECIAL])
		
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

		var pivot = $Pivot
		pivot.rotation.x = clamp(pivot.rotation.x - event.relative.y * MOUSE_SENSITIVITY, -0.5 * PI, 0.5 * PI)

		_relative_mouse_motion = event.relative * MOUSE_SENSITIVITY


func handle_business_card():
	# Update hand
	var new_hand = hand
	var card_type = new_hand.pop_front()
	if not card_type:
		card_type = CardTypes.A # If player hand empty spawn default card type
	var last_card = new_hand.back()
	var new_card = randi_range(CardTypes.A, CardTypes.SPECIAL)
	while new_card == last_card:
		new_card = randi_range(CardTypes.A, CardTypes.SPECIAL)
	new_hand.append(new_card)
	update_hand(new_hand)
	
	print("spawning business card")
	
	# FIXME: Don't hard-code this, need to spawn the nodes under something in all our levels
	var root = get_node("/root/test_level")
	# TODO: Do we need to look at pooling these for perf
	var instance = business_card_prefab.instantiate()
	instance.card_type = card_type
	root.add_child(instance)
	var spawner = $Pivot/Camera3D/CardEmitter
	instance.global_position = spawner.global_position
	
	var forward = -spawner.global_transform.basis.z
	var right = spawner.global_transform.basis.x
	instance.velocity = forward * instance.SPEED + velocity
	
	var rel = _end_drag - _start_drag
	print("%f %f" % [rel.x, rel.y])
	instance.acceleration = right * rel.x * -1000.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("fire"):
		_start_drag = _relative_mouse_motion
	if Input.is_action_just_released("fire"):
		$ThrowCard.play()
		_end_drag = _relative_mouse_motion
		handle_business_card()
		
	if Input.is_action_just_pressed("trigger_seagal"):
		# FIXME: Don't hard-code this, need to spawn the nodes under something in all our levels
		var hud = get_node("/root/test_level/hud")
		hud._on_level_timer_timeout()

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

func update_hand(new_hand):
	assert(new_hand.size() == 5)
	
	# Hide hand
	for child in $Pivot/LeftArm.get_children():
		child.visible = false
		
	# Hide active
	var active_card = $Pivot/RightArm.get_child(0)
	active_card.visible = false
	
	# Update active
	if new_hand[0] != CardTypes.EMPTY:
		active_card.visible = true
		active_card.set_business_card_type(new_hand[0])
	
	# Update hand
	for i in range(1,5):
		var card_type = new_hand[i]
		if card_type != 0:
			var child = $Pivot/LeftArm.get_child(i-1)
			if child:
				child.visible = true
				child.set_business_card_type(card_type)

	hand = new_hand

func pickup_card(card_type):
	# Find first 0 slot in hand
	var index = hand.find(CardTypes.EMPTY)
	if index >= 0:
		var new_hand = hand
		new_hand[index] = card_type
		update_hand(new_hand)
		
	$SuckCard.play()

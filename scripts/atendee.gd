extends CharacterBody3D

var atendee_rigid_body_prefab = preload("res://scenes/atendee_rigid_body.tscn")

const SPEED = 2.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var mesh = $VariantController

var _input_dir = Vector2(0, 0)
var is_networked = false
var is_observing = false
var target_to_observe = null

var variant = 0

func _ready():
	update_is_networked()
	variant = randi_range(0, 4)
	mesh.variant = variant
	mesh.update_mesh()
	
func set_is_networked(networked):
	is_networked = networked
	update_is_networked()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_observing:
		if target_to_observe == null:
			# Find nearest attendee who is networked
			var taken_attendees = get_tree().get_nodes_in_group("taken_attendees")
			var closest = null
			var closest_dist = 1000.0
			for attendee in taken_attendees:
				var dist = (attendee.global_position - global_position).length()
				if dist < closest_dist:
					closest = attendee
					closest_dist = dist
			
			# Set to target to observe
			target_to_observe = closest
			
		# Zero velocity
		velocity.x = 0
		velocity.z = 0
		
		# Stop moving animation
		mesh.stop_moving()
		
		# Look at target to observe in horror
		if target_to_observe:
			mesh.look_at(target_to_observe.global_position, Vector3.UP, true)
			mesh.rotation.x = 0.0
			mesh.rotation.z = 0.0
	else:
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
			mesh.look_at(mesh.global_position - velocity.normalized())


func _on_timer_timeout():
	if velocity.length() > 0.1:
		_input_dir = Vector2(0, 0)
		mesh.stop_moving()
	else:
		_input_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		mesh.start_moving()
	
	$Timer.wait_time = randf_range(1, 5)
	
func _on_seagal():
	if is_networked:
		replace_with_rigid_body()
		var score_system = get_node("/root/ScoringSystem")
		score_system.add_networked_attendee()
	else:
		is_observing = true

func update_is_networked():
	$NetworkedVisualization.visible = is_networked
	
func replace_with_rigid_body():
	var attendee_rigid_body = atendee_rigid_body_prefab.instantiate()
	attendee_rigid_body.variant = variant
	get_parent().add_child(attendee_rigid_body)
	attendee_rigid_body.transform = transform
	attendee_rigid_body.set_state(mesh.transform)
	attendee_rigid_body.add_to_group("taken_attendees")
	queue_free()

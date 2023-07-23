extends RigidBody3D

@onready var mesh = $VariantController
var variant = 0

func _ready():
	mesh.variant = variant
	mesh.update_mesh()
	
func set_state(transform):
	mesh.transform = transform
	mesh.start_panic()
	
func _physics_process(delta):
	var pull_point = get_node("/root/test_level/pull_point").global_position
	var diff = pull_point - global_position
	var direction = diff.normalized()
	apply_force(direction * 1000, $PullPoint.position)

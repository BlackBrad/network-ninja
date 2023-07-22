extends RigidBody3D

func _physics_process(delta):
	var pull_point = get_node("/root/test_level/pull_point").global_position
	var diff = pull_point - global_position
	var direction = diff.normalized()
	apply_force(direction * 1000, $PullPoint.position)

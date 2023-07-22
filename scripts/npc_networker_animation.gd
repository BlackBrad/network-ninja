extends Node3D

# TODO: Replace this all with an animation tree
func start_moving():
	$AnimationPlayer.play("shuffle")
	
func start_panic():
	$AnimationPlayer.play("shuffle", -1, 4.0)
	
func stop_moving():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("RESET")

extends Timer

func _process(delta):
	get_node("../hud").set_time_remaining(time_left)

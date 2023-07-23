extends Timer

func _ready():
	timeout.connect(get_node("/root/ScoringSystem").on_restart)

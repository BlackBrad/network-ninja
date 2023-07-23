extends Node2D

func _ready():
	var scoring_system = get_node("/root/ScoringSystem")
	scoring_system.hud = self

func set_score(score):
	$ScoreLabel.text = "Score %d" % score

func set_time_remaining(time):
	$TimeLabel.text = "Time Remaining %ds" % time
	
func _on_level_timer_timeout():
	get_tree().call_group("attendees", "_on_seagal")
	get_tree().call_group("audio", "_on_seagal")

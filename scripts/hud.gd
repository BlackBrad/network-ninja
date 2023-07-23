extends Node2D

func _ready():
	var scoring_system = get_node("/root/ScoringSystem")
	scoring_system.hud = self

func set_score(score):
	$ScoreLabel.text = "Score %d" % score

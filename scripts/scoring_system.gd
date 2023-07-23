extends Node

var total_score = 0
var hud = null

var game_start = preload("res://scenes/test_level.tscn")

func add_card_flight_time(flight_time):
	total_score += flight_time * 10
	update_score_display()

func add_networked_attendee():
	total_score += 1000
	update_score_display()

func update_score_display():
	print("NEW SCORE: %d" % total_score)
	if hud:
		hud.set_score(total_score)

func on_restart():
	print("Restarting level")
	var scene_tree = get_tree()
	scene_tree.change_scene_to_packed(game_start)

extends Node

var total_score = 0
var hud = null

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

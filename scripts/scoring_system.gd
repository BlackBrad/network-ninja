extends Node

var total_score = 0

func add_card_flight_time(flight_time):
	total_score += flight_time * 10
	print("NEW SCORE: %d" % total_score)

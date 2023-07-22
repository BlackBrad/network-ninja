extends Node

var file_names = [
    "data_never_lies.mp3"
    "lets_do_a_buisness.mp3"
    "pin_in_it.mp3"
    "teamwork_makes_the_dreamwork.mp3"
    "dont_impress_me_much.mp3"
    "lovely_weather.mp3"
    "piece_of_onions.mp3"
    "the_more_the_merrier.mp3"
    "door_is_always_open.mp3"
    "monkey_in_silk.mp3"
    "raise_the_bar.mp3"
    "win_win_situation.mp3"
    "if_it_is_as_it_is.mp3"
    "only_words.mp3"
    "take_this_offline.mp3"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer((file.get_length()))
	return sound

func play_random_voice():
	var random_number_gen = RandomNumberGenerator.new()
	var index_to_voices = random_number_gen.randi_range(0, file_names.size())
	var sound = load_mp3(file_names[index_to_voices])
	var StreamPlayer = AudioStreamPlayer.new()
	StreamPlayer.stream = sound
	StreamPlayer.play()

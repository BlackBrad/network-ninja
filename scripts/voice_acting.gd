extends Node

var file_names = [
	"do_a_buisness.mp3",
	"lovely_weather.mp3",
	"the_more_the_merrier.mp3",
	"win_win_situation.mp3",
	"take_this_offline.mp3",
	"put_a_pin_in_it.mp3",
	"door_always_open.mp3",
	"if_it_is_like_as_it_is.mp3",
	"they_are_only_words.mp3",
	"the_data_never_lies.mp3",
	"teamwork_dreamwork.mp3",
	"ill_run_the_numbers.mp3",
	"too_much_percent.mp3",
	"we_re_going_to_raise_the_bar.mp3",
	"monetise_it.mp3",
	"impress_me.mp3",
	"price_of_onions.mp3",
	"take_an_arm.mp3",
	"monkey_silk"
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

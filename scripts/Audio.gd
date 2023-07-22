extends Node

func _on_seagal():
	$Background.stop()
	$"War Horn".play()
	#play_random_voice()

var file_names = [
	"data_never_lies.mp3",
	"lets_do_a_buisness.mp3",
	"pin_in_it.mp3",
	"teamwork_makes_the_dreamwork.mp3",
	"dont_impress_me_much.mp3",
	"lovely_weather.mp3",
	"price_of_onions.mp3",
	"the_more_the_merrier.mp3",
	"door_is_always_open.mp3",
	"monkey_in_silk.mp3",
	"raise_the_bar.mp3",
	"win_win_situation.mp3",
	"if_it_is_like_as_it_is.mp3",
	"only_words.mp3",
	"take_this_offline.mp3",
]

var file_path = "audio/voices/bitcrushed/%s"

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer((file.get_length()))
	return sound

func play_random_voice():
	var random_number_gen = RandomNumberGenerator.new()
	var index_to_voices = random_number_gen.randi_range(0, file_names.size())
	var sound = load_mp3(file_path % file_names[index_to_voices])
	var StreamPlayer = AudioStreamPlayer.new()
	StreamPlayer.set_stream(sound)
	StreamPlayer.set_volume_db(100)
	StreamPlayer.play()

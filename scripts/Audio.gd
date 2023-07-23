extends Node

func _on_seagal():
	$Background.stop()
	$"War Horn".play()
	#play_random_voice()

var file_names = [
	"lets_do_a_business.mp3",
	"lets_put_a_pin_in_it.mp3",
	"teamwork_makes_the_dreamwork.mp3",
	"that_dont_impress_me_much.mp3",
	"lovely_weather.mp3",
	"price_of_onions.mp3",
	"the_more_the_merrier.mp3",
	"were_going_to_raise_the_bar.mp3",
	"win_win_situation.mp3",
	"if_it_is_as_it_is.mp3",
	"they_are_only_words.mp3",
	"take_this_offline.mp3",
	"better_come_back_round.mp3",
	"ill_run_the_numbers.mp3",
	"lets_take_this_offline.mp3",
	"monkey_dressed_in_silk.mp3",
	"my_door_is_always_open.mp3",
	"the_data_never_lies.mp3"
]

var file_path = "audio/voices/bitcrushed-rerecorded/%s"

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var sound = AudioStreamMP3.new()
		sound.data = file.get_buffer((file.get_length()))
		return sound

func play_random_voice():
	var random_number_gen = RandomNumberGenerator.new()
	var index_to_voices = random_number_gen.randi_range(0, file_names.size() - 1)
	var sound = load_mp3(file_path % file_names[index_to_voices])
	print(file_path % file_names[index_to_voices])
	if sound:
		var StreamPlayer = $VoicePlayer
		StreamPlayer.set_stream(sound)
		StreamPlayer.set_volume_db(20)
		StreamPlayer.play()

func _process(delta):
	if Input.is_action_just_pressed("debug_random_voice"):
		play_random_voice()

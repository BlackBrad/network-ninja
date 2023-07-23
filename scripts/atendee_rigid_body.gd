extends RigidBody3D

@onready var mesh = $VariantController
var variant = 0

func _ready():
	mesh.variant = variant
	mesh.update_mesh()
	play_random_scream()
	
func set_state(transform):
	mesh.transform = transform
	mesh.start_panic()
	
func _physics_process(delta):
	var pull_point = get_node("/root/test_level/pull_point").global_position
	var diff = pull_point - global_position
	var direction = diff.normalized()
	apply_force(direction * 1000, $PullPoint.position)

var screaming_voice_files = [
	"god_why.mp3",
	"but_were_business_partners.mp3",
	"ill_never_cheat_again.mp3",
	"i_thought_we_had_a_deal.mp3",
	"please_help.mp3",
	"sad_scream.mp3"
]

var scream_file_path = "audio/sound_effects/%s"

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var sound = AudioStreamMP3.new()
		sound.data = file.get_buffer((file.get_length()))
		return sound

func play_random_scream():
	print("RANDOM SCREAM")
	var random_number_gen = RandomNumberGenerator.new()
	var index_to_voices = random_number_gen.randi_range(0, screaming_voice_files.size() - 1)
	var sound = load_mp3(scream_file_path % screaming_voice_files[index_to_voices])
	print(scream_file_path % screaming_voice_files[index_to_voices])
	if sound:
		$Scream.set_stream(sound)
		$Scream.set_volume_db(8)
		$Scream.play()
	else:
		print("BRADLEY BAD FILE %s" % scream_file_path % screaming_voice_files[index_to_voices])
	

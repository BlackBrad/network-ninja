extends Control


var game_start = preload("res://scenes/test_level.tscn")

var settings_file = ConfigFile.new()

var audio_settings: Vector3 = Vector3(50.0, 50.0, 50.0)

@onready var option_menu_container = get_node("OptionMenuContainer")
@onready var main_menu_container = get_node("MainMenuContainer")
# Called when the node enters the scene tree for the first time.
func _ready():
	_load_settings()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	var scene_tree = get_tree()
	scene_tree.change_scene_to_packed(game_start)

func _on_options_button_pressed():
	option_menu_container.visible = true
	main_menu_container.visible = false

func _save_settings():
	settings_file.set_value("AUDIO","Master",audio_settings.x)
	settings_file.set_value("AUDIO","Music",audio_settings.y)
	settings_file.set_value("AUDIO","SFX",audio_settings.z)
	settings_file.save("res://settings.cfg")
	
func _load_settings():
	if (settings_file.load("res://settings.cfg") != OK):
		_save_settings()
	else:
		pass

func _on_exit_game_button_pressed():
	get_tree().quit()

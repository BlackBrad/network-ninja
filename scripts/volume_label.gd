extends Label

func _ready():
	self.text = str(round(get_parent().value)) + "%"

func _on_h_scroll_bar_value_changed(value):
	self.text = str(round(value)) + "%"

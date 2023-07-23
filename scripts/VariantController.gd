extends Node3D

@export var variant = 0

func _ready():
	update_mesh()

func update_mesh():
	for child in get_children():
		child.visible = false
		
	var child = get_child(variant)
	if child:
		child.visible = true
		

func stop_moving():
	var child = get_child(variant)
	if child:
		child.stop_moving()
	
func start_moving():
	var child = get_child(variant)
	if child:
		child.start_moving()

func start_panic():
	var child = get_child(variant)
	if child:
		child.start_panic()

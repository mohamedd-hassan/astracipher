extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label: Label = null

const BASE_TEXT = "[E] to "

var active_areas = []
var can_interact = true

func _ready():
	label = Label.new()
	label.name = "Label"
	add_child(label)
	get_tree().root.add_child(label)  # Add it to the scene tree

	get_tree().node_added.connect(func(_node):
		player = get_tree().get_first_node_in_group("player")
	)

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = BASE_TEXT + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x/2
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("interact_npc") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			can_interact = true
	
	
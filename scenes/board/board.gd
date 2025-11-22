extends TileMapLayer

@onready var pathFinder = preload("res://scenes/board/pathfinding.gd").new()
@export var highlight_layer: TileMapLayer;

signal cell_clicked(cell: Vector2i)
signal player_clicked(player: Player)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left_click"):
		var global_pos = get_global_mouse_position()
		var cell = local_to_map(to_local(global_pos))
		var player: Player = _get_player_on_cell(cell)
		print(player)
		if player:
			emit_signal('player_clicked', player)
		else:
			print(cell)
			emit_signal('cell_clicked', cell)

func highlight_cells(start_cell: Vector2i, steps: int)-> Array[Vector2i]:
	var destinations: Array[Vector2i] = pathFinder.generate_destinations(self, start_cell, steps)
	for cell in destinations:
		highlight_layer.set_cell(cell, 0, Vector2i(0,0))
	return destinations

func reset_cells():
	highlight_layer.clear()


# find a more optimized way to do this if it exists
func _get_player_on_cell(cell: Vector2i) -> Player:
	# print("cell from input is ", cell)
	# print(get_tree().get_nodes_in_group("players"))
	for p: Player in get_tree().get_nodes_in_group("players"):
		print(p.current_cell)
		if p.current_cell == cell:
			return p
	return null
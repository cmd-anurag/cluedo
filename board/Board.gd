extends TileMapLayer

@onready var pathFinder = preload("res://board/Pathfinding.gd").new();
signal cell_clicked(cell: Vector2i);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left_click"):
		var global_pos = get_global_mouse_position();
		var cell = local_to_map(to_local(global_pos))
		emit_signal('cell_clicked', cell);

func highlight_destinations(start_cell: Vector2i, steps: int)->void:
	var destinations = pathFinder.generate_destinations(self, start_cell, steps);
	for cell in destinations:
		set_cell(cell, 0, Vector2i(0,0))
	

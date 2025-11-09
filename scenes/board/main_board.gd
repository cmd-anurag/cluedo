extends TileMapLayer

var player : Sprite2D
var target : Vector2

func _ready() -> void:
	player = $"../player_blue"
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("mouse_left_click")):
		target = get_global_mouse_position()
		print(target)
		print(local_to_map(to_local(target)))

		player.position = to_global(map_to_local(local_to_map(to_local(target))))

		var start_cell = local_to_map(to_local(target)) 


		var destinations = generate_destinations(start_cell, 5)
		for cell in destinations:
			set_cell(cell, 0, Vector2i(0,0))
			print(cell)



func generate_destinations(start: Vector2i, N: int) -> Array:
	var queue: Array = []
	var visited := {}
	var results: Array = []

	var dirs = [
		Vector2i(0, -1),
		Vector2i(0, 1),
		Vector2i(1, 0),
		Vector2i(-1, 0),
	]

	for d in dirs:
		var nb = start + d
		if nb.x < 0 or nb.y < 0 or nb.x >= 21 or nb.y >= 21:
			continue

		var td = get_cell_tile_data(nb)
		if td == null or not td.get_custom_data("is_walkable"):
			continue

		visited[nb] = true
		queue.append({"cell": nb, "depth": 1})

	while queue.size() > 0:
		var item = queue.pop_front()
		var cell: Vector2i = item["cell"]
		var depth: int = item["depth"]

		var td = get_cell_tile_data(cell)
		var is_door = td.get_custom_data("is_door")

		if is_door:
			if depth <= N:
				results.append(cell)
			continue

		if depth == N:
			results.append(cell)
			continue

		for d in dirs:
			var nb = cell + d
			if nb.x < 0 or nb.y < 0 or nb.x >= 21 or nb.y >= 21:
				continue
			if visited.has(nb):
				continue

			var data = get_cell_tile_data(nb)
			if data == null or not data.get_custom_data("is_walkable"):
				continue

			visited[nb] = true
			queue.append({"cell": nb, "depth": depth + 1})

	return results

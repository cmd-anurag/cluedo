extends TileMapLayer

var player : Sprite2D
var target : Vector2
var target2 : Vector2
var destinations: Array

func _ready() -> void:
	player = $"../player_blue"
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("mouse_left_click")):
		target = get_global_mouse_position()
		print(target)
		print(local_to_map(to_local(target)))

		player.position = to_global(map_to_local(local_to_map(to_local(target))))

		var start_cell = local_to_map(to_local(target)) 

		# generate possible paths 
		var all_paths: Array = []
		var visited: Array = []
		
		# gds does not have a 2d array
		for y in range(21):
			visited.append([])
			for x in range(21):
				visited[y].append(false)

		generatePaths([], start_cell, visited, all_paths);
		# print(all_paths);
		for path in all_paths:
			var destination = path[-1]
			# destinations.append(destination)
			var atlasCoords = Vector2i(0, 0)
			set_cell(destination, 0, atlasCoords);
			print(destination)
	elif(event.is_action_pressed("scroll_down")):
		target = to_local(get_global_mouse_position())
		$"../../BoardView".scale.x -= 0.1;
		$"../../BoardView".scale.y -= 0.1;
		print($"../../BoardView".offset)
		target2 = to_local(get_global_mouse_position())
		$"../../BoardView".offset.x -= target.x-target2.x;
		$"../../BoardView".offset.y -= target.y-target2.y;
		print($"../../BoardView".offset)
		
	elif(event.is_action_pressed("Scroll_up")):
		target = to_local(get_global_mouse_position())
		$"../../BoardView".scale.x += 0.1;
		$"../../BoardView".scale.y += 0.1;
		print($"../../BoardView".offset)
		target2 = to_local(get_global_mouse_position())
		$"../../BoardView".offset.x -= target.x-target2.x;
		$"../../BoardView".offset.y -= target.y-target2.y;
		print($"../../BoardView".offset)
			

func generatePaths(path: Array, current_cell: Vector2i, visited: Array, all_paths: Array) -> void:
	path.append(current_cell)
	visited[current_cell.y][current_cell.x] = true;

	if path.size() == 4: # CHANGE THIS LATER
		all_paths.append(path.duplicate())
		return
	else:
		var directions = [
			Vector2i(0, -1), # north
			Vector2i(0, 1),  # south
			Vector2i(1, 0),  # east
			Vector2i(-1, 0), # west
		];

		for direction in directions:
			var next: Vector2i = current_cell + direction
			if next.x >= 0 and next.y >= 0 and next.x < 21 and next.y < 21 and not visited[next.y][next.x]:
				generatePaths(path.duplicate(), next, visited, all_paths)
		
		visited[current_cell.y][current_cell.x] = false;

# func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
# 	for destination in destinations:
# 		if(destination.x == coords.x and destination.y == coords.y):
# 			return 1
# 	return 0

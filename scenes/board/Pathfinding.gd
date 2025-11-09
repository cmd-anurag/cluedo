extends Node

func generate_destinations(tilemap: TileMapLayer, start: Vector2i, N: int) -> Array:
    var queue: Array = []
    var visited := {}
    var results: Array = []
    var dirs = [Vector2i(0, -1), Vector2i(0, 1), Vector2i(1, 0), Vector2i(-1, 0)]

    for d in dirs:
        var nb = start + d
        if not is_valid(tilemap, nb): continue
        visited[nb] = true
        queue.append({"cell": nb, "depth": 1})

    while queue.size() > 0:
        var item = queue.pop_front()
        var cell: Vector2i = item["cell"]
        var depth: int = item["depth"]

        var td = tilemap.get_cell_tile_data(cell)
        if td.get_custom_data("is_door"):
            if depth <= N:
                results.append(cell)
            continue
        if depth == N:
            results.append(cell)
            continue

        for d in dirs:
            var nb = cell + d
            if not is_valid(tilemap, nb) or visited.has(nb): continue
            visited[nb] = true
            queue.append({"cell": nb, "depth": depth + 1})
            
    return results

func is_valid(tilemap, cell: Vector2i) -> bool:
    if cell.x < 0 or cell.y < 0 or cell.x >= 25 or cell.y >= 25:
        return false
    var data = tilemap.get_cell_tile_data(cell)
    return data != null and data.get_custom_data("is_walkable")

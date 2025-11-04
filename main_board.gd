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
		

class_name Player

extends Node2D

var current_cell: Vector2i
var is_active: bool= false
var playername: String
@export var steps: int = 5

func _ready() -> void:
	add_to_group("players")

func set_sprite_texture(texture: Texture2D):
	var sprite = get_node("PlayerSprite") as Sprite2D
	sprite.texture = texture

func start_turn():
	is_active = true
	print(playername + " turn started")

func end_turn():
	is_active = false
	print(playername + "turn ended")


func move_to_cell(board: TileMapLayer, cell: Vector2i):
	if not is_active:
		return
	print(playername + " moved to cell: ", cell)
	var updated_board_position = board.to_global(board.map_to_local(cell))

	self.position = updated_board_position
	self.current_cell = cell

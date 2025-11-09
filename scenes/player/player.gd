class_name Player

extends Node2D

var current_cell: Vector2i
var is_active: bool= false
var playername: String
@export var steps: int = 5

func set_sprite_texture(texture: Texture2D):
	var sprite = get_node("PlayerSprite") as Sprite2D
	sprite.texture = texture

func start_turn():
	is_active = true
	print(playername + " turn started")

func end_turn():
	is_active = false
	print(playername + "turn ended")


func on_cell_clicked(board: TileMapLayer, cell: Vector2i):
	if not is_active:
		return
	print(playername + " clicked on cell: ", cell)
	var updated_board_position = board.to_global(board.map_to_local(cell))
	print("Updated board position : ", updated_board_position)
	self.position = updated_board_position
	board.highlight_destinations(cell, steps)

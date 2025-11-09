extends Node2D

@onready var board = $Board/main_board
@onready var turn_manager = $TurnManager
#@onready var player1 = $Player1
#@onready var player2 = $Player2

var player = preload("res://scenes/player/player.tscn")
var blue_player_texture = preload("res://data/player/player_blue_sprite.png")
var red_player_texture = preload("res://data/player/player_red_sprite.png")

func _ready() -> void:
	var player1 : Player = player.instantiate()
	player1.playername = "John"
	#player1.get_node()
	player1.set_sprite_texture(blue_player_texture)
	#player1.hide()
	add_child(player1)
	
	var player2 : Player = player.instantiate()
	player2.playername = "Doe"
	player2.set_sprite_texture(red_player_texture)
	#player2.hide()
	add_child(player2)

	board.cell_clicked.connect(cell_clicked_handler)
	var players: Array[Player] = [player1, player2]
	turn_manager.start_game(players)

func cell_clicked_handler(cell: Vector2i):
	var current_player: Player = turn_manager.get_current_player()
	current_player.on_cell_clicked(board, cell)
	turn_manager.next_turn()

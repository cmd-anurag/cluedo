extends Node2D

@onready var board = $Board/main_board
@onready var turn_manager = $TurnManager
#@onready var player1 = $Player1
#@onready var player2 = $Player2

var player = preload("res://scenes/player/player.tscn")

func _ready() -> void:
	var player1 : Player = player.instantiate() as Player
	player1.playername = "John"
	add_child(player1)
	
	var player2 : Player = player.instantiate() as Player
	player2.playername = "Doe"
	add_child(player2)

	board.cell_clicked.connect(cell_clicked_handler)
	var players: Array[Player] = [player1, player2]
	turn_manager.start_game(players)

func cell_clicked_handler(cell: Vector2i):
	var current_player = turn_manager.get_current_player()
	current_player.on_cell_clicked(board, cell)
	turn_manager.next_turn()

extends Node2D

@onready var board = $Board/main_board
@onready var turn_manager = $TurnManager
@onready var player1 = $Player1
@onready var player2 = $Player2

func _ready() -> void:
	player1.playername = "John";
	player2.playername = "Doe";

	board.cell_clicked.connect(cell_clicked_handler);
	turn_manager.start_game([player1, player2]);

func cell_clicked_handler(cell: Vector2i):
	var current_player = turn_manager.get_current_player()
	current_player.on_cell_clicked(board, cell)
	turn_manager.next_turn()

extends Node

enum State {
	IDLE,
	AWAIT_MOVE,
} # naming things are tough, feel free to change the state names


var state := State.IDLE
var selectedPlayer: Player = null
var validCells: Array[Vector2i] = []
var players: Array[Player] = []
var currentIndex := 0

@onready var board: TileMapLayer = get_node("../Board/main_board");

func _ready() -> void:
	board.player_clicked.connect(_player_clicked_handler)
	board.cell_clicked.connect(_cell_clicked_handler)
	

func start_game(player_list: Array[Player]):
	players = player_list
	currentIndex = 0
	players[currentIndex].start_turn()

func next_turn():
	players[currentIndex].end_turn()
	currentIndex = (currentIndex + 1) % players.size()
	players[currentIndex].start_turn()

func get_current_player() -> Player:
	return players[currentIndex]


func _player_clicked_handler(player: Player) -> void:
	if state != State.IDLE:
		return
	var current_player := self.get_current_player()
	if player != current_player:
		return
	selectedPlayer = current_player

	validCells = board.highlight_cells(current_player.current_cell, 5)
	state = State.AWAIT_MOVE

func _cell_clicked_handler(cell: Vector2i) -> void:
	if state != State.AWAIT_MOVE:
		return

	if cell not in validCells:
		return
	
	selectedPlayer.move_to_cell(board, cell)

	
	# board.reset_cells(validCells) yet to be implemented
	validCells.clear()
	selectedPlayer = null
	next_turn()
	state = State.IDLE
	

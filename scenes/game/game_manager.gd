extends Node2D

@onready var board = $Board/main_board
@onready var turn_manager = $TurnManager


var player = preload("res://scenes/player/player.tscn")
var blue_player_texture = preload("res://data/player/player_blue_sprite.png")
var red_player_texture = preload("res://data/player/player_red_sprite.png")

func _ready() -> void:
	var player1 : Player = player.instantiate()
	player1.playername = "John"
	player1.set_sprite_texture(blue_player_texture)
	#player1.hide()
	add_child(player1)
	# temp "start" square , todo - find a clean way to do this
	var startSquare1 =  Vector2i(8, 24)
	player1.position = board.to_global(board.map_to_local(startSquare1))
	player1.current_cell = startSquare1

	var player2 : Player = player.instantiate()
	player2.playername = "Doe"
	player2.set_sprite_texture(red_player_texture)
	#player2.hide()
	add_child(player2)
	var startSquare2 = Vector2i(17, 24)
	player2.position = board.to_global(board.map_to_local(startSquare2))
	player2.current_cell = startSquare2
	
	var players: Array[Player] = [player1, player2]
	turn_manager.start_game(players)

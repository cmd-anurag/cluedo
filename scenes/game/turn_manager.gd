extends Node

var players: Array[Player] = []
var currentIndex := 0

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

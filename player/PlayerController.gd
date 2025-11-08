extends Node2D

var current_cell: Vector2i
var is_active: bool= false;
var playername: String;

@export var steps: int = 5;

func start_turn():
    is_active = true;
    print(playername + " turn started");

func end_turn():
    is_active = false;
    print(playername + "turn ended");


func on_cell_clicked(board, cell: Vector2i):
    if not is_active:
        return;
    print(playername + " clicked on cell: ", cell)
    board.highlight_destinations(cell, steps);
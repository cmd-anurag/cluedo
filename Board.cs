using Godot;
using System;
using System.Collections.Generic;

public partial class Board : TileMapLayer
{
	private Vector2 _target;
	private List<Sprite2D> player;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		player = new List<Sprite2D>();
		player.Add(GetNode<Sprite2D>("../Player"));
	}
	public override void _Input(InputEvent @event)
	{
		// Use IsActionPressed to only accept single taps as input instead of mouse drags.
		if (@event.IsActionPressed("click"))
		{
			_target = GetGlobalMousePosition();
			GD.Print(LocalToMap(ToLocal(_target)));
			// f
			player[0].Position = ToGlobal(MapToLocal(LocalToMap(ToLocal(_target))));
			 
		}
	}
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}

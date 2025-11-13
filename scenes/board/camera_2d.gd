extends Camera2D

const ZOOM_SPEED = 1.1
var is_panning = false
var pan_start_position

func _input(event):
	if event.is_action_pressed("scroll_up"):
		zoom_at_mouse(ZOOM_SPEED)
	elif event.is_action_pressed("scroll_down"):
		zoom_at_mouse(1.0 / ZOOM_SPEED)
	elif event.is_action_pressed("middle_click"):
		is_panning = true
		pan_start_position = get_viewport().get_mouse_position()
	elif event.is_action_released("middle_click"):
		is_panning = false

func zoom_at_mouse(scale_factor: float):
	var mouse_world_pos_before = get_global_mouse_position()
	var new_zoom = self.zoom * Vector2.ONE * scale_factor
	self.zoom = clamp(new_zoom,Vector2(1,1),Vector2(4,4))
	var mouse_world_pos_after = get_global_mouse_position()
	var translation_needed = mouse_world_pos_before - mouse_world_pos_after
	self.position += translation_needed

func mouse_panning_handler(panning: bool):
	if panning:
		var current_mouse_position = get_viewport().get_mouse_position()
		var screen_delta = current_mouse_position - pan_start_position
		var canvas_transform = get_viewport().get_canvas_transform()
		var screen_to_world_matrix = canvas_transform.affine_inverse()
		var world_delta = screen_to_world_matrix.basis_xform(screen_delta)
		self.position -= world_delta
		pan_start_position = current_mouse_position

func _process(_delta: float) -> void:
	mouse_panning_handler(is_panning)

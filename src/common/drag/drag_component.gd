extends Area2D

@export
var need_drag: Node2D
@export 
var start_offst: Vector2

var is_drag: bool = false
var offset: Vector2 = Vector2.ZERO

signal position_event

func _process(delta: float) -> void:
	if is_drag:
		var new_position = need_drag.get_global_mouse_position() - start_offst
		position_event.emit(new_position)
		pass

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			is_drag = true
		else:
			is_drag = false

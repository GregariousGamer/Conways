extends ColorRect

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# catches event that happens inside Area2D which is left mouse click
	if (event is InputEventMouseButton && event.pressed):
		var block_id: int = get_instance_id()
		SignalManager.change_color.emit(block_id)
